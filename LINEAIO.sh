#!/bin/bash
echo "Number of Sticker file"
read sticknum
echo "Directory for unzipped Stickers?"
read dirt
echo "Not Animated, Try Again, Animated"
answer=("Not Animated" "Try Again" "Animated")
select choice in "${answer[@]}"; do
	case $choice in
		"Animated")
			echo "Animated .GIFs"
			echo "http://dl.stickershop.line.naver.jp/products/0/0/1/$sticknum/iphone/stickerpack@2x.zip"
			wget http://dl.stickershop.line.naver.jp/products/0/0/1/$sticknum/iphone/stickerpack@2x.zip
			echo "DONE!"
			break
			;;
        "Not Animated")
			echo "http://dl.stickershop.line.naver.jp/products/0/0/1/$sticknum/iphone/stickers@2x.zip"
			wget http://dl.stickershop.line.naver.jp/products/0/0/1/$sticknum/iphone/stickers@2x.zip
			echo "DONE!"
			break
			;;
		"Try Again")
			echo "https://stickershop.line-scdn.net/stickershop/v1/product/$sticknum/iphone/stickers@2x.zip"
			wget https://stickershop.line-scdn.net/stickershop/v1/product/$sticknum/iphone/stickers@2x.zip
			echo "DONE!"
			break
			;;
		* ) echo "BAILOUT!!!"
			exit
			;;
	esac
done
unzip *.zip -d $dirt
rm *.zip
rm $dirt/*_key*.png
rm $dirt/*.meta
rm $dirt/tab*.png
read -p "Trim? Resize?" answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	echo "Directory is:" $dirt
	mkdir $dirt/half/
	read -p "is PNG?" answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
	#Trim
	for t in $dirt/*.png; do convert "$t" -depth 32 -trim "${t%%}"; done
	echo "Trimmed!"
	#Resize
	cp $dirt/*.png $dirt/half 
	for f in $dirt/half/*.png; do convert "$f" -resize 50% "${f%%}"; done
	echo "Resized!"
	else
	#Trim GIF Convert using APNG first
	echo "Go convert the APNG to GIF. Drag and drop APNG"
	read -p "Mash Enter to GO!"
	for f in $dirt/*.gif; do convert "$f" -coalesce -repage 0x0 "${f%%}"; convert "$f" -trim "${f%%}"; done
	#Resize GIF
	mkdir coal/
	for f in *.gif; do convert "$f" -coalesce coal/"${f%%}_temp.gif"; convert coal/"${f%%}_temp.gif" -resize 50% half/"$f"; rm -r coal; done
	fi
else
echo "Done for now!"
fi
#Last added: echo "DONE!"