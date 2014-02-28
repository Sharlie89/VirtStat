#!/bin/bash

#This is a function for the program VirtStat.
#It extract the info from the system.

#The parameters are given by the VirStat main code.

############## START SCRIPT ######################

case $1 in
	mail)	echo "############################################################################" > MVstatusm.txt
		echo "############## ESTADO DE LAS MÁQUINAS VIRTUALES $fecha #################" >> MVstatusm.txt
		echo "############################################################################" >> MVstatusm.txt
		echo " " >> MVstatusm.txt
		echo "######### VIRTUAL 01 ###########          " >> MVstatusm.txt
		virsh list >> MVstatusm.txt
		echo "######### VIRTUAL 02 ###########          " >> MVstatusm.txt
		ssh virtual05 "virsh list" >> MVstatusm.txt
		echo " " >> MVstatusm.txt

		if [ "$2" = "$mem" ]
			then
				echo "############################################################################" >> MVstatusm.txt
				echo "######################## USO DE MEMORIA ####################################" >> MVstatusm.txt
				echo "############################################################################" >> MVstatusm.txt
				echo " " >> MVstatusm.txt
				echo "######### VIRTUAL 01 ###########          " >> MVstatusm.txt 
				free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> MVstatusm.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >>MVstatusm.txt && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> Mvstatusm.txt
       	                        echo " " >> MVstatusm.txt
				echo "######### VIRTUAL 02 ###########          " >> MVstatusm.txt
				ssh virtual05 "sh /opt/scripts/listar.sh"
				ssh virtual05 "cat /root/temp.txt" >> MVstatusm.txt
				echo " " >> MVstatusm.txt
				ssh virtual05 "rm -f /root/temp.txt"
		elif [ "$2" = "$cpu" ]
			then
       	                        echo "############################################################################" >> MVstatusm.txt
       	                        echo "######################## USO DE PROCESADOR #################################" >> MVstatusm.txt
       	                        echo "############################################################################" >> MVstatusm.txt
       	                        echo " " >> MVstatusm.txt 
				 echo "######### VIRTUAL 01 ###########          " >> MVstatusm.txt
				 mpstat >> MVstatusm.txt
       	                        echo " " >> MVstatusm.txt
				 echo "######### VIRTUAL 02 ###########          " >> MVstatusm.txt
				 ssh virtual05 "mpstat" >> MVstatusm.txt
				 echo " " >> MVstatusm.txt
		elif [ "$2" = "$disk" ]
			then
       	                        echo "############################################################################" >> MVstatusm.txt
       	                        echo "######################## USO DE DISCO ######################################" >> MVstatusm.txt
       	                        echo "############################################################################" >> MVstatusm.txt
       	                        echo " " >> MVstatusm.txt 
				 df -h |grep -i "S.ficheros" >> MVstatusm.txt && df -h |grep -i "/var/lib/libvirt/images/" >> MVstatusm.txt
				 echo " " >> MVstatusm.txt
		else 
				 echo "Opción incorrecta" >> MVstatusm.txt
		fi

       	        if [ "$3" = "$mem" ]
       	                then
       	                        echo "############################################################################" >> MVstatusm.txt
       	                        echo "######################## USO DE MEMORIA ####################################" >> MVstatusm.txt
       	                        echo "############################################################################" >> MVstatusm.txt
       	                        echo " " >> MVstatusm.txt
       	                        echo "######### VIRTUAL 01 ###########          " >> MVstatusm.txt 
				 free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> MVstatusm.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatusm.txt && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> Mvstatusm.txt
       	                        echo " " >> MVstatusm.txt
				 echo "######### VIRTUAL 02 ###########          " >> MVstatusm.txt
				 ssh virtual05 "sh /opt/scripts/listar.sh"
				 ssh virtual05 "cat /root/temp.txt" >> MVstatusm.txt
				 echo " " >> MVstatusm.txt
				 ssh virtual05 "rm -f /root/temp.txt"
                elif [ "$3" = "$cpu" ]
                        then
                                echo "############################################################################" >> MVstatusm.txt
                                echo "######################## USO DE PROCESADOR #################################" >> MVstatusm.txt
                                echo "############################################################################" >> MVstatusm.txt
                                echo " " >> MVstatusm.txt 
                                echo "######### VIRTUAL 01 ###########          " >> MVstatusm.txt
                                mpstat >> MVstatusm.txt
                                echo " " >> MVstatusm.txt
                                echo "######### VIRTUAL 02 ###########          " >> MVstatusm.txt
                                ssh virtual05 "mpstat" >> MVstatusm.txt
                                echo " " >> MVstatusm.txt
                elif [ "$3" = "$disk" ]
                        then
                                echo "############################################################################" >> MVstatusm.txt
                                echo "######################## USO DE DISCO ######################################" >> MVstatusm.txt
                                echo "############################################################################" >> MVstatusm.txt
                                echo " " >> MVstatusm.txt
                                df -h |grep -i "S.ficheros" && df -h |grep -i "/var/lib/libvirt/images/" >> MVstatusm.txt
                                echo " " >> MVstatusm.txt
                else
                                echo "Opción incorrecta" >> MVstatusm.txt
                fi
                if [ "$4" = "$mem" ]
                        then
                                echo "############################################################################" >> MVstatusm.txt
                                echo "######################## USO DE MEMORIA ####################################" >> MVstatusm.txt
                                echo "############################################################################" >> MVstatusm.txt
                                echo "######### VIRTUAL 01 ###########          " >> MVstatusm.txt
				echo " " >> MVstatusm.txt
				free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}'>> Mvstatusm.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> Mvstatusm.txt && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> Mvstatusm.txt
                                echo " " >> MVstatusm.txt
				echo "######### VIRTUAL 02 ###########          " >> MVstatusm.txt
				ssh virtual05 "sh /opt/scripts/listar.sh"
				ssh virtual05 "cat /root/temp.txt" >> MVstatusm.txt
				echo " " >> MVstatusm.txt
				ssh virtual05 "rm -f /root/temp.txt"
                elif [ "$4" = "$cpu" ]
                        then
                                echo "############################################################################" >> MVstatusm.txt
                                echo "######################## USO DE PROCESADOR #################################" >> MVstatusm.txt
                                echo "############################################################################" >> MVstatusm.txt
                                echo " " >> MVstatusm.txt 
                                echo "######### VIRTUAL 01 ###########          " >> MVstatusm.txt
                                mpstat >> MVstatusm.txt
                                echo " " >> MVstatusm.txt
                                echo "######### VIRTUAL 02 ###########          " >> MVstatusm.txt
                                ssh virtual05 "mpstat" >> MVstatusm.txt
                                echo " " >> MVstatusm.txt
                elif [ "$4" = "$disk" ]
                        then
                                echo "############################################################################" >> MVstatusm.txt
                                echo "######################## USO DE DISCO ######################################" >> MVstatusm.txt
                                echo "############################################################################" >> MVstatusm.txt
                                echo " " >> MVstatusm.txt
                                df -h |grep -i "S.ficheros" && df -h |grep -i "/var/lib/libvirt/images/" >> MVstatusm.txt
                                echo " " >> Mvstatusm.txt
                else
                                echo "Opción incorrecta" >> MVstatusm.txt
                fi
cat MVstatusm.txt | mail -s "Estado de las Virtuales" sistemas@cica.es
rm -f MVstatusm.txt
;;
	
screen) 
		echo "############################################################################" > MVstatus2.txt
		echo "############## ESTADO DE LAS MÁQUINAS VIRTUALES $fecha #################" >> MVstatus2.txt
		echo "############################################################################" >> MVstatus2.txt
		echo " " >> MVstatus2.txt
		echo "######### VIRTUAL 01 ###########          " >> MVstatus2.txt
		virsh list >> MVstatus2.txt
		echo "######### VIRTUAL 02 ###########          " >> MVstatus2.txt
		ssh virtual05 "virsh list" >> MVstatus2.txt
	
		if [ "$2" = "$mem" ]
			then
				echo "############################################################################" >> MVstatus2.txt
				echo "######################## USO DE MEMORIA ####################################" >> MVstatus2.txt
				echo "############################################################################" >> MVstatus2.txt
				echo " " >> MVstatus2.txt
				echo "######### VIRTUAL 01 ###########          " >> MVstatus2.txt
				free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> MVstatus2.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus2.txt && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus2.txt
        	               echo " " >> MVstatus2.txt
				echo "######### VIRTUAL 02 ###########          " >> MVstatus2.txt
				ssh virtual05 "sh /opt/scripts/listar.sh"
				ssh virtual05 "cat /root/temp.txt" >> MVstatus2.txt
				echo " " >> MVstatus2.txt
				ssh virtual05 "rm -f /root/temp.txt"
		elif [ "$2" = "$cpu" ]
			then
        	               echo "############################################################################" >> MVstatus2.txt
        	               echo "######################## USO DE PROCESADOR #################################" >> MVstatus2.txt
        	               echo "############################################################################" >> MVstatus2.txt
        	               echo " " >> MVstatus2.txt 
		               echo "######### VIRTUAL 01 ###########          " >> MVstatus2.txt
			       mpstat >> MVstatus2.txt
        	               echo " " >> MVstatus2.txt
			       echo "######### VIRTUAL 02 ###########          " >> MVstatus2.txt
			       ssh virtual05 "mpstat" >> MVstatus2.txt
			       echo " " >> MVstatus2.txt
		elif [ "$2" = "$disk" ]
			then
        	               echo "############################################################################" >> MVstatus2.txt
        	               echo "######################## USO DE DISCO ######################################" >> MVstatus2.txt
        	               echo "############################################################################" >> MVstatus2.txt
        	               echo " " >> MVstatus2.txt 
			       df -h |grep -i "S.ficheros" >> MVstatus2 && df -h |grep -i "/var/lib/libvirt/images/" >> MVstatus2.txt
			       echo " " >> MVstatus2.txt
		else 
				echo "Opción incorrecta" >> MVstatus2.txt
		fi
	
        	if [ "$3" = "$mem" ]
        	       then
        	              echo "############################################################################" >> MVstatus2.txt
        	              echo "######################## USO DE MEMORIA ####################################" >> MVstatus2.txt
        	              echo "############################################################################" >> MVstatus2.txt
        	              echo " " >> MVstatus2.txt
        	              echo "######### VIRTUAL 01 ###########          " >> MVstatus2.txt
			      free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> MVstatus2.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus2.txt && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus2.txt
        	              echo " " >> MVstatus2.txt
			      echo "######### VIRTUAL 02 ###########          " >> MVstatus2.txt
			      ssh virtual05 "sh /opt/scripts/listar.sh"
			      ssh virtual05 "cat /root/temp.txt" >> MVstatus2.txt
			      echo " " >> MVstatus2.txt
			      ssh virtual05 "rm -f /root/temp.txt"
        	elif [ "$3" = "$cpu" ]
        	       then
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo "######################## USO DE PROCESADOR #################################" >> MVstatus2.txt
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt 
        	             echo "######### VIRTUAL 01 ###########          " >> MVstatus2.txt
        	             mpstat >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt
        	             echo "######### VIRTUAL 02 ###########          " >> MVstatus2.txt
        	             ssh virtual05 "mpstat" >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt
        	elif [ "$3" = "$disk" ]
        	       then
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo "######################## USO DE DISCO ######################################" >> MVstatus2.txt
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt 
        	             df -h |grep -i "S.ficheros" && df -h |grep -i "/var/lib/libvirt/images/" >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt
	        else 
        	             echo "Opción incorrecta" >> MVstatus2.txt
        	fi
        	if [ "$4" = "$mem" ]
        	       then
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo "######################## USO DE MEMORIA ####################################" >> MVstatus2.txt
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt
        	             echo "######### VIRTUAL 01 ###########          " >> MVstatus2.txt
			     free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> MVstatus2.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus2.txt && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus2.txt
			     echo " " >> MVstatus2.txt
        	             echo "######### VIRTUAL 02 ###########          " >> MVstatus2.txt
			     ssh virtual05 "sh /opt/scripts/listar.sh"
			     ssh virtual05 "cat /root/temp.txt" >> MVstatus2.txt
			     echo " " >> MVstatus2.txt
			     ssh virtual05 "rm -f /root/temp.txt"
	      elif [ "$4" = "$cpu" ]
		      then
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo "######################## USO DE PROCESADOR #################################" >> MVstatus2.txt
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt 
        	             echo "######### VIRTUAL 01 ###########          " >> MVstatus2.txt
        	             mpstat >> MVstatus2.txt
			     echo " " >> MVstatus2.txt
        	             echo "######### VIRTUAL 02 ###########          " >> MVstatus2.txt
        	             ssh virtual05 "mpstat" >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt
	      elif [ "$4" = "$disk" ]
		      then
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo "######################## USO DE DISCO ######################################" >> MVstatus2.txt
        	             echo "############################################################################" >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt
        	             df -h |grep -i "S.ficheros" && df -h |grep -i "/var/lib/libvirt/images/" >> MVstatus2.txt
        	             echo " " >> MVstatus2.txt
              else 
                            echo "Opción incorrecta" >> MVstatus2.txt
	      fi
        	        
cat MVstatus2.txt
rm -f MVstatus2.txt
	
;;
	
  file)
		echo "############################################################################" > MVstatus.txt
		echo "############## ESTADO DE LAS MÁQUINAS VIRTUALES $fecha #################" >> MVstatus.txt
		echo "############################################################################" >> MVstatus.txt
		echo " " >> MVstatus.txt
		echo "######### VIRTUAL 01 ###########          " >> MVstatus.txt
		virsh list >> MVstatus.txt
		echo "######### VIRTUAL 02 ###########          " >> MVstatus.txt
		ssh virtual05 "virsh list" >> MVstatus.txt
		if [ "$2" = "$mem" ]
			then
				echo "############################################################################" >> MVstatus.txt
				echo "######################## USO DE MEMORIA ####################################" >> MVstatus.txt
				echo "############################################################################" >> MVstatus.txt
				echo " " >> MVstatus.txt
				echo "######### VIRTUAL 01 ###########          " >> MVstatus.txt
				free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> MVstatus.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}'>> MVstatus.txt && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
				echo "######### VIRTUAL 02 ###########          " >> MVstatus.txt
				ssh virtual05 "sh /opt/scripts/listar.sh"
				ssh virtual05 "cat /root/temp.txt" >> MVstatus.txt
				echo " " >> MVstatus.txt
			ssh virtual05 "rm -f /root/temp.txt"
		elif [ "$2" = "$cpu" ]
			then
      	                        echo "############################################################################" >> MVstatus.txt
       	                        echo "######################## USO DE PROCESADOR #################################" >> MVstatus.txt
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt 
				 echo "######### VIRTUAL 01 ###########          " >> MVstatus.txt
				 mpstat >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
				 echo "######### VIRTUAL 02 ###########          " >> MVstatus.txt
				 ssh virtual05 "mpstat" >> MVstatus.txt
				 echo " " >> MVstatus.txt
		elif [ "$2" = "$disk" ]
			then
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo "######################## USO DE DISCO ######################################" >> MVstatus.txt
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo " " >> MVstatus.tx
				 df -h |grep -i "S.ficheros" && df -h |grep -i "/var/lib/libvirt/images/" >> MVstatus.txt
				 echo " " >> MVstatus.txt
		else 
				echo "Opción incorrecta" >> MVstatus.txt
		fi

       	        if [ "$3" = "$mem" ]
       	                then
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo "######################## USO DE MEMORIA ####################################" >> MVstatus.txt
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
      	                        echo "######### VIRTUAL 01 ###########          " >> MVstatus.txt
				 free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> MVstatus.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus.txt && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
				 echo "######### VIRTUAL 02 ###########          " >> MVstatus.txt
				ssh virtual05 "sh /opt/scripts/listar.sh "
				ssh virtual05 "cat /root/temp.txt" >> MVstatus.txt
				echo " " >> MVstatus.txt
				ssh virtual05 "rm -f /root/temp.txt"
       	        elif [ "$3" = "$cpu" ]
       	                then
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo "######################## USO DE PROCESADOR #################################" >> MVstatus.txt
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt 
       	                        echo "######### VIRTUAL 01 ###########          " >> MVstatus.txt
       	                        mpstat >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
       	                        echo "######### VIRTUAL 02 ###########          " >> MVstatus.txt
       	                        ssh virtual05 "mpstat" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
       	        elif [ "$3" = "$disk" ]
       	                then
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo "######################## USO DE DISCO ######################################" >> MVstatus.txt
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt 
       	                        df -h |grep -i "S.ficheros" && df -h |grep -i "/var/lib/libvirt/images/" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
       	        else 
       	                        echo "Opción incorrecta" >> MVstatus.txt
       	        fi
       	        if [ "$4" = "$mem" ]
       	                then
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo "######################## USO DE MEMORIA ####################################" >> MVstatus.txt
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
       	                        echo "######### VIRTUAL 01 ###########          " >> MVstatus.txt 
				 free -m |grep -i total | awk -F" " '{printf "\t"$1"\t" $2"\t" $3"\n"}' >> MVstatus.txt && free -m |grep -i mem | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus.txt && free -m |grep -i swap | awk -F" " '{printf $1"\t" $2"\t" $3"\t" $4"\n"}' >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
				 echo "######### VIRTUAL 02 ###########          " >> MVstatus.txt
       	                        ssh virtual05 "sh /opt/scripts/listar.sh"
				ssh virtual05 "cat /root/temp.txt" >> MVstatus.txt
				echo " " >> MVstatus.txt
				ssh virtual05 "rm -f /root/temp.txt"
       	        elif [ "$4" = "$cpu" ]
       	                then
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo "######################## USO DE PROCESADOR #################################" >> MVstatus.txt
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt 
       	                        echo "######### VIRTUAL 01 ###########          " >> MVstatus.txt
       	                        mpstat >> MVstatusm.txt
       	                        echo " " >> MVstatus.txt
       	                        echo "######### VIRTUAL 02 ###########          " >> MVstatus.txt
       	                        ssh virtual05 "mpstat" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
       	        elif [ "$4" = "$disk" ]
       	                then
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo "######################## USO DE DISCO ######################################" >> MVstatus.txt
       	                        echo "############################################################################" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
       	                        df -h |grep -i "S.ficheros" && df -h |grep -i "/var/lib/libvirt/images/" >> MVstatus.txt
       	                        echo " " >> MVstatus.txt
       	        else 
       	                        echo "Opción incorrecta" >> MVstatus.txt
       	        fi

echo "Se ha generado el listado en /opt/scripts/MVstatus.txt"
		;;

	*)	echo "** ERROR ** "
		echo "EL USO CORRECTO ES: VirStat (mail|screen|text)"
		exit 1
		;;
esac	
}