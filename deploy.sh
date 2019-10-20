#!/bin/sh

aws s3 cp --recursive ./build s3://climbinggrades.xyz --profile personal

