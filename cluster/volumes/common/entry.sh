#!/bin/bash

# capture args
TYPE=$1

# initial flag for first start
if [ -f /var/lib/mysql-cluster/common/initial ]
then
  INITIAL='--initial'
fi

# helpful aliases
alias show='/usr/local/mysql/bin/ndb_mgm -c "172.31.0.1,172.31.0.2" -e show'
alias db='/usr/local/mysql/bin/mysql -h 172.31.0.21 -uroot -prootme'

# set type of container
case $TYPE in
  ndb_mgmd)
    # start management nodes
    /usr/local/mysql/bin/ndb_mgmd --skip-config-cache --config-dir=/var/lib/mysql-cluster/common/ --config-file=/var/lib/mysql-cluster/common/config.ini --nodaemon $INITIAL
  ;;
  ndbd)
    # start data nodes
    /usr/local/mysql/bin/ndbd --nodaemon $INITIAL
  ;;
  mysqld)
    # start API nodes
    if [ "$INITIAL" == "--initial" ]
    then
      cd /usr/local/mysql && ./scripts/mysql_install_db --user=mysql

      cd /var/lib/mysql-cluster && \
      /usr/local/mysql/support-files/mysql.server start && \
      /usr/local/mysql/bin/mysqladmin -u root password 'rootme' && \
      echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY PASSWORD '*FAAA67924961263057D0546413F1F88CE1793236' WITH GRANT OPTION;" | /usr/local/mysql/bin/mysql -prootme
    fi

    cd /var/lib/mysql-cluster && /usr/local/mysql/bin/mysqld_safe 
    
  ;;
  client)
    # start a noop container for client connections using same image to mysql or ndb_mgm
    /bin/sleep infinity
  ;;
  *)
    echo ""
    echo "usage: entry.sh <ndb_mgmd|ndbd|mysqld|client>"
    echo ""
    exit
  ;;
esac


