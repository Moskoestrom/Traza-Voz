#!/bin/bash

echo "A file needs a name"
read name
echo ${name}

Password156="TUrnMyH34d"
#sshpass -p ${Password156} ssh -t cdr@209.208.212.156 'top'

Password138="tn45ss3G"
#sshpass -p ${Password138} ssh -t cdr@209.208.212.138 'top'

Password139="tn45ss3G"
#sshpass -p ${Password139} ssh cdr@209.208.212.139 'top'

Password140="123456"
#sshpass -p ${Password140} ssh cdr@209.208.212.140

./filter_gen.sh > tmp_filter.txt

#cat tmp_filter.txt
filter_s=$(awk 'NR==1' tmp_filter.txt)
filter_m=$(awk 'NR==2' tmp_filter.txt)

#echo "tshark -i any -b filesize:100000 -b files:80 -s 1514 ${filter_s} -w /CDR/traces/go4clients-20161018-sig.pcap" > wire_156.txt
#echo "tshark -i any -b filesize:100000 -b files:80 -s 1514 ${filter_m} -w /CDR/traces/go4clients-20161018-138.pcap" > wire_138.txt
#echo "tshark -i any -b filesize:100000 -b files:80 -s 1514 ${filter_m} -w /CDR/traces/go4clients-20161018-139.pcap" > wire_139.txt
#echo "tshark -i any -b filesize:100000 -b files:80 -s 1514 ${filter_m} -w /CDR/traces/go4clients-20161018-140.pcap" > wire_140.txt

echo "tshark -i any -b filesize:100000 -b files:80 -s 1514 ${filter_s} -w /CDR/traces/NOC/${name}-156.pcap" > wire_156.txt
echo "tshark -i any -b filesize:100000 -b files:80 -s 1514 ${filter_m} -w /CDR/traces/NOC/${name}-138.pcap" > wire_138.txt
echo "tshark -i any -b filesize:100000 -b files:80 -s 1514 ${filter_m} -w /CDR/traces/NOC/${name}-139.pcap" > wire_139.txt
echo "tshark -i any -b filesize:100000 -b files:80 -s 1514 ${filter_m} -w /CDR/traces/NOC/${name}-140.pcap" > wire_140.txt


awk '//; /# The tshark goes here/{while(getline < "wire_138.txt"){print}}' base_138_NOC.sh > 138_NOC.sh
cat 138_NOC.sh
awk '//; /# The tshark goes here/{while(getline < "wire_139.txt"){print}}' base_139_NOC.sh > 139_NOC.sh
cat 139_NOC.sh
awk '//; /# The tshark goes here/{while(getline < "wire_140.txt"){print}}' base_140_NOC.sh > 140_NOC.sh
cat 140_NOC.sh
awk '//; /# The tshark goes here/{while(getline < "wire_156.txt"){print}}' base_156_NOC.sh > 156_NOC.sh
cat 156_NOC.sh

chmod 777 138_NOC.sh
chmod 777 138_NOC.sh
chmod 777 138_NOC.sh
chmod 777 138_NOC.sh

sshpass -p ${Password138} scp -p 138_NOC.sh cdr@209.208.212.138:/home/cdr/138_NOC.sh 
sshpass -p ${Password139} scp -p 139_NOC.sh cdr@209.208.212.139:/home/cdr/139_NOC.sh 
sshpass -p ${Password140} scp -p 140_NOC.sh cdr@209.208.212.140:/home/cdr/140_NOC.sh 
sshpass -p ${Password156} scp -p 156_NOC.sh cdr@209.208.212.156:/home/cdr/156_NOC.sh 

rm wire_156.txt
rm wire_139.txt
rm wire_138.txt
rm wire_140.txt

#Don't touch this mdfk!
gnome-terminal -x bash -c "sshpass -p ${Password156} ssh cdr@209.208.212.156" 
gnome-terminal -x bash -c "sshpass -p ${Password138} ssh cdr@209.208.212.138"
gnome-terminal -x bash -c "sshpass -p ${Password139} ssh cdr@209.208.212.139"
gnome-terminal -x bash -c "sshpass -p ${Password140} ssh cdr@209.208.212.140"





