#!/bin/bash

for (( $i=0; $i<$1; $i++ ))
do

	cp $2.txt $2_$i.txt
	
done