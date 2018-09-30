#!/bin/bash
# The tshark goes here
tshark -i any -b filesize:100000 -b files:80 -s 1514 "(host 181.49.122.5) or (host 64.135.45.155)" -w /CDR/traces/NOC/cosa-139.pcap
