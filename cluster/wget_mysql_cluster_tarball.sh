#!/bin/bash

wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.4/mysql-cluster-gpl-7.4.6-linux-glibc2.5-x86_64.tar.gz && \
md5sum mysql-cluster-gpl-7.4.6-linux-glibc2.5-x86_64.tar.gz | awk '{print $1}' >mysql-cluster-gpl-7.4.6-linux-glibc2.5-x86_64.tar.gz.md5sum && \
diff <(cat mysql-cluster-gpl-7.4.6-linux-glibc2.5-x86_64.tar.gz.md5sum) <(echo "9f52688cf530409d1b566b0c42852a4c") || echo "md5sum is wrong "

wget http://mirrors.kernel.org/ubuntu/pool/main/liba/libaio/libaio1_0.3.109-4_amd64.deb && \
md5sum libaio1_0.3.109-4_amd64.deb | awk '{print $1}' > libaio1_0.3.109-4_amd64.deb.md5sum && \ 
diff <(cat libaio1_0.3.109-4_amd64.deb.md5sum) <(echo "cd9da2f52a5d7713e5080c5ed6916a41") || echo "md5sum is wrong"

mkdir -p volumes/ndbd1/common
mkdir -p volumes/ndbd2/common
mkdir -p volumes/ndb_mgmd1/common
mkdir -p volumes/ndb_mgmd2/common
mkdir -p volumes/mysqld1/common
mkdir -p volumes/mysqld2/common
mkdir -p volumes/client/common
