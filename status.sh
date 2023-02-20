# Stapxs Web API 状态监听
pid=$(lsof -i:3000 | sed -n "2p" | awk '{printf $2}')
if [ "$pid" != "" ]; then
    echo "running"
else
    echo "boot is stopped"
fi