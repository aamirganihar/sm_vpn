#!/bin/bash
OLD="xyz"
NEW="abc"
DPATH="D:\jakarta-jmeter-2.3.4\bin\One.json"
BPATH="D:\jakarta-jmeter-2.3.4\bin\TWO.csv"
TFILE="/tmp/out.tmp.$$"
[ ! -d $BPATH ] && mkdir -p $BPATH || :
for f in $DPATH
do
  if [ -f $f -a -r $f ]; then
    /bin/cp -f $f $BPATH
   sed "s/$OLD/$NEW/g" "$f" > $TFILE && mv $TFILE "$f"
  else
   echo "Error: Cannot read $f"
  fi
done
/bin/rm $TFILE