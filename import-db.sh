#!/bin/bash

echo "Importing MySQL dump into database."

HOST=main_db
DB=$1
FILE=$2

if [[ ! -f $FILE ]]; then
	echo "Dump file not found."
	exit 404
fi
if [[ -z $DB ]]; then
	echo "Please provide a database name."
	exit 500
fi

SIZE=`gzip -l $FILE | sed -n 2p | awk '{ print $2 }'`
zcat < $FILE | pv --size=$SIZE | docker exec -i $HOST mysql -uroot $DB
echo "Done!"
