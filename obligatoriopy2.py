import subprocess
from subprocess import Popen, PIPE
import argparse
import sys

parser = argparse.ArgumentParser()

parser.add_argument("-r", "--recursive", help="Muestra la salida de las horas", action="store_true")
parser.add_argument("-u", "--user", type=str , help="Muestra para un usuario en particular.")

try:
 args = parser.parse_args()
except SystemExit as e:
 exit(20)


ej1_y_lista_parametros = ['/home/linux/Desktop/Scripts/Obligatorio/obligatorio16.sh']

if args.recursive:
    ej1_y_lista_parametros.append("-r")

if args.user:
    ej1_y_lista_parametros.append("-u")
    ej1_y_lista_parametros.append(args.user)


process=Popen(ej1_y_lista_parametros, stdout = PIPE, stderr = PIPE)

output=process.communicate()

if process.returncode > 0:
    print(output[1].decode(), file = sys.stderr, end="")
    exit(process.returncode)

print(output[0].decode(), file=sys.stdout)
