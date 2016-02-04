#!/bin/bash

case $1 in
  shell)
    # bash shell
    docker exec -it client /bin/bash
  ;;
  db)
    if [ "$2" != "" ]
    then
      database=$2
    else
      database="mysql"
    fi
    # mysql client connection
    docker exec -it client mysql -h 172.31.0.21 -prootme -D $database
  ;;
  ndb_mgm)
    # interactive management node client
    docker exec -it client ndb_mgm
  ;;
  memstats)
    # show ndbd memory stats
    docker exec -it client ndb_mgm -e "all report memory"
  ;;
  backup)
    # run a ndbcluster backup
    docker exec -it client ndb_mgm -e "start backup"
  ;;
  load)
    if [ "$2" != "" ]
    then
      count=$2
    else
      count=10000
    fi
    # make some data
    time docker exec -it client mysqlslap --user=root --host=172.31.0.21 --password=rootme --engine=ndbcluster --auto-generate-sql --create-schema=testdata --number-int-cols=5 --number-char-cols=5 --protocol=tcp --auto-generate-sql-write-number=$count --auto-generate-sql-add-autoincrement --iterations=1 --no-drop
  ;;
  drop)
    # make some data
    docker exec -it client bash -c "echo 'drop database testdata;' | mysql -h 172.31.0.21 -prootme"
  ;;
  shutdown)
    # show ndbd memory stats
    docker exec -it client ndb_mgm -e "shutdown"
    docker exec -it mysqld1 /usr/local/mysql/support-files/mysql.server stop
    docker exec -it mysqld2 /usr/local/mysql/support-files/mysql.server stop
    docker exec -it client pkill sleep
  ;;
  *)
    echo ""
    echo "usage: client.sh <shell|db|ndb_mgm|memstats|backup|load|drop|shutdown>"
    echo ""
  ;;
esac
    

  
