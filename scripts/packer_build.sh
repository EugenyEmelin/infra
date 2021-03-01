#!/bin/bash
set -e

packer validate ./packer/ubuntu16.json

packer build ./packer/ubuntu16.json
