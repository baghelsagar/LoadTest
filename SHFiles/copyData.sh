echo "Transafering Data files to Respected Slave Machine"
cd ../TestData
i=1

while read line; do
echo "$i - $line"
scp slaveDir$i/*.txt ubuntu@$line:/home/ubuntu/bin/
scp jmeter.properties ubuntu@$line:/home/ubuntu/bin/
echo "\n"
i=`expr $i + 1`
done < $1

echo "Data Transafer Completed"

