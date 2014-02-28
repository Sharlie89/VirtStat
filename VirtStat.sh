#!/bin/bash

#####################################
# CREADO POR: Carlos Álvarez	     #
# Este comando/script genera una    #
# lista de las MV que se encuentran #
# en ejecución y en que nodo.	     #
# 				     #
# FECHA DE CREACIÓN: 5/02/2014	     #
# ULTIMA MOD: 24/02/2014	     #
#####################################

#### DECLARACIÓN DE CONSTANTES ######

fecha=`date -I`
mem="-m"
cpu="-c"
disk="-d"
help="-h"

############ FUNCTIONS ##############

function comparnum () {
	if [ "$#" -gt 4 ];
		then
			echo "Demasiados parámetros"
	fi
}

function nopar () {
	if [ "$#" -eq 0 ];
		then
			echo "No se ha especificado parámetros. Introduzca -h para ayuda"
	fi
}

function compareq () {
      if [ "$2" = "$3" ] || [ "$2" = "$4" ] || [ "$3" = "$4" ];
	then
		echo "No puede haber dos parámetros iguales"
      fi
}

######## COMIENZO DEL SCRIPT ########

comparnum

nopar

compareq

InfoEx $1 $2 $3 $4
