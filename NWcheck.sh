#!/bin/bash
## This script will make basic Network troubleshooting checks

LOCAL_GATEWAY=$(/sbin/ip route | awk '/default/ {print $3}')
CHECK_DOMAIN=google.com
CHECK_IP=8.8.8.8
DNS=$(cat /etc/resolv.conf | awk '/nameserver/ {print $2}' | awk 'NR == 1 {print; exit}')
MY_IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"

echo "This script will make basic networking checks for $MY_IP..."
echo ""
echo "Checking local network interface adapters.."

# list Network Interfaces and their corresponding IPs
sleep 3
echo "The following network interfaces are configured on this system: "
echo ""
ip -br -c addr show | awk {'print $1,$3'}
echo ""
sleep 2

# List those Network Interfaces reporting as DOWN
if ip -br -c addr show | grep DOWN | awk '{print $1,$2}' &>/dev/null; then
echo "the following network interfaces are currently DOWN. Please check if they participate in the day-to-day functioning of this system and troubleshoot accordingly.."
echo ""
ip -br -c addr show | grep DOWN | awk '{print $1,$2}'
else
echo ""
echo "All network interfaces are UP.."
fi

#Ping Local Gateway to check LAN connectivity
sleep 2
echo ""
echo "Checking connectivity to the local gateway..."
echo ""
sleep 2
ping -c 4 $LOCAL_GATEWAY
if [ "$?" -eq "0" ]
then
	echo ""
	echo "The local gateway is reachable."
else
	echo ""
	echo "The local gateway is unresponsive, please check cabling.."
fi

echo ""

# Check tcp/http connection to google using netcat
echo "Checking TCP/HTTP connection to $CHECK_DOMAIN on port 80..."
sleep 4

if  nc -z -v $CHECK_DOMAIN 80 &>/dev/null; then
	echo ""
	echo "[tcp/http] connection to $CHECK_DOMAIN on port 80 successful!"
else
	echo "[tcp/http] connection on port 80 to $CHECK_DOMAIN failed.."
fi

sleep 2
echo ""
echo ""

# Check connectivity to DNS host
echo "pinging DNS host in resolv.conf.."
echo ""
sleep 2
ping -c 4 $DNS
if [ "$?" -eq "0" ];
then
	echo ""
	echo "DNS server is reachable"
else
	echo ""
	echo "DNS server is unreachable.."
fi

sleep 2
echo ""

#ping google 
echo "Pinging $CHECK_DOMAIN IP to check broader internet connectivity..."
echo ""
sleep 1
ping -c 4 $CHECK_IP
if [ $? -eq 0 ]
then
	echo ""
	echo "$CHECK_DOMAIN pingable- internet connectivity available"
else
	echo ""
	echo "Could not establish communication to $CHECK_DOMAIN.. further troubleshooting needed"
fi
sleep 1




