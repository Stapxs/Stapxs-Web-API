pid=$(ps -ef | grep -v 'grep' | egrep stapxswebapi | awk '{printf $2 " "}')
if [ "$pid" != "" ]; then      
    echo -n "boot ( pid $pid) is running" 
    echo 
    echo -n $"Shutting down boot: "
    pid=$(ps -ef | grep -v 'grep' | egrep stapxswebapi | awk '{printf $2 " "}')
    if [ "$pid" != "" ]; then
        echo "kill boot process"
        kill -9 "$pid"
    fi
    else 
         echo "boot is stopped" 
    fi
status