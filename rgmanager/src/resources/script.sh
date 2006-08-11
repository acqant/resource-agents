#!/bin/bash

#
#  Copyright Red Hat Inc., 2004
#
#  This program is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation; either version 2, or (at your option) any
#  later version.
#
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; see the file COPYING.  If not, write to the
#  Free Software Foundation, Inc.,  675 Mass Ave, Cambridge, 
#  MA 02139, USA.
#

#
# Script to handle a non-OCF script (e.g. a normal init-script)
#

LC_ALL=C
LANG=C
PATH=/bin:/sbin:/usr/bin:/usr/sbin
export LC_ALL LANG PATH

. $(dirname $0)/ocf-shellfuncs

meta_data()
{
    cat <<EOT
<?xml version="1.0"?>
<resource-agent version="rgmanager 2.0" name="script">
    <version>1.0</version>

    <longdesc lang="en">
        The script resource allows a standard LSB-compliant init script
	to be used to start a clustered service.
    </longdesc>
    <shortdesc lang="en">
        LSB-compliant init script as a clustered resource.
    </shortdesc>

    <parameters>
        <parameter name="name" unique="1" primary="1">
            <longdesc lang="en">
                Name
            </longdesc>
            <shortdesc lang="en">
                Name
            </shortdesc>
	    <content type="string"/>
        </parameter>

        <parameter name="file" unique="1" required="1">
            <longdesc lang="en">
                Path to script
            </longdesc>
            <shortdesc lang="en">
                Path to script
            </shortdesc>
	    <content type="string"/>
        </parameter>

        <parameter name="service_name" inherit="service%name">
            <longdesc lang="en">
	    	Inherit the service name, in case the
		script wants to know this information.
            </longdesc>
            <shortdesc lang="en">
	    	Inherit the service name.
            </shortdesc>
	    <content type="string"/>
        </parameter>
    </parameters>

    <actions>
        <action name="start" timeout="0"/>
        <action name="stop" timeout="0"/>

	<!-- This is just a wrapper for LSB init scripts, so monitor
	     and status can't have a timeout, nor do they do any extra
	     work regardless of the depth -->
        <action name="status" interval="30s" timeout="0"/>
        <action name="monitor" interval="30s" timeout="0"/>

        <action name="meta-data" timeout="0"/>
        <action name="verify-all" timeout="0"/>
    </actions>
</resource-agent>
EOT
}

case $1 in
	meta-data)
		meta_data
		exit 0
		;;
	*)
		;;
esac

[ -n "${OCF_RESKEY_file}" ] || exit $OCF_ERR_ARGS      # Invalid Argument
[ -f "${OCF_RESKEY_file}" ] || exit $OCF_ERR_INSTALLED # Program not installed
[ -x "${OCF_RESKEY_file}" ] || exit $OCF_ERR_GENERIC   # Generic error

# Don't need to catch return codes; this one will work.
ocf_log info "Executing ${OCF_RESKEY_file} $1"
exec /bin/sh ${OCF_RESKEY_file} $1