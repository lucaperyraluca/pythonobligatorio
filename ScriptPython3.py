import subprocess
from subprocess import Popen, PIPE
import argparse
import sys 

parser = argparse.ArgumentParser()

parser.add_argument("-r", "--recursive", help="Muestra la salida de las horas", action="store_true")
parser.add_argument("-u", "--user", type=str , help="Muestra para un usuario en particular.")
parser.add_argument("-o", "--order", type=str, choices=["u", "t", "h", "d"], help="Ordena" )

try:
 args = parser.parse_args()
except SystemExit as e:
 exit(20)

#ruta al script en bash
ej1_y_lista_parametros = ['/home/linux/Desktop/Scripts/Obligatorio/obligatorio3.sh']
#agrego el parametro a la lista
if args.recursive:
    ej1_y_lista_parametros.append("-r")
#agrego el parametro como string a la lista   
if args.user:
    ej1_y_lista_parametros.append("-u")
    ej1_y_lista_parametros.append(args.user)

process=Popen(ej1_y_lista_parametros, stdout = PIPE, stderr = PIPE)
output=process.communicate()

#muestra la salida de error:
if process.returncode > 0:
    print(output[1].decode(), file = sys.stderr, end="")
    exit(process.returncode)

#opcion -r
if args.recursive == True:
    print(output[0].decode(), file=sys.stdout)
#opcion -u
if args.user != None:
    print(output[0].decode(), file=sys.stdout)

#OPCION ORDENAR
if args.order == "u":
    lista=output[0].decode().split("\n")
    otra_lista=[]
    for i in lista:
        i_procesado= i.split()
        otra_lista.append(i_procesado)

    #a=(len(otra_lista[0]) + 1)
    b=(len(otra_lista) - 1)

    for i in range(1,b):
        if (len(otra_lista[(i)])) < 9:
            otra_lista[(i)].append("?")
            if (len(otra_lista[(i)])) < 9:
                otra_lista[(i)].append("?")

    #Genero una lista donde cada tupla  tiene una posicion
    # fijarme si aca puedo usar len(lista_de_tuplas) en lugar de b,le saco el 0 porque? 
    lista_de_tuplas=[]
    for i in range(1,b):
        lista_de_tuplas.append(otra_lista[(i)])

    #con la funcion sort le digo que se ordene por la clave definida en lambda como el ubicado en la primer posicion
    lista_de_tuplas.sort(key=lambda p: p[0])

    #convierto las listar en string con join, y luego reemplazo las comas por tabulaciones y/o espacios
    cabecera=",".join(otra_lista[0])
    cabecera_ordenada=cabecera.replace(',','\t\t  ')
    print(cabecera_ordenada)
    for i in range(1,(b-1)):
        linea=",".join(lista_de_tuplas[(i)])
        linea_ordenada=linea.replace(',','\t\t')
        print(linea_ordenada)
    
