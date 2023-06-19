#!/bin/bash

timing=$1

corr=$2

CON=$3

mscript=DCM.estimation.m

for n in `cat $timing/$corr/$CON/list`

do

cp -rf $mscript $timing/$corr/$CON/$n/DCM.estimation.m

sed -i "s#sub#$timing/$corr/$CON/${n}#g" $timing/$corr/$CON/$n/DCM.estimation.m

done 
