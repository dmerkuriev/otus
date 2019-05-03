#!/bin/env bash
DB=db_name
echo "nice_high & nice_low started at '$(date)'" > nice.log

nice_high() {
   pg_dump -U postgres $DB | nice --19 gzip -c > $DB-nice_high.sql.gz
   echo "dump_high stoped at '$(date)'" >> nice.log
}

nice_low() {
   pg_dump -U postgres $DB | nice -20 gzip -c > $DB-nice_low.sql.gz
   echo "dump_low stoped at '$(date)'" >> nice.log
}

nice_high &
nice_low &
