#!/usr/bin/env bash

function gen_random_robot_image(){
    roseus "(progn (require \"robot-silhouette.l\") (gen-random-image \"$1\") (exit 0))";
}

function monochronize(){
##    convert -monochrome $1 $2;
    convert -threshold 50000  $1 $2;
}

gen_random_robot_image /tmp/buf.jpg;
## convert -transparent white /tmp/buf.jpg /tmp/buf.png;
monochronize /tmp/buf.jpg /tmp/buf2.jpg;
## convert -segment 1x1 /tmp/buf.jpg /tmp/buf2.jpg;