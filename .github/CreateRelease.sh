#!/bin/bash
if command -v git >/dev/null 2>&1; then
    ReName="$(date +%Y.%m) Release"
    cd $(git rev-parse --show-toplevel) && mkdir Build
    rmURL="$(git config --get remote.origin.url)"
    #Ver=$(curl --silent https://api.github.com/repos/"$(echo ${rmURL:19} | sed 's/.git//')"/releases/latest | grep 'tag_name' | tr -d '"' | tr -d ' ' | tr -d ',' | sed -e 's/tag_name:v//')
    Ver=$(curl -L --silent https://github.com/"$(echo ${rmURL:19} | sed 's/.git//')"/releases/latest | grep -m 1 '/download/' | sed -e 's/.*\/download\/v\(.*\)\/.*/\1/')
    if [[ ${Ver##*.} == 9 ]]; then
        if [[ ${Ver:2:1} == 9 ]]; then
            NewVer="$((${Ver:0:1}+1)).0.0"
        else
            NewVer="${Ver:0:1}.$((${Ver:2:1}+1)).0"
        fi
    else
        NewVer="${Ver%.*}.$((${Ver##*.}+1))"
    fi

    if [[ ! -z ${GITHUB_ACTIONS+x} ]]; then
        echo "::set-env name=NewVer::$NewVer"
        echo "::set-env name=ReName::$ReName"
    fi

    zip -qr Build/EFI.v.${NewVer}.zip OpenCore Clover LICENSE -x \*/\.\*

    echo "# v${NewVer}" >> ReleaseNotes.md
    echo "- **This is the full EFI**" >> ReleaseNotes.md
    git log -"$(git rev-list --count $(git rev-list --tags | head -n 1)..HEAD)" --format="- %H %s" | grep -v 'Makefile\|gitignore\|Repo\|Docs\|Merge\|yml' | sed  '/^$/d' >> ReleaseNotes.md

    #FIX_ME Bypass GitHub API Rate Limit by directly curl the entire web page

    # Get OpenCore version and release url
    ##OcReInfo="$(curl --silent https://api.github.com/repos/williambj1/OpenCore-Factory/releases | head -n 45)"
    ##OcTag="$(echo "$OcReInfo" | grep 'tag_name' | tr -d '"' | tr -d ' ' | tr -d ',' | sed -e 's/tag_name://')"
    ##OcVer="$(echo "$OcReInfo" | grep '"name": "OpenCore' | head -n 1 | tr -d ' ' | tr -d '"' | tr -d ',' | sed -e 's/name:OpenCore-//' | sed -e 's/-DEBUG.zip//')"
    ##OcReURL="$(echo "$OcReInfo" | grep 'html_url' | grep 'tag' | head -n 1 | tr -d ' ' | tr -d '"' | tr -d ',' | sed -e 's/html_url://')"
    # Get Clover version and release url
    ##CloverReInfo="$(curl --silent https://api.github.com/repos/CloverHackyColor/CloverBootloader/releases/latest)"
    ##CloverTag="$(echo "$CloverReInfo" | grep 'tag_name' | tr -d '"' | tr -d ' ' | tr -d ',' | sed -e 's/tag_name://')"
    ##CloverVer="v2.${CloverTag:0:1}k-${CloverTag}"
    ##CloverReURL="$(echo "$CloverReInfo" | grep 'html_url' | grep 'tag' | head -n 1 | tr -d ' ' | tr -d '"' | tr -d ',' | sed -e 's/html_url://')"

    ##echo "- Updated OpenCore to $OcVer [($OcTag)]($OcReURL)" >> ReleaseNotes.md
    ##echo "- Updated Clover to [$CloverVer]($CloverReURL)" >> ReleaseNotes.md
    echo "### Updated" >> ReleaseNotes.md
    echo "- OpenCore" >> ReleaseNotes.md
    echo "- Clover"  >> ReleaseNotes.md
    echo "- All kexts" >> ReleaseNotes.md
    echo "To the latest version at the moment of this release" >> ReleaseNotes.md
    echo "> AsusSMC is not working in Catalina, please manually delete it in Clover, limitations have already been set in OpenCore" >> ReleaseNotes.md
    cat ReleaseNotes.md
else
    echo "Git is required but not installed. Skipping Create Release."
fi
