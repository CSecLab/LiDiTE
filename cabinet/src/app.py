import argparse
import sys
import traceback

from time import sleep
from threading import Thread

import docker

from pymodbus.server.asynchronous import StartTcpServer, StopServer
from pymodbus.datastore import ModbusSequentialDataBlock
from pymodbus.datastore import ModbusSlaveContext, ModbusServerContext

from docker_mgmt import calculate_load, start, stop

parser = argparse.ArgumentParser()

parser.add_argument('--address', type=str, dest='address', required=False, help="Specify listen address")
parser.add_argument('--breaker', dest='breaker', action='store_true', help="Enable automatic circuit breaker")
parser.add_argument('--port', type=int, dest='port', required=False, help="Specify listen port")
parser.add_argument('--verbose', dest='verbose', action='store_true', help="Enable verbose output")
parser.add_argument('-b', type=int, dest='base', required=False, help="Base consumption (W)")
parser.add_argument('-i', type=str, dest="id", required=True, help="Cabinet ID")
parser.add_argument('-l', type=int, dest='maxload', required=False, help="Max load (W)")
parser.add_argument('-r', type=int, dest="refresh", required=False, help="Refresh time (seconds)")
parser.add_argument('-u', type=str, dest="url", required=False, help="Docker url")
parser.set_defaults(address="0.0.0.0")
parser.set_defaults(base=0) # no base consumption
parser.set_defaults(breaker=False)
parser.set_defaults(maxload=0) # no max load
parser.set_defaults(port=502)
parser.set_defaults(refresh=5)
parser.set_defaults(url="unix://var/run/docker.sock")
parser.set_defaults(use_maxload=False)
parser.set_defaults(verbose=False)

args = parser.parse_args()

class ModBusExporter():
    def __init__(self):
        self.modbus_store = ModbusSlaveContext(
            # Input registers (RO, 16bit) = [ consumption, max_consumption ]
            ir=ModbusSequentialDataBlock(0, [0] * 2),
            # Coils (RW, 1bit) = [ switch, trip ]
            co=ModbusSequentialDataBlock(0, [0] * 2)
        )
        self.context = ModbusServerContext(self.modbus_store, True)

    def start_server(self):
        def start_server_inner():
            StartTcpServer(self.context, address=('0.0.0.0', 502))
        Thread(target=start_server_inner, daemon=True).start()

    def stop_server(self):
        StopServer()

    def get_consumption(self):
        return self.context[0x00].getValues(4, 0x0)

    def set_consumption(self, consumption):
        self.context[0x00].setValues(4, 0x0, [ int(consumption) ])

    def get_max_consumption(self):
        return self.context[0x00].getValues(4, 0x1)

    def set_max_consumption(self, maxconsumption):
        self.context[0x00].setValues(4, 0x1, [ int(maxconsumption) ])

    def get_switch_position(self):
        return self.context[0x00].getValues(5, 0x0)

    def set_switch_position(self, pos):
        self.context[0x00].setValues(5, 0x0, [ pos ])

    def get_tripswitch_position(self):
        return self.context[0x00].getValues(5, 0x1)

    def set_tripswitch_position(self, pos):
        self.context[0x00].setValues(5, 0x1, [ pos ])

client = docker.DockerClient(base_url=args.url)
server = ModBusExporter()

print("Start cabinet...")
server.start_server()
print("Cabinet {} started (max load: {} W), listening {}:{}.".format(args.id, args.maxload, args.address, args.port))
state = True # ON
server.set_consumption(0)
server.set_max_consumption(args.maxload)
server.set_switch_position(True)
server.set_tripswitch_position(False)
while True:
    try:
        switch = server.get_switch_position()[0]
        tripswitch = server.get_tripswitch_position()[0]
        if args.verbose:
            print('Modbus status: [sw={}, trip_sw={}], [cur={}, max={}]'.format(switch, tripswitch, server.get_consumption()[0], server.get_max_consumption()[0]))
            if tripswitch:
                print('Trip requested')
        if switch and tripswitch:
            print('Tripping')
            server.set_switch_position(0)
            continue
        if state != switch:
           state = switch
           if state:
               print("Changed: ON")
               start(client, args.id)
           else:
               print("Changed: OFF")
               server.set_consumption(0)
               stop(client, args.id)

        if state:
            load = calculate_load(client, args.id) + args.base
            if args.verbose:
                print("Total load: {} W".format(load))
            # TODO: save float
            server.set_consumption(load)

            if load > args.maxload:
                if args.verbose:
                    print("Warning! Maximum load exceeded.")
                if args.breaker:
                    print("Breaking circuits..")
                    server.set_consumption(0)
                    server.set_switch_position(0)
                    stop(client, args.id)

        sys.stdout.flush()
        sleep(args.refresh)
    except Exception as e:
        traceback.print_exc()