#!/bin/bash

####################################################################################
#					    asampler
#				 a script for creating Amiga
#				   samples on Raspberry Pi
#
#   this script was designed to work with Amibian for capturing audio samples into a #   simple usb microphone input for the raspberry pi.
#   It will first check your audio level then ask you three questions, what is the #   length of the recording in seconds?, 
#   what would you like to name the sample? And what sample rate?
#
#   Before you run it the first time make sure you put the path to your sample       #   directory below.
#   you must have the program sox intalled before this will work.
#
#   by Demonic Sweaters licensed under GNU GPL License 2017 www.demonicsweaters.com
#
#   update 5/11/17 - fixed sample rates to make sure samples are always in tune
#   cleaned up code a bit
####################################################################################

#this part checks your audio signal
read -p "First lets check your audio level. A level meter will appear for 10 seconds. Check your signal and adjust it accordingly. You can use alsamixer to make mic adjustments. Press ctrl-c to stop before 10 seconds. When you are ready, press [ENTER]: "
arecord -f S16_LE -d 10 -r 48000 -D hw:1,0 -vv /dev/null


#below is the sampler section
echo -n "enter the length of the recording in seconds and press [ENTER]: "
read name
echo -n "enter a name for the sample without extension and without spaces and press [ENTER]: "
read name1
echo -n "enter sample rate (33148.54,16574.27, or 8287.135) for Amiga sample and press [ENTER]: "
read name2
read -p "When you are ready  to record, press [ENTER]: "
arecord -f S16_LE -d $name -r 48000 -D hw:1,0 $name1.wav
sox --norm $name1.wav -b 8 -r $name2 -t 8svx $name1.iff


#
#enter your sample directory path after $name1.iff below. Make sure there is no space after your directory and the second $name1.iff
#
mv $name1.iff /enter/your/sample/directory/here/$name1.iff


