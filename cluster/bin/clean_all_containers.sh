#!/bin/bash
IFS="
"
for i in `docker ps -a | grep -v ^CONTAI | awk '{print $1}'`; do docker rm -f $i; done;
