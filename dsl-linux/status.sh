pid=$(ps -ef | grep -v 'grep' | egrep stapxswebapi | awk '{printf $2 " "}')
if [ "$pid" != "" ]; then
    echo "running:$pid"
else
    echo "boot is stopped"
fi