#!/bin/bash

#### DECLARATION OF VARIABLES #######
mvstatus=`mktemp /tmp/mvstatustemp.XXXX`
mvr=`mktemp /tmp/mvr.XXXX`
mvstatustemp=`mktemp /tmp/mvstatustemp.XXXX`
mvstatustemp2=`mktemp /tmp/mvstatustemp.XXXX`
mvstatustemp3=`mktemp /tmp/mvstatustemp.XXXX`
mvstatuspercent=`mktemp /tmp/mvstatustemp.XXXX`
mvstatuspercentr=`/tmp/mvstatustemp.XXXX`
hostlist="/etc/VirtStat/servers"
mailist="/etc/VirtStat/mail"
totptemp=`mktemp /tmp/mvstatustemp`
fecha=`date -I`
memMVt=0
host=`hostname`

###### DECLARATION OF FUNCTIONS ######

function memMV(){
        virsh list |grep -v Id |grep -v "\--" |awk -F" " '{print $2}'| sed '$d' >> $mvr
        while read line
                do
                  memMVm=`cat /etc/libvirt/qemu/$line.xml |grep  memory | awk -F "<memory'*'>" '{print $1}' |awk -F"</memory>" '{print $1}' |awk -F">" '{print $2}'`
                  memMVmb=$(($memMVm / 1024))
                  memMVt=$(($memMVt + $memMVmb))
                  echo "$line:$memMVmb" >> $mvstatustemp
                done < $mvr
        echo "TOTAL ASSIGNED: $memMVt MB" >> $mvstatustemp
        unlink $mvr
}


######## START SCRIPT #########
echo "============================================================================" > $mvstatus
echo "============== ESTADO DE LAS MAQUINAS VIRTUALES $fecha =================" >> $mvstatus
echo "============================================================================" >> $mvstatus
echo " " >> $mvstatus

##### LOCALHOST LIST ########
unlink $mvstatustemp
touch $mvstatustemp
echo " ---======= $host =======---        " >> $mvstatus
virsh list |grep -v Id |grep -v "\----------------------------------------------------"| awk -F" " '{print $2}'| sed '$d' >> $mvstatustemp2
virsh list |grep -v Id |grep -v "\----------------------------------------------------"| sed '$d' >> $mvstatustemp3
alias memVM='/opt/scripts/VirtStat/memMV.sh'
memMV
echo -e " Id    Name                           State     Memory \t\t %Use \t\t%CPU" >> $mvstatus
echo "-----------------------------------------------------------------------------------------" >> $mvstatus
for line in $(cat $mvstatustemp2);
	do
		unlink $mvstatuspercent
		memtemp=`cat $mvstatustemp |grep -w $line |awk -F":" '{print $2}'`
		guestemp=`cat $mvstatustemp3 |grep -w $line`
		smem -p -P "$line.monitor" |grep -i kvm |awk -F" " '{print $11}' >> $mvstatuspercent
		percent=`cat $mvstatuspercent`
		cpup=`ps aux |grep "\-name $line" |grep -v "grep"|tail -n1 |awk -F" " '{print $3}'`
		echo -e "$guestemp  \t$memtemp MB  \t$percent \t\t$cpup%" >> $mvstatus
	done
echo " " >> $mvstatus
totp=`smem -p -t -P "kvm"|tail -n1 |awk -F" " '{print $6}'`
cat $mvstatustemp |grep "TOTAL ASSIGNED:" >> $mvstatus
echo "TOTAL % IN USE OF ASSIGNED MEMORY: $totp " >> $mvstatus
unlink $mvstatustemp
unlink $mvstatustemp2
unlink $mvstatustemp3
echo -e "\n ------ MEMORIA $host ------" >> $mvstatus
free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> $mvstatus && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> $mvstatus && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> $mvstatus
echo " " >> $mvstatus

#### REMOTE VIRTUALIZATION HOSTS LIST #####
#In this part, VirtStat, list the servers in /etc/VirtStat/servers
for line in $(cat $hostlist);
        do
		unlink $mvstatustemp
		touch $mvstatustemp
                echo "---======= $line =======---          " >> $mvstatus
		ssh $line "virsh list |grep -v Id "|grep -v "\---"| awk -F" " '{print $2}'| sed '$d' >> $mvstatustemp2
		ssh $line "virsh list |grep -v Id "|grep -v "\---"| sed '$d' >> $mvstatustemp3
		ssh $line "sh /opt/scripts/VirtStat/memMV.sh" >> $mvstatustemp3
		echo -e " Id    Name                           State     Memory \t\t %Use \t\t%CPU" >> $mvstatus
		echo "-----------------------------------------------------------------------------------------" >> $mvstatus
		for line2 in $(cat $mvstatustemp2);
	       		do
				unlink $mvstatuspercentr
				unlink $mvstatuspercent
                		memtemp=`ssh $line "cat $mvstatustemp |grep -w $line2" |awk -F":" '{print $2}'`
	                	guestemp=`cat $mvstatustemp3 |grep -w $line2`
                		ssh $line "smem -p -P "$line2.monitor" |grep -i kvm" >> $mvstatuspercentr
				cat $mvstatuspercentr |awk -F" " '{print $11}' >> $mvstatuspercent
		                percent=`cat $mvstatuspercent`
				cpup=`ssh $line ps aux |grep "\-name $line2" |grep -v "grep"|tail -n1`
				cpup=`echo $cpup |awk -F" " '{print $3}'`
	        	       	echo -e "$guestemp  \t $memtemp MB  \t $percent \t\t$cpup%" >> $mvstatus
        		done
		echo " " >> $mvstatus
		ssh $line "cat $mvstatustemp" |grep "TOTAL ASSIGNED:" >> $mvstatus
		ssh $line "unlink $mvstatustemp"
		ssh $line "smem -p -t -P 'kvm'" >> $totptemp
		totp=`cat $totptemp |tail -n1 |awk -F" " '{print $6}'`
		echo "TOTAL % IN USE OF ASSIGNED MEMORY: $totp " >> $mvstatus
		echo " " >> $mvstatus
                echo " ------ MEMORIA $line ------" >> $mvstatus
                ssh $line "/opt/scripts/VirtStat/listar.sh" >> $mvstatus
                echo " " >> $mvstatus
		unlink $mvstatustemp
		unlink $mvstatustemp2
		unlink $mvstatustemp3
		unlink $mvstatuspercent
		unlink $mvstatuspercentr
	 done

####### PARAMETER VALIDATION ########
case $1 in
        screen)
                cat $mvstatus;;
        mail)
		numhosts=`cat $mailist |wc -l`
		if [ $nummail -eq 1 ] then;
					mail=`cat $mailist`;;
			                cat $mvstatus | mail -s " Estado de las virtuales $fecha " $mail ;;
		elif [ $nummail -gt 1 ] then;
			for $line in $(cat $mailist) do
                                        cat $mvstatus | mail -s " Estado de las virtuales $fecha " $line ;;
        		done ;;
		fi ;;
	copy)
## First, found if is a file or a directory
	if [ -d $1 ]; then
			for $line in $(cat $hostlist) do
				scp -pr $1 $line:$1 ;;
				echo "SUCCESS COPY ON $line" ;;
			done
	else
			for $line in $(cat $hostlist) do
				scp  $1 $line:$1 ;;
				echo "SUCCESS COPY ON $line" ;;
			done
	fi ;;

	*)
                echo "PARAMETROS INCORRECTOS
USE screen/mail " > $mvstatus
                mail=`cat $mailist`;;
                cat $mvstatus | mail -s " Fallo ejecucion script virtuales $fecha " $mail            ;;
esac

unlink $mvstatus
