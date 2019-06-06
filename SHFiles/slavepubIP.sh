#!/bin/bash

echo "Extracting public IP of slave machines"
cd ../IPFiles
count=1
while read line1
    do 
	echo "$count - $line1"
	ssh -o StrictHostKeyChecking=no ubuntu@$line1 "ifconfig|grep Mask|cut -d ":" -f 2|head -1">>a.txt < /dev/null
		count=`expr $count + 1`
done < $1 

sed -i 's/Bcast//g' a.txt
sed -i 's/\ //g' a.txt
sed -i 's/-/\./g' a.txt
echo "Extracted Public IP and stored in a.txt"
