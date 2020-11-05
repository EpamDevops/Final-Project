#!/bin/bash
a="--all"
b="--target"
ip=`ip a | grep -v valid_lft |grep -v inet6| grep -v : |awk '{print$2}' |sed -n 2p |cut -d '.' -f -3`
if [[ $1 = $a ]]
then
for i in {1..254};
do
ping $ip.$i -c1 -w 5 > /dev/null && echo "IP:$ip.$i DNS: $(host $ip.$i | awk '{print$5}' | sed -n 1p )"& 
done
echo "Mission complete"
elif [[ $1 = $b ]]
then
echo "$(nc -z -v  $(ip a |grep inet |awk '{print $2}' |grep -v '::' |cut -d "/" -f 1 | sed -n 2p) 1-65535 2>&1 | grep succeeded)"
else
echo  "'--all' key displays the IP addresses and symbolic names of all hosts in the current subnet, '--target' key displays a list of open system TCP ports."
fi