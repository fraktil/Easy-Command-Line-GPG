#!/bin/bash

# Easy Command Line GPG
# ez-cli-gpg.sh
# Version 2.2 (released 2010.03.15)

# Contact Information
# -------------------
# Author:  Steve Phillips / fraktil
# Email:   fraktil@gmail.com
# Twitter: twitter.com/fraktil

if [ $# -lt 1 ]; then
    echo Usage: `basename $0` [Recipient]
    exit 0
fi

# Recipient often a (partial) name or (partial) email address
# E.g., fraktil
recip=$1

# Where to store encrypted and unencrypted email
# Use absolute path; ~ not interpreted as /home/username
# Directory must exist
maildir=$HOME
#maildir=$HOME/email

# Date format (used to name file)
# year, month, day, hour, minute
# E.g., 201003150607
date=`date +%Y%m%d%H%M`

# File to include email
# E.g., fraktil-to-201003150607.txt
filename=$recip-to-$date.txt

# Text editor used to compose email
editor='nano'
#editor=$EDITOR # use system default stored in $EDITOR
#editor='emacsclient -t'
#editor='emacs -nw'
#editor='vi'

# Drop into text editor to write the email
$editor $maildir/$filename

# Encrypt email (will be prompted for GPG passphrase)
# -a = armor ; -r = recipient ; -s = sign ; -e = encrypt
gpg -ar $recip -se $maildir/$filename # sign and encrypt
#gpg -ar $recip -s $maildir/$filename  # sign only
#gpg -ar $recip -e $maildir/$filename  # encrypt only

# Display GPG-encrypted email (e.g., to be pasted into mail client)
echo
cat $maildir/$filename.asc

# Optional - Delete unencrypted email
#rm $maildir/$filename

# Optional - Delete encrypted email
#rm $maildir/$filename.asc

# Note: to securely store email messages, consider creating a
# TrueCrypt volume and mounting it to $maildir
