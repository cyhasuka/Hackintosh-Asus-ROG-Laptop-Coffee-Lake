# 华硕 ROG Coffee Lake 笔记本通用黑苹果 EFI 分享

[![Release](https://img.shields.io/github/release/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake.svg)](https://github.com/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake/releases)
[![Progress](https://img.shields.io/badge/Progress-完善中-ff69b4.svg)](https://github.com/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake/issues/1)
[![License](https://img.shields.io/github/license/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake)](/LICENSE)

## README

- [English](/README.md)
- **简体中文**

## 简介

本 EFI 适用于 8/9 代酷睿的华硕 ROG 笔记本

支持 10.13.6(17G2112) ~ 10.15.x

本人只有 ROG 冰刃 3 GX531GS, 但是经过大量测试, 该 EFI 同样适用于 ROG 的其它笔记本, [已知成功机型，兼容性问题及解决方案见 #2](https://github.com/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake/issues/2)

## 如何构建这个 EFI

> 仓库的 Release 中会在每个月的 15 日自动发布, 如果急需仓库内的最新 EFI, 可以执行如下操作

在终端中输入：

```bash
git clone --depth=1 https://github.com/williambj1/Hackintosh-Asus-ROG-Laptop-Coffee-Lake.git
cd Hackintosh-Asus-ROG-Laptop-Coffee-Lake

# 使用 GitHub API
./Makefile.sh
# 绕过 GitHub API
./Makefile.sh --NO_GH_API
```

> 确保网络通畅

## 完美的功能

- [x] 原生硬件 NVRAM
- [x] 核显 UHD630
- [x] 内屏亮度调节
- [x] 重启亮度记忆
- [x] 原生刷新率调节
- [x] USB 3.1 Gen 2
- [x] 摄像头
- [x] 电池电量显示
- [x] 睡眠及唤醒
- [x] 传感器
- [x] HIDPI
- [x] CPU 变频
- [x] 触控板
- [x] Fn 键
- [x] 4 级键盘背光灯控制
- [x] ROG AURA 灯效控制
- [x] Siri
- [x] USB Sidecar
- [x] ...

> 1. 以上功能只在 GX531 中测试通过
> 1. 原生刷新率调节是否可用取决于屏幕的型号及批次
> 1. HIDPI 需要使用额外工具开启
> 1. 键盘背光灯控制，AURA 灯效控制和 Fn 键 仅有 macOS 10.14 Mojave 可用，Catalina 暂不支持
> 1. SMBIOS 使用 `MacBook Pro 16,1` 和 `MacBook Pro 15,3` 时，传感器信息少于 `MacBook Pro 15,1`
> 1. 非 GX531 需要单独定制 USBPorts.kext 来修复键盘和睡眠

## 有点问题的设备

- 声卡 ALC294
  > 内置麦克风有噪音，部分机型内置扬声器无声
- Intel Wireless-AC 9560 CNVi 无线网卡
  > 使用 `itlwm`，处于 alpha 阶段，非常不稳定 (仓库未包含该 Kext)
  
## 不可用的功能

- 独显 NVIDIA Geforce GTX 1070 with Max-Q Design **及与之相连的 HDMI**
- USB Type-C 视频输出 (连在独显上)
- 触摸板数字键盘

## 特别感谢

- [Ben Raz](https://github.com/ben9923) 耐心帮助我测试触摸板和 CNL 的 GPIO
- [Daliansky](https://github.com/daliansky) 的安装 Dmg，config 文件和博客上的精彩文章
- [Headkaze](https://github.com/headkaze) 的实用工具 Hackintool
- [hieplpvip](https://github.com/hieplpvip) 开发了对 USB HID 键盘的 Fn 键控制和 AURA 灯效控制
- [Startpenghubingzhou](https://github.com/penghubingzhou) 对 I2C 的指导
- [Steve Zheng](https://github.com/stevezhengshiqi) 在 OpenCore 问题，声卡和 ACPI 中对我的指导
- 宪武 在 ACPI 方面的指导

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

## 图库

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
