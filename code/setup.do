clear
set more off, permanently
set matsize 1000
*set scheme s1mono
set scheme s1color
set seed 123456

********************************************************************************
* SET PATHS
********************************************************************************
* FIND WHERE THE REPO IS STORED ON THIS COMPUTER
local reponame passthrough-wealth
global repodir = substr("`c(pwd)'",1,length("`c(pwd)'") - ///
		(strpos(reverse("`c(pwd)'"),reverse("`reponame'"))) + 1)
di "$repodir"

*USE THAT TO LOAD THE DROPBOX PATH (NON-SYNCED, COMPUTER SPECIFIC FILE)
do "$repodir/code/paths.do"

*SET WHERE OUTPUT IS STORED (COULD USE DB)
global outdir "$repodir/output"

*SOME FILES USE A TEMPORARY FOLDER
capture mkdir "$repodir/temp"

cd "$repodir/temp"
    local list : dir . files *
	foreach f of local list {
		erase "`f'"
}
global tempdir "$repodir/temp"

cd "$tempdir"
exit 

********************************************************************************
* INSTALL USER-WRITTEN PACKAGES MANUALLY AS NEEDED
********************************************************************************
ssc install tabout
ssc install estout
ssc install spmap
ssc install shp2dta
ssc install mif2dta
ssc install geonear
net install grc1leg
ssc install egenmore
local github "https://raw.githubusercontent.com"
net install gtools, from(`github'/mcaceresb/stata-gtools/master/build/)
* adoupdate, update
* ado uninstall gtools
