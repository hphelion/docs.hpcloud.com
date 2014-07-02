#!/bin/bash -e
#
# Run a standalone server.  You must build first
#

echo 'running docs.hpcloud.com/jenkins/server.sh'
ejekyll --server --auto
