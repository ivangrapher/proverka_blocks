absent=0 #1
nil=0 #3
commit=0 #2
unknown_val=0 #0
unrecognized=0 #-1
netu=0 #нет ответа
schet=0

#khandyga
#299EF0AC52744727C8A97E1B98DA937A74F82D06

#tarabukinivan
#8BE60627AC6D70AF9DCAB14AF70BA9984233F60C

#current  1148498
#1141476..1142660
#nil=3+7
#netu=3+22
#commit=1179
#1157577 22.35-28.11
last=`haqqd status |jq '.SyncInfo .latest_block_height' | xargs`
#for i in {1157833..$last}
#m=1157833
i=1158049
echo $last
while (("${i}" <= "${last}"))
do
     res=`curl -s http://127.0.0.1:36657/block?height=${i}  | jq '.result .block .last_commit .signatures[] | select(.validator_address=="8BE60627AC6D70AF9DCAB14AF70BA9984233F60C")'.block_id_flag`
     echo "$res current block $i"
     schet=$(($schet+1))
     if [ -z "${res}" ]; then
     res=100
     fi
     if [ $res -eq 2 ]
        then
        commit=$(($commit+1))
     fi
     if [ $res -eq 3 ]
        then
        nil=$(($nil+1))
     fi
     if [ $res -eq 0 ]
        then
        unknown_val=$(($unknown_val+1))
     fi
     if [ $res -eq 1 ]
        then
        absent=$(($absent+1))
     fi
     if [ $res -eq 100 ]
        then
        netu=$(($netu+1))
     fi
     if [ $res -eq -1 ]
        then
        unrecognized=$(($unrecognized+1))
     fi
     i=$(($i+1))
done

echo "commit= $commit"
echo "nil= $nil"
echo "unknown_val= $unknown_val"
echo "absent= $absent"
echo "net_otveta= $netu"
echo "unrecognized= $unrecognized"
echo "vsego= $schet"
