#!/bin/zsh

# Created by Bat.bat(williambj1) on 6 Oct, 2019
#
# To have less binaries in the repo and get rid of kext updates because I'm EXTEREMELY lazy
#
# References:
# https://github.com/daliansky/XiaoMi-Pro-Hackintosh/blob/master/install.sh by stevezhengshiqi
# https://github.com/black-dragon74/OSX-Debug/blob/master/gen_debug.sh by black-dragon74

# WorkSpaceDir
WSDir="$( cd "$(dirname "$0")" ; pwd -P )/.Make"

# Vars
GH_API=True
CLEAN_UP=True

# Args
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --NO_GH_API)
        GH_API=False
        shift # past argument
        ;;
        --NO_CLEAN_UP)
        CLEAN_UP=False
        shift # past argument
        ;;
        *)
        shift
        ;;
    esac
done

# Colors
if [[ -z ${GITHUB_ACTIONS+x} ]]; then
    black=`tput setaf 0`
    red=`tput setaf 1`
    green=`tput setaf 2`
    yellow=`tput setaf 3`
    blue=`tput setaf 4`
    magenta=`tput setaf 5`
    cyan=`tput setaf 6`
    white=`tput setaf 7`
    reset=`tput sgr0`
    bold=`tput bold`
fi

# Exit on Network Issue
function networkErr() {
    echo "${yellow}[${reset}${red}${bold} ERROR ${reset}${yellow}]${reset}: Failed to download resources from ${1}, please check your connection!"
    Cleanup
    exit 1
}

# Clean Up
function Cleanup() {
    if [[ $NO_CLEAN_UP == False ]]; then
        rm -rf $WSDir
        rm -rf ../Shared/ACPI/*.aml
    fi
}

# Workaround for Release Binaries that don't include "RELEASE" in their file names (head or grep)
function H_or_G() {
    if [[ "$1" == "VoodooI2C" ]]; then
        HG="head -n 1"
    elif [[ "$1" == "CloverBootloader" ]]; then
        HG="grep CloverISO"
    elif [[ "$1" == "IntelBluetoothFirmware" ]]; then
        HG="grep -m 1 IntelBluetooth"
    else
        HG="grep -m 1 RELEASE"
    fi
}

# Download GitHub Release
function DGR() {
    H_or_G $2

    if [[ ! -z ${3+x} ]]; then
        if [[ "$3" == "PreRelease" ]]; then
            tag=""
        elif [[ "$3" == "NULL" ]]; then
            tag="/latest"
        else
            if [[ ! -z ${GITHUB_ACTIONS+x} || $GH_API == False ]]; then
                tag="/tag/2.0.9"
            else
                #only release_id is supported
                tag="/$3"
            fi
        fi
    else
        tag="/latest"
    fi

    if [[ ! -z ${GITHUB_ACTIONS+x} || $GH_API == False ]]; then
        local rawURL="https://github.com/$1/$2/releases$tag"
        local URL="https://github.com$(local one=${"$(curl -L --silent "${rawURL}" | grep '/download/' | eval $HG )"#*href=\"} && local two=${one%\"\ rel*} && echo $two)"
    else
        local rawURL="https://api.github.com/repos/$1/$2/releases$tag"
        local URL="$(curl --silent "${rawURL}" | grep 'browser_download_url' | eval $HG | tr -d '"' | tr -d ' ' | sed -e 's/browser_download_url://')"
    fi

    if [[ -z $URL || $URL == "https://github.com" ]]; then
        networkErr $2
    fi

    echo "${green}[${reset}${blue}${bold} Downloading $(echo ${URL##*\/}) ${reset}${green}]${reset}"
    echo "${cyan}"
    cd ./$4
    curl -# -L -O "${URL}" || networkErr $2
    cd - >/dev/null 2>&1
    echo "${reset}"
}

# Download Bitbucket Release
function DBR() {
    local rawURL="https://api.bitbucket.org/2.0/repositories/$1/$2/downloads/"
    local URL="$(curl --silent "${rawURL}" | json_pp | grep 'href' | head -n 1 | tr -d '"' | tr -d ' ' | sed -e 's/href://')"
    echo "${green}[${reset}${blue}${bold} Downloading $(echo ${URL##*\/}) ${reset}${green}]${reset}"
    echo "${cyan}"
    curl -# -L -O "${URL}" || networkErr $2
    echo "${reset}"
}

# Download Pre-Built Binaries
function DPB() {
    local URL="https://raw.githubusercontent.com/$1/$2/master/$3"
    echo "${green}[${reset}${blue}${bold} Downloading $(echo ${3##*\/}) ${reset}${green}]${reset}"
    echo "${cyan}"
    cd ./$4
    curl -# -L -O "${URL}" || networkErr ${3##*\/}
    cd - >/dev/null 2>&1
    echo "${reset}"
}

# Exclude Trash
function CTrash() {
    # Files
    rm -rf *.app >/dev/null 2>&1
    rm -rf *.aml >/dev/null 2>&1
    rm -rf *.dSYM >/dev/null 2>&1
    rm -rf *.dsl >/dev/null 2>&1
    rm -rf *.sh >/dev/null 2>&1
    rm -rf *.plist >/dev/null 2>&1
    rm -rf *.txt >/dev/null 2>&1
    rm -rf *.zip >/dev/null 2>&1
    rm -rf "AsusSMCDaemon" >/dev/null 2>&1

    # Folders
    rm -rf "Docs" >/dev/null 2>&1
    rm -rf "dSYM" >/dev/null 2>&1
    rm -rf "Utilities" >/dev/null 2>&1
    rm -rf "Debug" >/dev/null 2>&1
    rm -rf "__MACOSX" >/dev/null 2>&1

    # Kexts
    rm -rf VoodooI2CAtmelMXT.kext >/dev/null 2>&1
    rm -rf VoodooI2CELAN.kext >/dev/null 2>&1
    rm -rf VoodooI2CFTE.kext >/dev/null 2>&1
    rm -rf VoodooI2CSynaptics.kext >/dev/null 2>&1
    rm -rf VoodooI2CUPDDEngine.kext >/dev/null 2>&1
    rm -rf NullEthernetInjector.kext >/dev/null 2>&1
}

# Extract files for Clover
function ExtractClover() {
    #From CloverISO
    tar --lzma -xvf CloverISO*.tar.lzma >/dev/null 2>&1
    hdiutil mount Clover-v2.*.iso >/dev/null 2>&1
    ImageMountDir="$(dirname /Volumes/Clover-v2.*/EFI/CLOVER)/CLOVER"
    cp -R "$ImageMountDir"/CLOVERX64.efi "../Clover"
    cp -R "$ImageMountDir"/tools/*.efi "../Clover/Tools"

    for CLOVERdotEFIdrv in ApfsDriverLoader AptioMemoryFix EmuVariableUefi; do
        cp -R "$ImageMountDir"/drivers/off/${CLOVERdotEFIdrv}.efi "../Clover/Drivers/UEFI"
    done

    hdiutil unmount "$(dirname /Volumes/Clover-v2.*/EFI)" >/dev/null 2>&1

    #From AppleSupportPkg 2.0.9
    cd CLOVER_LASPKG && unzip *.zip >/dev/null 2>&1; cd - >/dev/null 2>&1

    for CLOVERdotEFIdrvASPKG in AppleGenericInput AppleUiSupport; do
        cp -R CLOVER_LASPKG/Drivers/${CLOVERdotEFIdrvASPKG}.efi "../Clover/Drivers/UEFI"
    done
}

# Extract files from OpenCore
function ExtractOC() {
    cp -R EFI/BOOT/BOOTx64.efi "../OpenCore/Boot"
    cp -R EFI/OC/OpenCore.efi "../OpenCore/OC"
    cp -R EFI/OC/Drivers/FwRuntimeServices.efi "../OpenCore/OC/Drivers"
    cp -R EFI/OC/Tools/VerifyMsrE2.efi ../OpenCore/OC/Tools
    cd OC_ASPKG && unzip *.zip >/dev/null 2>&1; cd - >/dev/null 2>&1
    cp -R OC_ASPKG/Drivers/ApfsDriverLoader.efi "../OpenCore/OC/Drivers"
}

# Unpack
function Unpack() {
    echo "${green}[${reset}${yellow}${bold} Unpacking ${reset}${green}]${reset}"
    echo ""
    unzip -qq "*.zip" >/dev/null 2>&1
}

# Compile dsl to aml
function iasl2aml() {
    chmod +x iasl*
    echo "${green}[${reset}${magenta}${bold} Compiling ACPI Files ${reset}${green}]${reset}"
    echo ""
    find "../Shared/ACPI/" -type f -name "*.dsl" | xargs -I{} ./iasl* -vs -va {} >/dev/null 2>&1
}

# Install
function Install() {
    # Kexts
    for Kextdir in "../Clover/Kexts/Other" "../OpenCore/OC/Kexts"; do
        find "../" -maxdepth 3 -type d -name "*.kext" | xargs -I{} cp -R {} "$Kextdir" >/dev/null 2>&1
    done

    # Drivers
    cp -R Drivers/*.efi "../Clover/Drivers/UEFI"
    for Driverdir in "../Clover/Drivers/UEFI" "../OpenCore/OC/Drivers"; do
        cp -R ../Shared/UEFI/*.efi "$Driverdir"
    done

    # ACPI
    for ACPIdir in "../Clover/ACPI/Patched" "../OpenCore/OC/ACPI"; do
        cp -R ../Shared/ACPI/*.aml "$ACPIdir"
    done
}

# Patch
function Patch() {
    # Patches for VoodooI2C
    /usr/libexec/PlistBuddy -c "Delete :IOKitPersonalities:VoodooI2CPCIController:IONameMatch" VoodooI2C.kext/Contents/Info.plist
    /usr/libexec/PlistBuddy -c "Add :IOKitPersonalities:VoodooI2CPCIController:IONameMatch array" VoodooI2C.kext/Contents/Info.plist
    /usr/libexec/PlistBuddy -c "Add :IOKitPersonalities:VoodooI2CPCIController:IONameMatch:0 string pci8086,a369" VoodooI2C.kext/Contents/Info.plist
}

# Check Local Repo Version
#function CRV() {

#}

# Self-Update
#function Update() {

#}

# Enjoy
function Enjoy() {
    echo "${red}[${reset}${blue}${bold} Done! Enjoy! ${reset}${red}]${reset}"
    echo ""
}

function DL() {
    ACDT="Acidanthera"

    # Download Kexts
    DGR $ACDT Lilu
    DGR $ACDT VirtualSMC
    #DGR $ACDT AppleALC
    DGR $ACDT CPUFriend
    DGR $ACDT WhateverGreen
    DGR $ACDT NVMeFix
    DGR $ACDT AppleSupportPkg NULL OC_ASPKG
    DGR $ACDT AppleSupportPkg 19214108 CLOVER_LASPKG
    DGR al3xtjames NoTouchID
    #DGR hieplpvip AsusSMC # (Not Ready)
    DGR alexandred VoodooI2C
    DGR zxystd IntelBluetoothFirmware
    DBR Rehabman os-x-null-ethernet

    # Clover
    DGR CloverHackyColor CloverBootloader

    # OpenCore
    DGR williambj1 OpenCore-Factory PreRelease

    # Tools
    DPB $ACDT MaciASL Dist/iasl-stable

    # HFSPlus.efi
    DPB STLVNUB CloverGrower Files/HFSPlus/x64/HFSPlus.efi "../Shared/UEFI"
    DPB $ACDT VirtualSMC EfiDriver/VirtualSmc.efi "Drivers"
}

function Init() {
    if [[ $OSTYPE != darwin* ]]; then
        echo "This script can only run in macOS, aborting"
        exit 1
    fi

    if [[ -d $WSDir ]]; then
        rm -rf $WSDir
    fi
    mkdir $WSDir
    cd $WSDir
    mkdir OC_ASPKG
    mkdir CLOVER_LASPKG
    mkdir Drivers
}

function main() {
    Init
    DL
    Unpack
    CTrash
    Patch

    # Compile DSL -> AML
    iasl2aml

    # Installation
    Install
    ExtractClover
    ExtractOC

    # Clean up
    Cleanup

    # Enjoy
    Enjoy
}
main
