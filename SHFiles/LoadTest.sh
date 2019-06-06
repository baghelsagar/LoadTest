#!/bin/bash

echo "Starting Load Test"

scp $3 ubuntu@$2:/home/ubuntu/bin/
ab=$(sed -n -e 'H;${x;s/\n/,/g;s/^,//;p}' $1)
masterIP=$2
masterpuIp=$(ssh -o StrictHostKeyChecking=no ubuntu@$masterIP "ifconfig|grep Mask|cut -d ":" -f 2|head -1"< /dev/null)
masterpuIp=$(cat masterpuIp |sed -e 's/Bcast//g')
masterpuIp=$(cat masterpuIp |sed -e 's/\ //g')
echo $masterpuIp
ScriptName=$3
logFile=$(echo $ScriptName|sed -e 's/jmx/jtl/g')
zipFile=$(echo $SCriptName|sed -e 's/jmx//g')
ssh -o StrictHostKeyChecking=no ubuntu@$masterIP "nohup sh /home/ubuntu/bin/jmeter -n -t $ScriptName -Djava.rmi.server.hostname=$masterpuIp -l $logFile -R $ab "< /dev/null
ssh -o StrictHostKeyChecking=no ubuntu@$masterIP "zip /home/ubuntu/bin/$zipFile /home/ubuntu/bin/$logFile "< /dev/null
scp ubuntu@$2:/home/ubuntu/bin/$zipFile .
echo "Load Test Completed, Result File Is Stored With Name $zipFile"
