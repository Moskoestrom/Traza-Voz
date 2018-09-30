#!/bin/bash

#cat vendor_media.txt

file_C=client_IP.txt
file_V=vendor_IP.txt

awk '/Signal/ {flag=1;next} /Media/{flag=0} flag{print}' ${file_C} > IP_signal_C.txt
awk '/Signal/ {flag=1;next} /Media/{flag=0} flag{print}' ${file_V} > IP_signal_V.txt
awk '/Media/{flag=1;next} flag{print}' ${file_C} > IP_media_C.txt
awk '/Media/{flag=1;next} flag{print}' ${file_V} > IP_media_V.txt
#awk '{while(getline line<"IP_signal_C.txt"){print line}} //' IP_signal_V.txt > IP_signal.txt
#awk '{while(getline line<"IP_media_C.txt"){print line}} //'  IP_media_V.txt  > IP_media.txt

#cat IP_signal.txt
#cat IP_media.txt

IP_C_signal=$(wc -l < IP_signal_C.txt)
IP_V_signal=$(wc -l < IP_signal_V.txt)
IP_C_media=$(wc -l < IP_media_C.txt)
IP_V_media=$(wc -l < IP_media_V.txt)

#echo ${IP_signal}
#echo ${IP_media}

for (( i=1; i<=${IP_C_signal}; i++ ))
do
        IP_C_s=$(awk -v line=${i} 'NR==line' IP_signal_C.txt)
#       echo ${IP_C_s}
        if (( ${i} == 1 ))
        then
                string_C_s=$(echo "host ${IP_C_s}")
                filter_C_s=${string_C_s}
        else
                string_C_s=$(echo "or host "${IP_C_s})
                filter_C_s=$(echo "${filter_C_s} ${string_C_s}")
        fi
done

for (( j=1; j<=${IP_V_signal}; j++ ))
do
        IP_V_s=$(awk -v line=${j} 'NR==line' IP_signal_V.txt)
#       echo ${IP_V_s}
        if (( ${j} == 1 ))
        then
                string_V_s=$(echo "host ${IP_V_s}")
                filter_V_s=${string_V_s}
        else
                string_V_s=$(echo "or host "${IP_V_s})
                filter_V_s=$(echo "${filter_V_s} ${string_V_s}")
        fi
done

echo "\"(${filter_C_s}) or (${filter_V_s})\""

for (( l=1; l<=${IP_C_media}; l++ ))
do
        IP_C_m=$(awk -v line=${l} 'NR==line' IP_media_C.txt)
#       echo ${IP_C_m}
        if (( ${l} == 1 ))
        then
                string_C_m=$(echo "host ${IP_C_m}")
                filter_C_m=${string_C_m}
        else
                string_C_m=$(echo "or host "${IP_C_m})
                filter_C_m=$(echo "${filter_C_m} ${string_C_m}")
        fi
done

for (( k=1; k<=${IP_V_media}; k++ ))
do
        IP_V_m=$(awk -v line=${k} 'NR==line' IP_media_V.txt)
#       echo ${IP_V_m}
        if (( ${k} == 1 ))
        then
                string_V_m=$(echo "host ${IP_V_m}")
                filter_V_m=${string_V_m}
        else
                string_V_m=$(echo "or host "${IP_V_m})
                filter_V_m=$(echo "${filter_V_m} ${string_V_m}")
        fi
done

echo "\"(${filter_C_m}) or (${filter_V_m})\""

echo ${filter_m}
rm IP_signal_C.txt
rm IP_signal_V.txt
rm IP_media_C.txt
rm IP_media_V.txt

#./trazas_199.sh & ./trazas_197.sh & ./trazas_189.sh & ./trazas_130.sh & ./trazas_132.sh & ./trazas_222.sh & ./trazas_221.sh 
#ssh trazas@10.170.0.197 "/usr/sbin/tcpdump '(host 162.248.55.221 or port 11380)' -i any -s 1500 -w -" | wireshark-gtk -k -i -

