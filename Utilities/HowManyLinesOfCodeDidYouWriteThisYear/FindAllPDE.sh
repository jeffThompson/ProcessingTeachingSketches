#!/bin/bash
# Jeff Thompson | www.jeffreythompson.org

# enter the year you're looking for and the path to your Processing sketchbook
lookFor="pde"																					  	# file extension to look (period optional)
yearCreated="2011"																				# year to look at
pathToCheck="/Users/jeffthompson/Documents/Processing"		# where to look
# pathToCheck=$HOME																				# alternatively, look everywhere (may be VERY slow)
dateRange="01-Jan-$yearCreated"														# set date to the first of the year we're looking for

echo ""
echo "HOW MANY LINES OF CODE DID YOU WRITE THIS YEAR?"
echo -e "Path:\t\t$pathToCheck"
echo -e "Extension:\t$lookFor"
echo -e "Year:\t\t$yearCreated"

# note: we don't need the . in front of the extension since * will match all preceeding characters
find $pathToCheck -type f -name \*$lookFor -newermt "$dateRange" -and -not -newermt "$dateRange +12 month"> "$lookFor_files.txt"
fileCount=$(wc -l < "$lookFor_files.txt")

lineCount=0
charCount=0
while read line; do
	lines=$(wc -l < $line)				# count lines in the file
	let "lineCount += lines"	
	chars=$(wc -c < $line)				# count characters
	let "charCount += chars"
done < "$lookFor_files.txt"

rm "$lookFor_files.txt"					# be nice and delete the working file (optional)
echo -e "Result:\t   ${fileCount} files, ${lineCount} lines, ${charCount} characters"
exit