# 结束 Stapxs Web API
# 这儿需要结束启动命令，二级启动命令（都带有标记）
# 以及一个主程序
pid=$(ps -ef | grep -v 'grep' | egrep stapxswebapi | awk '{printf $2 ","}')
pid+=$(lsof -i:3000 | sed -n "2p" | awk '{printf $2}')
if [ "$pid" != "" ]; then      
    echo -n "boot ( pid $pid) is running" 
    echo 
    echo "kill boot process"
    arr=(${pid//,/ })
    for var in ${arr[@]}
    do
        echo ${var}
        kill -9 ${var}
    done
else 
    echo "boot is stopped" 
fi
status