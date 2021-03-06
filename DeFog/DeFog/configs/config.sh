#!/usr/bin/env bash
#########################################################################################################################
# CSC4006 - Research And Development Project
# Developed by: Jonathan McChesney (MEng Computer Games Development)
# Queen's University Belfast
#
# Component: config.sh
#
# Purpose: Configuration (config) file paramter setup, used to customise the development/deployment environment.
#
#########################################################################################################################
cloudaddress="ec2-3-127-80-109.eu-central-1.compute.amazonaws.com" 							# Cloud EC2 instance address
clouduser="ubuntu" 								# Cloud username e.g. IAM user ec2user1
cloudpublicip=3.127.80.109						# Cloud public ip address
edgeaddress1=XXX.XXX.X.XX						# Edge Node 01 ip address
edgeuser1=root									# Edge Node 01 username
edgeaddress2=192.168.0.101						# Edge Node 02 ip address
edgeuser2=pi				 		# Edge Node 02 username
awskey=~/DeFog/Experiments/DeFog/configs/csc4006awskey.pem 		# .pem file location on the local user device
edgeawskey=/mnt/configs/csc4006awskey.pem 		# .pem file location on the Edge Node
foglampaddress="http://localhost:8081"			# foglamp localhost server addresss
