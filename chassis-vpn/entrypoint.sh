#!/bin/sh
newbridge () {
  # name, id

  echo "Device: $1, id: $2"

  openvpn --mktun --dev tap$2
  ip link add name br$2 type bridge
  ip link set dev $1 master br$2
  ip link set dev tap$2 master br$2

  ip link set dev br$2 up
  ip link set dev tap$2 up
  ip link set dev br$2 promisc on
  ip link set dev tap$2 promisc on
}

echo -n "Waiting docker api proxy: "
until $(nc -z docker_api_proxy 1337); do
    echo -n '.'
    sleep 5
done
echo "done"
sleep 5

ip -4 -o addr show | cut -d' ' -f 2,7 | grep eth |
while read int addr
do
 id=$(echo $int | cut -dh -f 2)
 echo $int $addr $id
 ip addr del $addr dev $int
 ip link set dev $int promisc on
 newbridge $int $id
 ip addr add $addr dev br$id 
done

if [ -n "$GW" ]; then
  ip route add 0/0 via $GW
fi

iptables -A INPUT -i tap+ -j ACCEPT
iptables -A INPUT -i br+ -j ACCEPT
iptables -A FORWARD -i br+ -j ACCEPT

/usr/local/bin/generate.sh
cd /etc/openvpn/client
rm -f *.ovpn
cd /etc/openvpn/
rm -f *.ovpn
/usr/local/bin/config.py

l=$(ls -1 *.ovpn | tail -1)
ls -1 *.ovpn |
 while read f               
 do
  if [ "$f" != "$l" ]; then   
      openvpn --config $f &         
  fi                             
 done                               

openvpn --config $l