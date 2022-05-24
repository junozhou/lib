#!/bin/bash

#删除前两行

sed -i '1,2d' filename

#删除后两行

sed -i '$d' filename

sed -i '$d' filename