#!/usr/bin/env python3

import docker
import logging
import os
import json

def cidr_to_netmask(cidr):                  
  cidr = int(cidr)                          
  mask = (0xffffffff >> (32 - cidr)) << (32 - cidr)             
  return (str( (0xff000000 & mask) >> 24)   + '.' +
          str( (0x00ff0000 & mask) >> 16)   + '.' +
          str( (0x0000ff00 & mask) >> 8)    + '.' +
          str( (0x000000ff & mask)))

client = docker.DockerClient(base_url='tcp://docker_api_proxy:1337')

brs={}                                                              
routes = json.load(os.popen('ip -j route')) 
for r in routes:                                        
    if r['dev'][:2] == 'br':                           
       brs[r['dst']] = r['dev'][2:] 

# VPN port
startport=int(os.getenv("PORT", 8000))

with open('/etc/openvpn/ca.cert') as f:
    ca = f.read()
    f.close()

with open('/etc/openvpn/client.cert') as f:
    cert = f.read()
    f.close()

with open('/etc/openvpn/client.key') as f:
    key = f.read()
    f.close()

try:
    for n in client.networks.list(filters={"label": "fdt.passthrough"}):
        logging.info(f"VPN for {n.attrs['Name']}")
        subnet = n.attrs['IPAM']['Config'][0]['Subnet']
        range = f"{'.'.join(subnet.split('/')[0].split('.')[:3])}"
        gw = n.attrs['IPAM']['Config'][0]['Gateway']
        mask = cidr_to_netmask(n.attrs['IPAM']['Config'][0]['Subnet'].split("/")[1])
        port = startport + int(brs[subnet])
        with open(f"/etc/openvpn/{n.attrs['Name']}.ovpn", "w") as f:
            vpnconfig = f"""
port {port}
dev tap{brs[subnet]}

proto tcp-server

tls-server
ca ca.cert
cert server.cert
key server.key
dh dh.pem

data-ciphers AES-128-CFB1:AES-128-CFB8
data-ciphers-fallback AES-128-CBC

mode server
duplicate-cn

# restart control
persist-key
persist-tun
ping-timer-rem
ping-restart 60
ping 10"""
            f.write(vpnconfig)
            f.close()

        with open(f"/etc/openvpn/client/{n.attrs['Name']}_client.ovpn", "w") as f:
            vpnclient = f"""
remote [IPADDR]
port {port}

dev tap
proto tcp-client
tls-client
cipher AES-128-CFB1
# change me
# ifconfig {range}.x {mask}
ifconfig-nowarn

<ca>
{ca}
</ca>
<cert>
{cert}
</cert>
<key>
{key}
</key>"""
            f.write(vpnclient)                                                    
            f.close()
except Exception as e:
        logging.error(e)