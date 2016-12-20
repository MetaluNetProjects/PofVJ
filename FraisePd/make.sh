#!/bin/bash

#$1=directory to make 
#$2=pdsend port
FRAISEH=`dirname $0`/../
export FRAISE=`readlink -f $FRAISEH`
export PROJ=`basename $1`
BOARDLINE=`grep BOARD $1/$PROJ.c`
export BOARD=${BOARDLINE##*BOARD}
export BOARD=${BOARD##* }
MODULES_E=

for module in `ls $FRAISE/modules` ; do
	if test -d $FRAISE/modules/$module ; then
		x=`grep $module.h $1/$PROJ.c`
		y="${x:1:8}"
		if [ x$y = xinclude ] ; then MODULES_E+="$module "; fi
	fi
done 

export MODULES_E

(
	echo "FRAISE: $FRAISE"
	echo "PROJ: $PROJ"
	echo "BOARD: $BOARD"
	echo "MODULES: $MODULES_E"
	make -C $1 -f $FRAISE/Makefile 2>&1
) | sed 's/$/;/'|  pdsend $2

#| pdsend $2
