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
    otro_diccionario=[]
    for i in lista:
        i_procesado= i.split()
        print(i_procesado)     

    

    
