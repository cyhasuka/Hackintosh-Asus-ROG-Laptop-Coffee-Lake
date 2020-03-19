# Hackintosh-Asus-ROG-Laptop-Coffee-Lake

[![Release](https://img.shields.io/github/release/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake.svg)](https://github.com/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake/releases)
[![Progress](https://img.shields.io/badge/Progress-Developing-ff69b4.svg)](https://github.com/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake/issues/2)
[![License](https://img.shields.io/github/license/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake)](/LICENSE)

## README

- **English**
- [简体中文](/.github/README-zh_CN.md)

## Intro

A nearly perfect EFI for **Asus ROG Coffee Lake Laptops**

Supports from 10.13.6(17G2112) ~ 10.15.x

I only own a ROG Zephyrus S GX531GS, but after testing with a lot of devices, this EFI is also suitable for other ROG laptops, [Succeeded models, Compatibility Issues and Solutions, see #2](https://github.com/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake/issues/2)

## How Can I Build this EFI

> Releases from GitHub CI will be automatically published on the 15th of each month. If the latest EFI from the repo is urgently needed, you can perform the following operations

Run the following commands in Terminal:

```bash
git clone --depth=1 https://github.com/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake.git
cd Hackintosh-Asus-ROG-Laptop-Coffee-Lake

# Using GitHub API
./Makefile.sh
# Bypass GitHub API
./Makefile.sh --NO_GH_API
```

> Make sure you have a reliable Internet Connection

## Perfectly Working Features

- [x] Native Hardware NVRAM
- [x] Intel UHD630
- [x] Screen Brightness Control
- [x] Screen Brightness Memoriztion After Reboot
- [x] Native Screen Refresh Rate Settings
- [x] USB 3.1 Gen 2
- [x] Web Camera
- [x] Battery Percentage
- [x] Sleep & Wake
- [x] Sensors
- [x] HIDPI
- [x] CPU turbo boost
- [x] Trackpad
- [x] Fn Keys
- [x] 4 level keyboard backight control
- [x] ROG AURA effects control
- [x] Siri
- [x] USB Sidecar
- [x] ...

> 1. The above functions are only tested and passed in GX531.
> 1. Whether the native refresh rate adjustment is available depends on the model and production batch of the screen.
> 1. HIDPI needs to be opened with additional tools.
> 1. Keyboard backlight control, AURA lighting effect control and Fn keys are only available on macOS 10.14 Mojave, Catalina is currently not supported.
> 1. SMBIOS selected to `MacBook Pro 16,1` and `MacBook Pro 15,3`, will have less sensor information than `MacBook Pro 15,1`.
> 1. Non-GX531 requires separate custom USBPorts.kext to activate keyboard and fix sleep issues.

## Working Features with Small Issues

- Sound Card ALC294
  > Internal Microphone has weird noise, Internal Speaker is not working on some models.
- Intel Wireless-AC 9560 CNVi wifi card
  > Experimental support at alpha stage, extremely unstable (Kext not included in the Repo)

## Not Working Features

- NVIDIA GTX1070 with MAX-Q Design **and the connected HDMI port**
- Video output from USB Type-C (Connected to NVIDIA Graphics Card)
- Numberpad on trackpad

## Special Thanks

- [Ben Raz](https://github.com/ben9923)'s patience on helping me with debugging the trackpad and CNL-H GPIO
- [Daliansky](https://github.com/daliansky) for his macOS installation Dmg, configs and his awesome blog
- [Headkaze](https://github.com/headkaze) for the awesome Hackintool
- [hieplpvip](https://github.com/hieplpvip) for developing USB HID keyboard Fn key support and AURA support
- [Startpenghubingzhou](https://github.com/penghubingzhou) for teaching me a lot about I2C trackpads
- [Steve Zheng](https://github.com/stevezhengshiqi) for helping me with OpenCore, Sound Card and ACPI
- 宪武 for helping me in ACPI patches

## Credits

- [Acidanthera](https://github.com/acidanthera)
  - [AppleALC](https://github.com/acidanthera/AppleALC)
  - [Lilu](https://github.com/acidanthera/Lilu)
  - [OpenCore](https://github.com/acidanthera/OpenCorePkg)
  - [VirtualSMC](https://github.com/acidanthera/VirtualSMC)
  - [WhateverGreen](https://github.com/acidanthera/WhateverGreen)
- [hieplpvip](https://github.com/hieplpvip)
  - [AsusSMC](https://github.com/hieplpvip/AsusSMC)
  - [macrogaura](https://github.com/hieplpvip/macrogaura)
- [RehabMan](https://github.com/RehabMan)
  - [OS-X-Null-Ethernet](https://github.com/RehabMan/OS-X-Null-Ethernet)
- [VoodooI2C Developer Team](https://voodooi2c.github.io/#Credits%20and%20Acknowledgments/Credits%20and%20Acknowledgments)
  - [VoodooI2C](https://github.com/alexandred/VoodooI2C)
  - [VoodooI2CHID](https://github.com/alexandred/VoodooI2C)

## Gallery

![Info](https://ae01.alicdn.com/kf/U8638fcf1315f447babcdb58458eec1959.jpg)

![FnSound](https://ae01.alicdn.com/kf/Udeb369199cb14cf492d7283287dda7d0q.jpg)
![FnBrightness](https://ae01.alicdn.com/kf/U2684e4e6b2fe4fd1b88d39f3a8e919f8B.jpg)
![Herbination](https://ae01.alicdn.com/kf/U6dc04804d02f4f2f9004ef2f569c1779S.jpg)
![Keyboard Backlight](https://ae01.alicdn.com/kf/Ue37c99db52424ce6af70e1f6166b41d6y.jpg)

![ALC294](https://ae01.alicdn.com/kf/U885dc3dc47e2492eba760bcb6cd744d7D.jpg)

![Display](https://ae01.alicdn.com/kf/Uf40d48c42ff14413b3e32f77b71a5ec98.jpg)

![Sound](https://ae01.alicdn.com/kf/U80597a28cb0e465796ac6e720c942918o.jpg)

![NVMe](https://ae01.alicdn.com/kf/Ucb99f738157e46ddb505a1c8c92fce56w.jpg)

![Battery](https://ae01.alicdn.com/kf/U59877fce8927493a934bfaf253ced982h.jpg)

![Memory](https://ae01.alicdn.com/kf/U18b67f405aa1466f9c10c104f69bc585Y.jpg)

![Graphics](https://ae01.alicdn.com/kf/Uf56c3eb4aa8f4227af1af628779af1fdY.jpg)

![USB](https://ae01.alicdn.com/kf/Ua4f6545ed5a942d09290f6636294c1b0G.jpg)
