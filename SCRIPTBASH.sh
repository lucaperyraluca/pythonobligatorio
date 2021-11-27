#!/bin/bash

var=""

if [ "$*" == "$var" ]
then
    rango=$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | wc -l)
    
 
    echo  Usuario "$(printf "\t")" Terminal "$(printf "\t")" Host "$(printf "\t\t")" Fecha "$(printf "\t\t")" H.con "$(printf "\t\t")" H.Dest "$(printf "\t\t")" T.Con
    for i in $( seq 1 $rango )
    do
	    min_inicio=`last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -$i|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]"|cut -d":" -f2|egrep -o "[0-9][0-9]"`
	    horas_inicio=`last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -$i|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]"|cut -d":" -f1|egrep -o "[0-9][0-9]"`
	    min_final=`last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -1|tail -1 | cut -d    "-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]"|cut -d":" -f2|egrep -o "[0-9][0-9]"`
	    horas_final=`last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -1|tail -1 | cut -d    "-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]"|cut -d":" -f1|egrep -o "[0-9][0-9]"`	    
	    min_totales=`echo $min_inicio + $min_final |bc`
	    horas_totales=`echo $horas_inicio + $horas_final|bc`
	        if [ "$horas_totales" -ge "24" ]
                then
                        $horas_totales=$( echo $horas_totales-24|bc)
                fi


	        if [ "$min_inicio" -ge "60"  ]
                then
                        resto_minutos_totales=$( echo "$min_totales"%60 | bc)
                        entero_minutos_totales=$(( $min_totales / 60 ))
                        min_totales=$resto_minutos_inicio
                        horas_totales="$(($horas_totales + $entero_minutos_totales))"
                fi

		if [ "$horas_totales" -ge "24" ]
		then
			$horas_totales=$( echo $horas_totales-24|bc)
		fi
		
		tiempo_inicio="$horas_totales"":""$min_totales"

        echo "$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$"|head -"$i"|tail -1|cut -d" " -f1)""$(printf "\t\t ")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d":" -f3 | egrep -o "^[0-9]")""$(printf "\t\t ")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d":" -f3|grep -o "^[0-9]")""$(printf "\t\t")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$"| head -"$i"|tail -1 | egrep -o "[A-Z][a-z][a-z][ ]+[A-Z][a-z][a-z][ ]+[0-9]?[0-9]")""$(printf "\t")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]")""$(printf "\t\t")""$(echo " $tiempo_inicio")""$(printf "\t\t\t ")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d"-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]")"
    done
fi

#a=`last "$USER" | head -1`
#if  [ "$a" == "" ]
#then
#     echo "No se han encontrado conexiones para listar en el sistema.">&2
#     exit 0
#fi



        while getopts ":ru:" option
        do
         case "$option" in
         r) 
		 a=`last  | head -1`
                 if  [ "$a" == "" ]
                 then
                         echo "No se han encontrado conexiones para listar en el sistema.">&2
                 exit 0
                 fi
		 
		 if [ "$1" = "-r" ] && [ "$2" = "-r"  ]
		 then
			 echo "Cantidad de parámetros errónea, solo se aceptan los modificadores -r y -u '(seguido de un nombre de usuario)'">&2
			 exit 3
		 fi


	    if  [ "$1" = "-r" ] && [ "$2"  = "-u" ]
            then
                 continue
            else

		MINUTOS=`last  | awk '{print $10}'| egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | cut -d":" -f2| egrep -o "[0-9][0-9]"| awk '{total = total + $1}END{print total}'`
		HORAS=`last  | awk '{print $10}'| egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | cut -d":" -f1| egrep -o "[0-9][0-9]"| awk '{total = total + $1}END{print total}'`
		rango=$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | wc -l)

    		echo  Usuario "$(printf "\t")" Terminal "$(printf "\t")" Host "$(printf "\t\t")" Fecha "$(printf "\t\t")" H.con "$(printf "\t\t")" H.Dest "$(printf "\t\t")" T.Con
    		for i in $( seq 1 $rango )
    		do

            min_inicio=`last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -$i|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]"|cut -d":" -f2|egrep -o "[0-9][0-9]"`
            horas_inicio=`last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -$i|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]"|cut -d":" -f1|egrep -o "[0-9][0-9]"`
            min_final=`last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -1|tail -1 | cut -d    "-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]"|cut -d":" -f2|egrep -o "[0-9][0-9]"`
            horas_final=`last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -1|tail -1 | cut -d    "-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]"|cut -d":" -f1|egrep -o "[0-9][0-9]"`
            min_totales=`echo $min_inicio + $min_final |bc`
            horas_totales=`echo $horas_inicio + $horas_final|bc`
                if [ "$horas_totales" -ge "24" ]
                then
                        $horas_totales=$( echo $horas_totales-24|bc)
                fi


                if [ "$min_inicio" -ge "60"  ]
                then
                        resto_minutos_totales=$( echo "$min_totales"%60 | bc)
                        entero_minutos_totales=$(( $min_totales / 60 ))
                        min_totales=$resto_minutos_inicio
                        horas_totales="$(($horas_totales + $entero_minutos_totales))"
                fi

                if [ "$horas_totales" -ge "24" ]
                then
                        $horas_totales=$( echo $horas_totales-24|bc)
                fi

                tiempo_inicio="$horas_totales"":""$min_totales"



        	echo "$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$"|head -"$i"|tail -1|cut -d" " -f1)""$(printf "\t\t ")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d":" -f3 | egrep -o "^[0-9]")""$(printf "\t\t ")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d":" -f3|grep -o "^[0-9]")""$(printf "\t\t")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$"| head -"$i"|tail -1 | egrep -o "[A-Z][a-z][a-z][ ]+[A-Z][a-z][a-z][ ]+[0-9]?[0-9]")""$(printf "\t")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]")""$(printf "\t\t")""$(echo " $tiempo_inicio")""$(printf "\t\t\t ")""$(last | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d"-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]")"
    done



		if [ "$MINUTOS" -ge "60"  ]
		then
			resto_minutos=$( echo "$MINUTOS"%60 | bc)
			entero_minutos=$(( $MINUTOS / 60 ))
			MINUTOS=$resto_minutos
			HORAS="$(($HORAS + $entero_minutos))"
		fi



		if [ "$HORAS" -ge "24"  ]
		then
			parte_resto=$(echo "$HORAS"%24 | bc )
			parte_entera=$(( $HORAS / 24 ))
			HORAS=$parte_resto
			dias=$parte_entera
		fi
		

		if ! [ "$dias" = "" ]
		then
	    	echo El tiempo total de conexion es : "$dias" dias ,  "$HORAS"  horas y "$MINUTOS"  minutos.
		else
			echo El tiempo total de conexion es "$HORAS" horas y "$MINUTOS" minutos.
		fi
		echo
            fi
                 ;;

         u) USER=${OPTARG}

                 if  [ "$2" = "-r" ] || [ "$3"  = "-r" ]
                 then
                         echo "Los modificadores deben colocarse en el orden -r y -u">&2
                         exit 6
                 fi

                 if ! grep -q "^$USER:" /etc/passwd
                 then
                         echo "No existe el usuario "$USER"  en el sistema.">&2
                         exit 2
                 fi
		
		 
		 
		 if  [ "$1" = "-r" ] || [ "$2"  = "-u" ]
                 then
			 if [ "$#" -gt "3"  ]
			 then
				 echo "Cantidad de parámetros errónea, solo se aceptan los modificadores -r y -u '(seguido de un nombre de usuario)'">&2
				 exit 3
			 fi
               		 
		 a="`last "$USER"| egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -1`"
                	 if  [ "$a" == "" ]
                	 then
                         	echo "No se han encontrado conexiones para listar en el sistema para el usuario "$USER".">&2
                	 exit 0
               		 fi




                rango=$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | wc -l)

                echo  Usuario "$(printf "\t")" Terminal "$(printf "\t")" Host "$(printf "\t\t")" Fecha "$(printf "\t\t")" H.con "$(printf "\t\t")" H.Dest "$(printf "\t\t")" T.Con
                for i in $( seq 1 $rango )
                do
            min_inicio=`last "$USER"| egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -$i|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]"|cut -d":" -f2|egrep -o "[0-9][0-9]"`
            horas_inicio=`last "$USER"|egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -$i|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]"|cut -d":" -f1|egrep -o "[0-9][0-9]"`
            min_final=`last "$USER"|egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -1|tail -1 | cut -d    "-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]"|cut -d":" -f2|egrep -o "[0-9][0-9]"`
            horas_final=`last "$USER"|egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -1|tail -1 | cut -d    "-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]"|cut -d":" -f1|egrep -o "[0-9][0-9]"`
            min_totales=`echo $min_inicio + $min_final |bc`
            horas_totales=`echo $horas_inicio + $horas_final|bc`
                if [ "$horas_totales" -ge "24" ]
                then
                        $horas_totales=$( echo $horas_totales-24|bc)
                fi


                if [ "$min_inicio" -ge "60"  ]
                then
                        resto_minutos_totales=$( echo "$min_totales"%60 | bc)
                        entero_minutos_totales=$(( $min_totales / 60 ))
                        min_totales=$resto_minutos_inicio
                        horas_totales="$(($horas_totales + $entero_minutos_totales))"
                fi

                if [ "$horas_totales" -ge "24" ]
                then
                        $horas_totales=$( echo $horas_totales-24|bc)
                fi

                tiempo_inicio="$horas_totales"":""$min_totales"			


                echo "$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$"|head -"$i"|tail -1|cut -d" " -f1)""$(printf "\t\t ")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 |cut -d":" -f3 | egrep -o "^[0-9]")""$(printf "\t\t ")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d":" -f3|grep -o "^[0-9]")""$(printf "\t\t")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$"| head -"$i"|tail -1 | egrep -o "[A-Z][a-z][a-z][ ]+[A-Z][a-z][a-z][ ]+[0-9]?[0-9]")""$(printf "\t")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]")""$(printf "\t\t")""$(echo "  $tiempo_inicio")""$(printf "\t\t\t ")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d"-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]")"
                done			 
			 
			 
			 
			 MINUTOS=`last "$USER"| egrep -o "[(][0-9][0-9][:][0-9][0-9][)]"| egrep -o "[0-9][0-9][:][0-9][0-9]"| cut -d":" -f2| awk '{total = total + $1}END{print total}'`
                	 HORAS=`last  "$USER" | egrep -o "[(][0-9][0-9][:][0-9][0-9][)]"| egrep -o "[0-9][0-9][:][0-9][0-9]"| cut -d":" -f1| awk '{total = total + $1}END{print total}'`
                	 rango=$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | wc -l)
			
               		if [ "$MINUTOS" -ge 60  ]
                	then
                         	resto_minutos=$( echo "$MINUTOS"%60 | bc)
                         	entero_minutos=$(( $MINUTOS / 60 ))
                        	MINUTOS=$resto_minutos
                        	HORAS="$(($HORAS + $entero_minutos))"
                        fi



                	if [ "$HORAS" -ge "24"  ]
                	then
                        	parte_resto=$(echo "$HORAS"%24 | bc )
                        	parte_entera=$(( $HORAS / 24 ))
                        	HORAS=$parte_resto
                        	dias= $parte_entera
                	fi


                	if ! [ "$dias" = "" ]
                	then
                		echo El tiempo total de conexion es : "$dias" dias ,  "$HORAS"  horas y "$MINUTOS"  minutos.
                	else
                        	echo El tiempo total de conexion es "$HORAS" horas y "$MINUTOS" minutos.
                	fi
                	echo
			 
			 


		else

			k=`last "$USER" | head -1`
			if  [ "$k" == "" ]
			then
     				echo "No se han encontrado conexiones para listar en el sistema.">&2
     				exit 0
			fi

                rango=$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | wc -l)

                echo  Usuario "$(printf "\t")" Terminal "$(printf "\t")" Host "$(printf "\t\t")" Fecha "$(printf "\t\t")" H.con "$(printf "\t\t")" H.Dest "$(printf "\t\t")" T.Con
                for i in $( seq 1 $rango )
                do
            min_inicio=`last "$USER"| egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -$i|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]"|cut -d":" -f2|egrep -o "[0-9][0-9]"`
            horas_inicio=`last "$USER"|egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -$i|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]"|cut -d":" -f1|egrep -o "[0-9][0-9]"`
            min_final=`last "$USER"|egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -1|tail -1 | cut -d    "-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]"|cut -d":" -f2|egrep -o "[0-9][0-9]"`
            horas_final=`last "$USER"|egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -1|tail -1 | cut -d    "-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]"|cut -d":" -f1|egrep -o "[0-9][0-9]"`
            min_totales=`echo $min_inicio + $min_final |bc`
            horas_totales=`echo $horas_inicio + $horas_final|bc`
                if [ "$horas_totales" -ge "24" ]
                then
                        $horas_totales=$( echo $horas_totales-24|bc)
                fi


                if [ "$min_inicio" -ge "60"  ]
                then
                        resto_minutos_totales=$( echo "$min_totales"%60 | bc)
                        entero_minutos_totales=$(( $min_totales / 60 ))
                        min_totales=$resto_minutos_inicio
                        horas_totales="$(($horas_totales + $entero_minutos_totales))"
                fi

                if [ "$horas_totales" -ge "24" ]
                then
                        $horas_totales=$( echo $horas_totales-24|bc)
                fi

                tiempo_inicio="$horas_totales"":""$min_totales"


                echo "$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$"|head -"$i"|tail -1|cut -d" " -f1)""$(printf "\t\t ")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 |cut -d":" -f3 | egrep -o "^[0-9]")""$(printf "\t\t ")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d":" -f3|grep -o "^[0-9]")""$(printf "\t\t")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$"| head -"$i"|tail -1 | egrep -o "[A-Z][a-z][a-z][ ]+[A-Z][a-z][a-z][ ]+[0-9]?[0-9]")""$(printf "\t")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d"-" -f1 | egrep -o "[^(][0-9][0-9][:][0-9][0-9]")""$(printf "\t\t")""$(echo "  $tiempo_inicio")""$(printf "\t\t\t ")""$(last "$USER" | egrep ".*[(][0-9][0-9][:][0-9][0-9][)]$" | head -"$i"|tail -1 | cut -d"-" -f2 | grep -o "[(][0-9][0-9][:][0-9][0-9][)]"| grep -o "[0-9][0-9][:][0-9][0-9]")"


                done   




		 fi
                 ;;
         :)
                echo “No se ha especificado el usuario para el modificador -u.”>&2
                exit 1 ;;
	*) if [ "$#" -gt "3" ]
	 then
		 echo "Cantidad de parámetros errónea, solo se aceptan los modificadores -r y -u (seguido de un nombre de usuario">&2
		 exit 3
	 fi
		 echo "Modificador "$*" incorrecto. Solo se aceptan -r y -u usuario, y en ese orden en caso de estar ambos presentes.">&2 
		 exit 4
         ;;

         esac
        done



