# 启动 Stapxs Web API 服务
source ~/.bashrc
nvm use 16
nohup yarn start:debug stapxswebapi > log.log 2>&1 &  
sleep 3
head -n 10 log.log