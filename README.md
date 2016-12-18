Bash script (mergePdfs.sh) to extract given page of all pdfs within a folder and merge together in alphabetical order into a single pdf. First pages by default.

You need to redefine the paths in the beginning of script mergePdfs.sh
 * 0) Change paths in mergePdfs.sh
 * 1) Put all the pdfs in folder ```$fullPdf``` (with format below)
 * 2) All first pages (first by default) will be in folder ```$firstPages``` (names won't include spaces for simplicity)
 * 3) All pages (in alphabetical order) are merged in folder ```$mergeall```

Format of pdfs in file $fullPdf: 
* End with .pdf
* Start with an integer to order them
* Can start with %d*_p%d*_ to define which page should be extracted right after 'p'.

Ex: 
01_p1_Moore et al EH11.pdf
15_Fullgrabe et al IJA10b.pdf
16_p2_Stone_etal_JASA10.pdf


Dependencies:
* pdfseparate
* pdfunite
