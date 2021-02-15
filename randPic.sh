#!/bin/sh
# Version: 2.0.2
# Description: Download a random wallpaper from wallhaven.cc.
# install jq "a lightweight and flexible command-line JSON processor." from PPM

# Name for your wallpaper image
img="wallpaper.jpg"

# keyword
keyword="fantasy"

# Image folder location
imgFolder="/root/Desktop"

# Combine the two above
wallpaper="$imgFolder/$img"

# Address for the wallpaper website along with all of the selected options
wallpaperURL="https://wallhaven.cc/api/v1/search?sorting=random&q=$keyword"

# remove file
 cd $imgFolder; rm $img

rand=$(( ( RANDOM % 20 )  + 1 ))
echo $rand
# url random
randPic=$(curl -s $wallpaperURL | jq -r ".data["$rand"].path")
# randPic=$(curl -s $wallpaperURL | jq -r ".data["$(shuf -i 1-10 -n 1)"].path")

#only first element
# randPic=`curl -s $wallpaperURL | jq -r '.data[1].path'`

echo $img
echo $randPic

# Download it
  cd $imgFolder
  # wget $img $randPic 
  wget -c $randPic -O $img  
 # curl $randPic > $img

#wget -q http://www.whatever.com/filename.txt -O /path/filename.txt 
# wget -c https://gist.github.com/chales/11359952/archive/25f48802442b7986070036d214a2a37b8486282d.zip -O db-connection-test.zip

#sleep 15
#set wallpaper
#bg=$($imgFolder"/"$img)
#chmod 777 o+x $($imgFolder"/"$img)
bg=$imgFolder"/"$img
echo $bg
  set_bg $bg

exit 0
