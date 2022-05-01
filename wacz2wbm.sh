#!/bin/sh

# get the collection name from the commandline argument by removing any .wacz
COLLECTION=`echo $1 | sed -r 's/\.wacz$//i'`
# get the wacz name by adding .wacz to the collection name
WACZ=$COLLECTION.wacz

echo ┌ 

# check if the wacz exists in the current dir
if [ -f $WACZ ]; then
	FILE=$WACZ
# check if the wacz exists in crawls/collections
elif [ -f crawls/collections/$COLLECTION/$WACZ ]; then
	FILE=crawls/collections/$COLLECTION/$WACZ
# otherwise quit with exitcode 1
else
	echo │   cannot find $WACZ in current dir or crawls/collections/
	echo └
	exit 1
fi

echo │  found wacz at $FILE

# make a backup if there's already a txt file (will overwrite any previous backup)
if [ -f $COLLECTION.txt ]; then
	cp $COLLECTION.txt $COLLECTION.txt.bak
fi

# extract all urls from pages.jsonl into a txt file in the current dir. usually this is the seeds(?)
unzip -p $FILE pages/pages.jsonl | perl -wnE 'say /"url"\s*:\s*"(.*?)"/i' > temp.txt
# append all urls from extraPages.jsonl into the same txt file. this is the pages crawled including requisites(?)
unzip -p $FILE pages/extraPages.jsonl | perl -wnE 'say /"url"\s*:\s*"(.*?)"/i' >> temp.txt

# remove blank lines, save to the final txt file, remove temp file
grep -v '^\s*$' temp.txt > $COLLECTION.txt
rm temp.txt
COUNT=`wc -l < $COLLECTION.txt`

# if xclip is installed, copy the contents to the clipboard...
if [ -x "$(command -v xclip)" ]; then
	xclip -sel c < $COLLECTION.txt
	echo │  saved $COUNT URLs to $COLLECTION.txt
	echo │  also copied to the clipboard :¬\)
else
	echo │  saved $COUNT URLs to $COLLECTION.txt
	echo │  install xclip for clipboard copy :¬\)
fi

echo └

exit 0