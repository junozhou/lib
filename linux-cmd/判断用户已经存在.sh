#!/bin/bash

read -p "please input a username:" username

if id -u $username >/dev/null 2>&1; then
        echo "user exists"
else
        echo "user does not exist"
fi