: '
BEGIN MESSAGE;
FROM: Donnie Hardin;

This file contains some favorite commands and oneliners.

If you see a (DCH!) at the end of a description, you can bet that I make heavy
use of the command (or a variation thereof). 

This is by no means an exhaustive list. Also, it is not very healthy to wield
these commands without deeper understanding concerning what they do. But until
I get the chance to truly master all-of-the-things, these are here to help me 
get things done. I reccommend to you (and to myself!) to read the documentation
for these commands every so often, maybe one command per week if you can 
squeeze it in. (I  hear the sed manpage is a goldmine, there are lots of regex 
learning games on the internet, etc..etc..)

I may not keep this file as updated as I would like, so be sure to keep an eye
on the materials in my personal github repository from time-to-time if you 
can't find something useful in this document.

https://github.com/dchardin

Contribution is encouraged. Contributers can insert their messages too. 
(similar towhat you just read above)

END MESSAGE.
'
#=============================================================================== 
#-------------------------------------------------------------------------------
# OUR FAVORITE BASH/TERMINAL SHORTCUTS
#------------------------------------------------------------------------------- 
#===============================================================================

delete the last word of a line (kill word)  
`ctrl-w

#=============================================================================== 
#-------------------------------------------------------------------------------
# AWKING_SEDDING_CUTTING_ETC
#------------------------------------------------------------------------------- 
#===============================================================================

# sed command replaces a given line with a different one within a file
sed -i -e's/ldap01.util.phx2.redhat.com/ldap.corp.redhat.com/' /usr/bin/linfo

# Another example
sed -i "s|linetobechanged|yournewline|g" /path/to/file/to/be/changed.xml

# Append comma after every word in a line
sed 's/\>/,/g' somefilename

# Append apostrophe at beginning of string in every line
# also append apostrophe and comma at end of string

sed "s/^/'/;s/$/',/" somefilename

#-------------------------------------------------------------------------------
## Append quote at beginning of string in every line
## also append quote and space+backslash at end of string.
# (great fro prepping a column for entry into a bash array!)
#-------------------------------------------------------------------------------

sed "s/^/\"/;s/$/\" \\\ /" other.csv

#-------------------------------------------------------------------------------
## Replace whitespace between columns with a comma
#
## Example:
#
## Before 
#
# 19279734	43.60758	-89.81267
# 19280034	43.60382	-89.78101
# 19280592	43.60504	-89.81458
# 19285100	43.6017		-89.79844
#
## After
#
# 19279734,43.60758,-89.81267
# 19280034,43.60382,-89.78101
# 19280592,43.60504,-89.81458
# 19285100,43.6017,,-89.79844
#-------------------------------------------------------------------------------

sed 's/[\t ]/,/g' thefilesname

#-------------------------------------------------------------------------------
## turn a column of text numbers into a comma separated list on one line.
#-------------------------------------------------------------------------------

perl -pe'chomp, s/$/,/ unless eof' RepIdColumn1 > repIdColumn2.csv

#=============================================================================== 
#-------------------------------------------------------------------------------
# General batch processing
#-------------------------------------------------------------------------------  
#===============================================================================

# use libreoffice cli to bulk convert .ppt's into .pdf's

libreoffice --headless --invisible --convert-to pdf *.ppt

#=============================================================================== 
#-------------------------------------------------------------------------------
# GIT_and_GITHUB (DCH!)
#-------------------------------------------------------------------------------  
#===============================================================================
 
# After installing git on your computer for the first time, you may want to
# set up these personalizations:

git config --global user.name "dchardin"
git config --global user.email "emailaddresshere"

# Creating a new git repo from the terminal

git init

git remote add origin https://github.com/dchardin/nameofmyrepohere.git
git ls-tree --full-tree HEAD

# Made changes to code and ready to commit? Do these:

git add filenamehere

git commit -m 'CommitMessageGoesHere'

git push origin master 

# Would you rather just make sure your local repo mirrors the state of your
# repo that lives on github.com?

git pull origin master

# Shows what branch you are on, and the state.
# Shows some things about recent changes
# it will say 'up-to-date` but that can be misleading; use `git pull` habitually

git status

# ..and logs are always handy.

git log

#-------------------------------------------------------------------------------
# Create a branch
#
# a feature branch is created to work on a specific feature, 
# and stops getting used when the feature is complete; 
#
# a release branch is more persistent and used to store project state 
# for a given release (f23, f22, etc for us)
#
#-------------------------------------------------------------------------------
  
git branch $BRANCH_NAME

# To show remote branches:
  
git branch -r

# Show local branches

git branch

# Show all branches

git branch -a

# Merging branches and sending pull requests

######Coming soon!

#===============================================================================
#-------------------------------------------------------------------------------
# INTERNET_TOOLS
#-------------------------------------------------------------------------------
#===============================================================================

# SCP to pull directory from remote computer via ssh port (DCH!)
                                                                                
scp -r -P 1234 user@ipaddress:/path/to/dir/dir_itself /localpc/dirtoholddir/

# SCP to push a file to a remote computer users home directory (DCH!)
  
scp -P 2222 localfile.ext username@domain:~/
  
# wget from a password protected website and download all the .jpg files
  
wget --user userNameGoesHere --password passwdgoeshere --no-parent -r -l1 -A.jpg \
http://75.whateverurl/whatever/folderwith.jpgs

#-------------------------------------------------------------------------------
# FINDING_THINGS,STORAGE_AND_DISK
#-------------------------------------------------------------------------------

# NOTE: Determining space useage and detecting directory-swelling is part art,
# and part science. Some of these tools are not foolproof and may not account
# for files/directories on mounted external drives.
 
# Find a file

locate filenameHere 

# find term in any document

find . | xargs grep <term>

# find the largest 20 files

find / -printf '%s %p\n'| sort -nr | head -20

# Find largest 50 directories

du -h * | sort -rh | head -5 

## Find largest 50 directories (On a system with older version of Sort that 
## does not support -h

du -h * | perl -e 'sub h{%h=(K=>10,M=>20,G=>30);($n,$u)=shift=~/([0-9.]+)(\D)/; 
return $n*2**$h{$u}}print sort{h($b)<=>h($a)}<>;' | head -50


## See https://www.tecmint.com/find-top-large-directories-and-files-sizes-in-linux/

## locate something and sort the results oldest to newest:

locate something -0 | xargs -0 stat -c'%Y %n' | sort -n




#===============================================================================
#-------------------------------------------------------------------------------
# Archiving, Zipping, Tarring...(DCH!)
#-------------------------------------------------------------------------------
#===============================================================================
  
#-------------------------------------------------------------------------------
# tar/gzip a directory foo into an archive foo.tar.gz 
#-------------------------------------------------------------------------------

tar -czvf foo.tar.gz foo/

#-------------------------------------------------------------------------------
# extract a directory foo from an archive foo.tar.gz
#-------------------------------------------------------------------------------

tar -xzvf foo.tar.gz

#===============================================================================
#-------------------------------------------------------------------------------
# PERMISSIONS-and-FILES
#-------------------------------------------------------------------------------
#===============================================================================

# chowning, chmodding, and all of that. Best just to google as needed.

#-------------------------------------------------------------------------------
# who is waiting on a file?
#-------------------------------------------------------------------------------

egrep -ri 'f:ew|f:w|f:aw'


#-------------------------------------------------------------------------------
# Cron check only one filesystem every 30 minutes for file sizes
#-------------------------------------------------------------------------------

*/30 *  *  *  *  du -xah | sort -h -r > /tmp/`date +%d-%m-%y@%H:%M`.du.out


#
# MISC..
#

## Here is a useful bulk mp3 renaming script that helps when order
## matters. Here is what it does.
## Original     Becomes
## 1.mp3        0001.mp3
## 02.mp3       0002.mp3
## 123.mp3      0123.mp3
## 00000.mp3    00000.mp3
## 1.23.mp3     1.23.mp3

rename 'unless (/0+[0-9]{4}.mp3/) {s/^([0-9]{1,3}\.mp3)$/000$1/g;s/0*([0-9]{4}\..*)/$1/}' *

-----------------

# This one i used to go into each folder (each of which were named 1 ,
# 2, 3, and so on), echo out the name of the folder that it was
# currently in, and cat out the contents of any files inside of the
# folder whose names begin with "Acq" and to only echo out lines that
# have the string 19313 in them

for i in {1..1600}; do cd ~/mnt2/SleepAdult_Archive9/$i; echo $i; cat Acq* | grep 19313; done

