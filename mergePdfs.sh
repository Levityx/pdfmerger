#!/bin/sh
#
# Script to extract given page of all pdfs within a folder and merge together in alphabetical order.
#
# Usage: sh mergePdfs.sh
#
# 1) Put all the pdfs in folder $fullPdf (check format below)
# 2) All first pages will be in $firstPages
# 3) All first pages (in alphabetical order) are merge in $mergeall
#
# Format expected: %d*_p%d*_.*.pdf
# 	- The first integer easily defines the order of the documents
# 	- The integer given after _p defines the page to extract. If none, page=1 selected
# 	
#  	Ex: if folder $fullPdf contains the following files 
#		01_p1_Moore et al EH11.pdf
# 		15_Fullgrabe et al IJA10b.pdf
# 		16_p2_Stone_etal_JASA10.pdf
# 	then the first pages of pdfs nuber 01 and 15 are extracted, and second page of number 16
#
# Written by Alban Levity, December 18th 2016
#

mergepdf="/Users/pmaal/mergepdfs/pdfmerger"
fullPdf="$mergepdf/1_fullPdf"
firstPages="$mergepdf/2_firstPages"
mergeall="$mergepdf/3_mergeall"

# 1 -> 2 	 Getting first page of all files
# Complex loop to allow spaces in the names of pdfs
find $fullPdf -name *.pdf -print0 | while read -d $'\0' file; do

	# Find page to extract. First by default
	pageToExtract=`echo $file | sed "s/.*_p\([[:digit:]]*\)_.*/\1/g"`
	if [ -z "$pageToExtract" ]; then
		pageToExtract="1"
	elif [ ! -z "`echo $pageToExtract | grep '_' `" ]; then
		pageToExtract="1" 
	fi
	echo "$file: extracting page=$pageToExtract" | sed "s=$fullPdf/= -- =g"
	
	# Get rid of spaces in name, for simplicity
	nameFirstPage=`echo "$file" | sed "s=$fullPdf=$firstPages=g" | sed "s=\($firstPages.*\) =\1_=g"`

	# Extract given page
	pdfseparate -f "$pageToExtract" -l "$pageToExtract" "$file" "$nameFirstPage"
done

# Getting a list of all first pages we merge
listFirstPages=`find $firstPages -name *.pdf |  tr '\n' ' '`

# 2 -> 3 	Merging
pdfunite $listFirstPages "$mergeall/allFirstpages.pdf"

exit 0

