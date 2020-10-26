#! /bin/bash
for line in `grep worker *yaml | grep 146 | awk '{print $1}' | awk -F':' '{print $1}'`
do
 echo $line
 kubectl replace -f $line --force
done