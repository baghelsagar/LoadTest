b=$(cat $1 |wc -l)
sh split.sh $b
sh slavepubIP.sh $1
sh copyData.sh $1
sh slave.sh $1 a.txt
sh LoadTest.sh a.txt $2 $3
