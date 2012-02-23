#!/bin/bash

echo "Starting Xvfb"
sh -e /etc/init.d/xvfb start

echo "Creating databases for sqlite3 and loading schema"
bundle exec rake db:create --trace
bundle exec rake db:schema:load --trace