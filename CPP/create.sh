#!/bin/bash

function build {
	cd DistanceCalculation/
	
	if [ $# -ne 0 ]; then
		make clean
	fi
	
	make -j 9

	if [ $? -ne 0 ]; then
		exit 1
	fi

	cd ../Localization/
	
	if [ $# -ne 0 ]; then
		make clean
	fi

	make -j 9

	if [ $? -ne 0 ]; then
		exit 1
	fi

	cd ../Localization3D/

	if [ $# -ne 0 ]; then
		make clean
	fi
	
	make -j 9

	if [ $? -ne 0 ]; then
		exit 1
	fi
	
	cd ../
}

function run {
	
	cd DistanceCalculation/bin/
	until ./DistanceCalculation -p 3 -er 0 -f data/speaker_ips -tf testTone.wav -t NOTHING; do echo "Running again"; sleep 1; done
	cd ../../
}

if [ $# -eq 0 ]; then
	build
else
	if [ $1 = "clean" ]; then
		build clean
	elif [ $1 = "run" ]; then
		build
		run	
	else
		cd $1
		make -j 9
		
		if [ $? -ne 0 ]; then
			exit 1
		fi
		
		cd ../
	fi
fi
