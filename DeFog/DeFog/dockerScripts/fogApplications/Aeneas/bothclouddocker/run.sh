docker run --rm -v /home/ubuntu/defog/configs:/mnt/configs -v /home/ubuntu/defog/assets:/mnt/assets -v /home/ubuntu/defog/results:/mnt/results -v /root/.aws:/root/.aws --name bothcloudaeneas bothcloudaeneas ../scripts/execute.sh