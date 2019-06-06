#!/bin/bash

echo "Starting Remote Engine On Every Slave Machine\n"

count=1
while read line1
    do 
	echo "$count - $line1"
        line2=`sed -n "$count"p "$2"`
		ssh -o StrictHostKeyChecking=no ubuntu@$line1 "pkill -f jmeter" < /dev/null
	ssh -o StrictHostKeyChecking=no ubuntu@$line1 "nohup sh /home/ubuntu/bin/jmeter-server -Djava.rmi.server.hostname=$line2 > Output.out 2> Error.err < /dev/null &" < /dev/null
		count=`expr $count + 1`
done < $1

echo "Slaves Are Ready To Execute Load Test\n"
