import docker.api
import random


def calculate_load(client, id):
    load = 0
    maxLoad = 0
    minLoad = 0
    for c in client.containers.list():
        if 'fdt.cabinetID' not in c.labels:
            continue
        if c.labels['fdt.cabinetID'] != id:
            continue

        if 'fdt.maxload' in c.labels and int(c.labels['fdt.maxload']) > 0:
            maxLoad = int(c.labels['fdt.maxload'])

        if 'fdt.minload' in c.labels and int(c.labels['fdt.minload']) > 0 and int(c.labels['fdt.minload']) < maxLoad:
            minLoad = int(c.labels['fdt.minload'])

        resultCPUUsage = 0.0

        try:
            raise Exception('Client does not consume cpu atm')
            stats = c.stats(stream=False)
            cpuDelta = stats['cpu_stats']['cpu_usage']['total_usage'] - \
                stats['precpu_stats']['cpu_usage']['total_usage']
            systemDelta = stats['cpu_stats']['system_cpu_usage'] - \
                stats['precpu_stats']['system_cpu_usage']
            if cpuDelta > 0 and systemDelta > 0:
                resultCPUUsage = round(cpuDelta / systemDelta *
                                       len([x for x in (stats['cpu_stats']['cpu_usage']['percpu_usage']) if x != 0]) * 100, 2)
        except Exception:
            if not hasattr(calculate_load, 'lastCPUUsage'):
                calculate_load.lastCPUUsage = 50.0
            noise = random.gauss(0, 5)
            resultCPUUsage = round(calculate_load.lastCPUUsage + noise, 2)
            if resultCPUUsage < 0.0:
                resultCPUUsage = 0.0
            elif resultCPUUsage > 100.0:
                resultCPUUsage = 100.0
            calculate_load.lastCPUUsage = resultCPUUsage

        diff = maxLoad - minLoad
        if diff > 0:
            client_load = minLoad + (diff * resultCPUUsage/100)
            load = load + client_load
            load = round(load, 2)
            print(
                f'Load for {c.name} (min: {minLoad} W, max: {maxLoad} W, cpu: {resultCPUUsage} %) = {client_load} W')

    return load


def stop(client, id):
    for c in client.containers.list():
        if 'fdt.cabinetID' not in c.labels:
            continue
        if c.labels['fdt.cabinetID'] != id:
            continue
        if 'fdt.protected' not in c.labels:
            print("Stop: {}".format(c.name))
            c.stop()
        else:
            print("{} protected from stopping".format(c.name))


def start(client, id):
    for c in client.containers.list(all=True):
        if 'fdt.cabinetID' not in c.labels:
            continue
        if c.labels['fdt.cabinetID'] != id:
            continue
        print("Start: {}".format(c.name))
        c.start()
