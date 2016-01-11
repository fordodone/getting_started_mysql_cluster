#!/bin/bash
IFS="
"
for i in `docker images | grep ^cluster | awk '{print $3}'`; do docker rmi -f $i; done;
