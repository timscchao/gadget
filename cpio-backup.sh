#!/bin/bash

MAXBKUP=7
SRCDIR="/store"
DSTDIR="/backup/daily"
BACKUPDIR="jenkins bind share"

if [ $(find $DSTDIR -name "*.cpio" | wc -l) -ge $MAXBKUP ]; then
    IFS= read -r -d $'\0' line < <(find $DSTDIR -name "*.cpio" -printf '%T@ %p\0' 2>/dev/null | sort -z -n)
    file="${line#* }"
    rm -f $file
fi

CURRENT=$(date +"%y%m%d%H%M%S")

pushd $SRCDIR
find $BACKUPDIR -depth ! \( -name "*.rpm" -o -name "*.iso" -o -name "*.gpg" -o -name "*.gz" \) | cpio -oc > ${DSTDIR}/${CURRENT}.cpio
popd

# to extra cpio file
# cpio -ivcd < ${file}.cpio
