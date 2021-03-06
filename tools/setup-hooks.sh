#!/bin/bash

function create_hook {
if [[ -z $1 ]]; then
    echo "No hook specified!"
    exit 1
fi
if [[ -f .git/hooks/$1 ]]; then
	echo "hook \"$1\" already present, skipping ..."
else
    echo "setting up hook \"$1\" ..."
    cat > .git/hooks/$1 << EOF
#!/bin/sh
# Copyright 2014 Brent Longborough
# Part of gitinfo2 package Version 2
# Please read gitinfo2.pdf for licencing and other details
# -----------------------------------------------------
# Post-{commit,checkout,merge} hook for the gitinfo2 package
#
# Get the first tag found in the history from the current HEAD
FIRSTTAG=\$(git describe --tags --always --dirty='-dirty' 2>/dev/null)
# Get the first tag in history that looks like a Release
RELTAG=\$(git describe --tags --long --always --dirty='-dirty' --match '[0-9]*.*' 2>/dev/null)
# Hoover up the metadata
git --no-pager log -1 --date=short --decorate=short \
    --pretty=format:"\usepackage[%
        shash={%h},
        lhash={%H},
        authname={%an},
        authemail={%ae},
        authsdate={%ad},
        authidate={%ai},
        authudate={%at},
        commname={%an},
        commemail={%ae},
        commsdate={%ad},
        commidate={%ai},
        commudate={%at},
        refnames={%d},
        firsttagdescribe={\$FIRSTTAG},
        reltag={\$RELTAG}
    ]{gitexinfo}" HEAD > .git/gitHeadInfo.gin
EOF
fi
chmod 755 .git/hooks/$1
}

create_hook post-checkout
create_hook post-commit
create_hook post-merge
