#!/bin/bash

mysqlslap --user=root \
--host=172.31.0.21 \
--password=rootme \
--auto-generate-sql \
--engine=ndbcluster \
--number-int-cols=5 \
--number-char-cols=5 \
--protocol=tcp \
--concurrency=5 \
--auto-generate-sql-write-number=1000000 \
--iteration=1 \
--auto-generate-sql-load-type=write \
--no-drop

#--auto-generate-sql-guid-primary \
#--auto-generate-sql-execute-number=1000 \
