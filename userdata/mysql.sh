#!/bin/bash
set -e

# Update packages
dnf update -y

# Install MariaDB
dnf install -y mariadb105-server

# Configure MariaDB for AWS DMS CDC
cat <<EOF >/etc/my.cnf.d/dms-cdc.cnf
[mariadb]
server_id=1
log_bin=mysql-bin
binlog_format=ROW
binlog_row_image=FULL
expire_logs_days=7
EOF

# Enable and start MariaDB
systemctl enable mariadb
systemctl restart mariadb