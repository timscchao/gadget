#!/bin/bash

#
# Author: Tim Chao <tim dot chao at accelstor dot com>
# Copyright (c) 2018 AccelStor Ltd.  All rights reserved.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT WARRANTY OF ANY KIND, EITHER
# EXPRESS OR IMPLIED, INCLUDING, WITHOUT LIMITATION, ANY IMPLIED WARRANTIES
# OF CONDITION, UNINTERRUPTED USE, MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE, OR NON-INFRINGEMENT.
#

opt=":o:qh"
longopt="opts:,quiet,help"

function usage()
{
	echo "Usage: $0 <[options]> arg ..."
	echo
	echo "Options:"
	echo "  -o --opts=<opsval>      Extra options"
	echo "  -q --quiet				Quiet"
	echo "  -h --help               This help message"
	echo
	exit 1
}

if ! options=$(getopt -a -o $opt -l $longopt -- "$@")
then
	# getopt went wrong, getopt will put out an error message for us
	usage
fi

eval set -- $options

QUIET=false
while [ $# -gt 0 ]
do
	case $1 in
	-o|--opt) OPTS=$2; shift ;;
	-q|--quiet) QUIET=true ;;
	-h|--help) usage ;;
	(--) shift; break ;;
	(-*) echo "Error: unrecognized option $1"; usage ;;
	(*) break ;;
	esac
	shift
done

argid=1
while (true); do
	[ -z "$1" ] && break;
	echo "ARG $argid = $1"
	argid=$((argid + 1))
	shift
done

echo "OPTS = $OPTS"

if ($QUIET); then
	echo "be quiet"
else
	read -p "Are you happy? " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
		echo "Why you are not happy..."
		[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
	fi
	echo "OK, good"
fi
