#!/bin/bash

funn()
{
a=`expr $2 - 1`
#echo $2
#echo $a
split -l$((`wc -l < $1`/$a)) $1 slave --numeric-suffixes=1

i=1
max=$2
while [ $i -le $max ]
do
if [ $i -lt 10 ]
then
        mkdir -pm 777 slaveDir$i
        mv slave0$i slaveDir$i/$1
else
        mkdir -pm 777 slaveDir$i
        mv slave$i slaveDir$i/$1
fi
i=`expr $i + 1`
done
#while read line; do
#scp slaveDir$i/$1 ubuntu@$line:/home/ubuntu/bin
#done < $3
}

echo "Splitting Data Files"
cd ../TestData
find . -name "*.txt" | while read f; do funn $(echo ${f} | sed -e 's/.\///g') $1; done

echo "Completed Splitting Data files, Files are in folders \"SlaveDir\" followed by Serial number"
#funn $1 $2 $3
