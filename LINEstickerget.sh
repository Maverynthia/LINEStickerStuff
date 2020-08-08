#!/bin/bash
echo "Number of Sticker file"
read sticknum
echo "http://dl.stickershop.line.naver.jp/products/0/0/1/$sticknum/iphone/stickers@2x.zip"
wget http://dl.stickershop.line.naver.jp/products/0/0/1/$sticknum/iphone/stickers@2x.zip
