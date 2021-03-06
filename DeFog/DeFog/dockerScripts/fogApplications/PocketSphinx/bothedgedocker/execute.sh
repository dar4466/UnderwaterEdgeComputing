#!/bin/bash

rm /mnt/results/cloudresult.txt
rm /mnt/results/arrresult.txt

source /mnt/configs/config.sh

cloudaddress1="${cloudaddress/$'\r'/}"
clouduser1="${clouduser/$'\r'/}"
edgeawskey1="${edgeawskey/$'\r'/}"

cloudaddress2="${cloudaddress1/$'\n'/}"
clouduser2="${clouduser1/$'\n'/}"
edgeawskey2="${edgeawskey1/$'\n'/}"

cd ~/Experiments/PocketSphinx/sphinxbase/ 
chmod 400 /mnt/configs/csc4006awskey.pem
export LD_LIBRARY_PATH=/usr/local/lib
cd pocketsphinx/

metricsValues=("NA" "NA" "NA" "NA" "NA" "NA" "NA" "NA" "NA" "NA" "NA")

start=$(date +%s.%N)
	# python receiver.py en-us/
	# scp -o StrictHostKeyChecking=no -i $edgeawskey2 $clouduser2@$cloudaddress2:/home/ubuntu/defog/assets/en-us/* ./model/en-us/
	transfer_cloud=$(scp -v -o StrictHostKeyChecking=no -i $edgeawskey2 $clouduser2@$cloudaddress2:/home/ubuntu/defog/assets/en-us/* ./model/en-us/ 2>&1 | grep "Transferred") 		
	nocarriagereturns=${transfer_cloud//[!0-9\\ \\.]/}
	newarr1=(`echo ${nocarriagereturns}`);
	echo cloud to edge transfer size etc
	echo ${newarr1[@]}
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Cloud Transfer: completed in $runtime secs" | tee -a results.txt
metricsValues[9]=${newarr1[1]}
metricsValues[10]=$runtime

start=$(date +%s.%N)
pocketsphinx_continuous -infile /mnt/assets/psphinx.wav -logfn /dev/null
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Computation: completed in $runtime secs" | tee -a results.txt

metricsValues[1]=$runtime

echo "Starting Upload to S3 Bucket..."
chmod 777 s3Upload.py

start=$(date +%s.%N)
python s3Upload.py result.txt psphinx-result.txt
end=$(date +%s.%N)
runtime=$( echo "$end - $start" | bc -l )
echo "Upload to S3 bucket: completed in $runtime secs" | tee -a results.txt

metricsValues[2]=$runtime

length=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 /mnt/assets/psphinx.wav)
  
metricsValues[5]=$length

cat results.txt >> /mnt/results/cloudresult.txt
echo ${metricsValues[@]} >> /mnt/results/arrresult.txt

cp ./result.txt ./returnedasset.txt
mv ./returnedasset.txt /mnt/results/

exit

