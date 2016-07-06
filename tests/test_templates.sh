#!/bin/bash
set -e

if which colordiff >/dev/null 2>&1; then
   diff=colordiff
else
   diff=diff
fi

cd $(dirname ${BASH_SOURCE[0]})
ansible-playbook test_templates.yml

echo "SHOW DIFF **********************************************************************"
$diff -Naur test_out.mk reference.mk

cd - >/dev/null
