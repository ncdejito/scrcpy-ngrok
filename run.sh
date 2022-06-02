
# Display and control Android over 4G network

NGROK_TOKEN=abcdefghijklmnop123456789 # found in https://dashboard.ngrok.com/ after signing up
TERMUX_FOLDER=data/data/com.termux/files/home/ # on android start termux session then type "pwd"
ANDROID_SAVE_FOLDER=/storage/24C7-15F5/ # choose where you save the ngrok file
DEVICE_IP=192.168.1.1 # Android Phone > Settings > About Phone > IP Address


# download ngrok file inside this zip file
# https://flakie.co.uk/downloads/setup-ngrok.zip

# connect to PC to android via USB or wireless using ADB
# https://github.com/Genymobile/scrcpy#manual

# copy ngrok file from PC to your android phone
adb connect DEVICE_IP:5555 && \
    adb push ngrok $ANDROID_SAVE_FOLDER # optional, you can just drag and drop the file

# save to termux folder (hidden in android file managers)
cp $ANDROID_SAVE_FOLDER/ngrok $TERMUX_FOLDER

# disconnect wifi, connect 4G network

# run ngrok on termux
chmod +x ngrok
./ngrok authtoken $YOUR_NGROK_TOKEN
./ngrok tcp 5555
# will see something like:
# Forwarding tcp://123.tcp.ngrok.io:123456 -> localhost:5555

# run scrcpy over 4G
adb connect 123.tcp.ngrok.io:123456
scrcpy --turn-screen-off --stay-awake --rotation 1 --bit-rate 2M --max-size 800