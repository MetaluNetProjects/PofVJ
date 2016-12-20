#!/bin/bash

#$1=directory to make
#$2=
(
	FRAISEH=`dirname $0`/../
	FRAISE=`readlink -f $FRAISEH`
	PROJ=`basename $1`
	BOARDLINE=`grep BOARD $1/$PROJ.c`
	BOARD=${BOARDLINE##*BOARD}
	BOARD=${BOARD##* }

	echo Proj: $PROJ
	echo Board: $BOARD

	ORIGIN=$PWD
	cd `dirname $0`/../bootloader/18f/
	./program.sh $BOARD 
#echo `expr index $Ligne '='`
#$1 | sed 's/$/;/' | sed 's/^/make/' | pdsend $2
	cd $ORIGIN
) | sed 's/$/;/' | pdsend $2
