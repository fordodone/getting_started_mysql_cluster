#!/bin/bash

mysqlslap --user=root \
--host=172.31.0.21 \
--password=rootme \
--auto-generate-sql \
---auto-generate-sql-guid-primary \
--engine=ndbcluster \
--number-int-cols=5 \
--number-char-cols=5 \
--protocol=tcp \
--concurrency=50 \
--auto-generate-sql-write-number=1000 \
--auto-generate-sql-execute-number=100 \
--iteration=1 \
--auto-generate-sql-load-type=mixed 
