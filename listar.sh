#!/bin/bash

# Extra script for extract mem info from remote hosts

free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> /root/temp.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >>/root/temp.txt && free -m |grep -i swap $

exit 0

