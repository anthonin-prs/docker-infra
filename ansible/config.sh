#!/bin/bash
export ANSIBLE_CONFIG=$(pwd)/ansible.cfg
ansible-inventory --list all

#ansible-galaxy role init rolename
#ansible-galaxy role install community-role