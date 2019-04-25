#!/bin/bash

for i in $(lspci -nn | grep -i Mellan | grep -i virtual | awk '{print $1}'); do
	echo "0000:$i" > /sys/bus/pci/devices/0000:$i/driver/unbind
done

x=$(lspci -nn | grep Mellan | grep -i virtual | head -n 1 | sed "s/^.*\[\(.*\):\(.*\)\]/\1 \2/")
echo "$x" > /sys/bus/pci/drivers/vfio-pci/new_id

