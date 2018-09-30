#!/bin/bash

#!/bin/bash

echo "A file must have a name..."
read namef
echo ${namef}

here=$(pwd)
name_dir=${namef}
ls

mkdir ${name_dir}
chmod 777 ${name_dir}

Password156="TUrnMyH34d"
Password138="tn45ss3G"
Password139="tn45ss3G"
Password140="123456"

sshpass -p ${Password138} scp cdr@209.208.212.138:/home/cdr/CDR/traces/NOC/${namef}* ${here}/${name_dir}/138.pcap
sshpass -p ${Password139} scp cdr@209.208.212.139:/home/cdr/CDR/traces/NOC/${namef}* ${here}/${name_dir}/139.pcap
sshpass -p ${Password140} scp cdr@209.208.212.140:/home/cdr/CDR/traces/NOC/${namef}* ${here}/${name_dir}/140.pcap
sshpass -p ${Password156} scp cdr@209.208.212.156:/home/cdr/CDR/traces/NOC/${namef}* ${here}/${name_dir}/156.pcap

cd ${here}/${name_dir}
echo "directory"
pwd

ls
chmod 777 senal.pcap
#chmod 777 *
#ls

echo "I'm here"
pwd
echo "A call needs a number..."
read dnis
#dnis=573138112015
echo "The media needs an IP (just three last digits)"
read IP_m
#IP_m=138
echo "A client needs a port..."
read port_A
#port_A=17584
echo "Client-Telintel needs a port..."
read port_B
#port_B=15124
echo "Telintel-Vedor needs a port..."
read port_C
#port_C=15894
echo "A Vendor needs a port..."
read port_D
#port_D=15126

mkdir ${dnis}
chmod 777 ${dnis}

dnis_filter=$(echo "sip contains ${dnis}")
p_filter=$(echo "((udp.port==${port_A} && udp.port==${port_B})||(udp.port==${port_C} && udp.port==${port_C}))")


pwd
ls
echo wire
tshark -n -r ${here}/${name_dir}/${IP_m}.pcap -Y "${p_filter}" -w ${here}/${name_dir}/${dnis}/media.pcap
tshark -n -r ${here}/${name_dir}/156.pcap -Y "${dnis_filter}" -w ${here}/${name_dir}/${dnis}/senal.pcap

cd ${here}/${name_dir}/${dnis}
chmod 777 *

mergecap media.pcap senal.pcap -w ${dnis}.pcap
chmod 777 ${dnis}.pcap

ready="no"
echo zxxcvb
while [ "${ready}" != "ready" ]
do
echo "When the .raw files are ready, write ready to continue"
read ready
done

ls | grep .raw > list.txt
N_raw=$(wc -l < list.txt)


for (( i=1; i<=${N_raw}; i++ ))
do
        stream=$(awk -v line=${i} 'NR==line' list.txt)
        echo ${stream}
	cp -p /${here}/${name_dir}/${dnis}/${stream} /${here}/codecProG729_Experimental/${stream}
	cd /${here}/codecProG729_Experimental/
	wine cp_g729_decoder.exe ${stream} stream${i}.wav
	mv /${here}/codecProG729_Experimental/stream${i}.wav /${here}/${name_dir}/${dnis}/stream${i}.wav
	cd ${here}/${name_dir}/${dnis}
	chmod 777 *.wav
done




