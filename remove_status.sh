#!/bin/bash

#####	NOME:				remove_status.sh
#####	VERSÃO:				1.0
#####	DESCRIÇÃO:			Script para a correção do arquivo status. 			
#####	DATA DA CRIAÇÃO:	24/01/2019
#####	ESCRITO POR:		Maurício G. Paiva
#####	E-MAIL:				mauriciodez@gmail.com 			
#####	DISTRO:				Debian GNU/Linux 8 (jessie)
#####	LICENÇA:			GPLv3 			
#####	PROJETO:			https://github.com/mauriciodez/remove_status.git

NAME="Nome_do_pacote"
NAMEC=`echo "Package: $NAME"`
ARQ="/var/lib/dpkg/status"


grep -o "$NAMEC" $ARQ > /dev/null


if [ $? == 0 ];then

	cp -v $ARQ $ARQ.bkp

		if [ -e $ARQ.bkp ];then
			gawk -v VAR="$NAMEC" -i inplace 'BEGIN{RS="\n\n"} $0 !~ VAR {print $0"\n"}' $ARQ
			apt update
			apt install -y $NAME
			rm $ARQ.bkp
		fi
else
	echo "$NAME não encontrado !!!"
fi