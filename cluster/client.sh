#!/bin/bash

case $1 in
  db)
    # mysql client connection
    docker exec -it client mysql -h 172.31.0.21 -prootme
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
    # make some data
    docker exec -it client mysqlslap --user=root --host=172.31.0.21 --password=rootme --engine=ndbcluster --auto-generate-sql --create-schema=testdata --number-int-cols=5 --number-char-cols=5 --protocol=tcp --auto-generate-sql-write-number=100 --auto-generate-sql-add-autoincrement --iterations=1 --no-drop
  ;;
  drop)
    # make some data
    docker exec -it client bash -c "echo 'drop database testdata;' | mysql -h 172.31.0.21 -prootme"
  ;;
  *)
    echo ""
    echo "usage: client.sh <db|ndb_mgm|memstats|backup|load|drop>"
    echo ""
  ;;
esac
    

  
