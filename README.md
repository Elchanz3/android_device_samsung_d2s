# OrangeFox Recovery device tree for the Samsung Galaxy Note10+ (Exynos)

The Samsung Galaxy Note10+ (SM-N975F/DS, codenamed **d2s**) is a flagship smartphone announced in August 2019 and released on August 23, 2019.

Maintainer: [Elchanz3](https://github.com/Elchanz3).

## Device specifications

| Feature | Specification |
| ------: | :------------ |
| Chipset | Samsung Exynos 9825 (7 nm EUV) |
| CPU | Octa-core (2x Samsung Mongoose M4 + 2x Cortex-A75 + 4x Cortex-A55) |
| GPU | Mali-G76 MP12 |
| Memory | 12 GB RAM (LPDDR4X) |
| Shipped OS | Android 9.0 (Pie), Samsung One UI |
| Storage | 256 GB / 512 GB (UFS 3.0) |
| SIM | Dual Nano-SIM, hybrid tray |
| MicroSD | Up to 1 TB, shared with the second SIM slot |
| Battery | 4300 mAh, non-removable; up to 45 W wired charging |
| Dimensions | 162.3 x 77.2 x 7.9 mm; 196 g |
| Display | 6.8-inch Dynamic AMOLED, 1440 x 3040, HDR10+ |

## Device picture

<img src="https://fdn2.gsmarena.com/vv/pics/samsung/samsung-galaxy-note10-plus-aura-glow.jpg" width="45%"/>

## How to build

Set up a Linux build environment following the [OrangeFox build guide](https://wiki.orangefox.tech/dev/building). Run the following commands in Bash.

### Sync OrangeFox sources

```bash
git clone https://gitlab.com/OrangeFox/sync.git ~/OrangeFox_sync
cd ~/OrangeFox_sync
./orangefox_sync.sh --branch 12.1 --path ~/fox_12.1
```

The [OrangeFox sync script](https://gitlab.com/OrangeFox/sync) requires an absolute destination path; Bash expands `~/fox_12.1` to one.

### Clone the device tree and kernel

```bash
cd ~/fox_12.1
git clone --branch android-12.1 https://github.com/Elchanz3/android_device_samsung_d2s.git device/samsung/d2s
git clone --branch android-9.0 https://github.com/Elchanz3/android_kernel_samsung_universal9820.git kernel/samsung/universal9820
```

The kernel dependency is also declared in [twrp.dependencies](twrp.dependencies) for builds that register this device tree in a repo manifest. Both the kernel and DTBO are compiled from source.

### Compile recovery

```bash
source build/envsetup.sh
lunch twrp_d2s-eng
mka recoveryimage -j12
```

Adjust the job count to your machine's available memory and CPU cores.

Artifacts are generated in `out/target/product/d2s/`:

- `OrangeFox-R12.0-Unofficial-d2s.img`
- `OrangeFox-R12.0-Unofficial-d2s.zip`
- `OrangeFox-R12.0-Unofficial-d2s.img.tar` for Odin

## Flashing

Use the **d2s Exynos** build with an unlocked bootloader. Back up your data before installation.

### With an installed custom recovery

1. Copy the OrangeFox ZIP installer for d2s to accessible storage.
2. Reboot into OrangeFox or a TWRP-compatible recovery.
3. Flash the ZIP through the recovery's Install menu.
4. The installer normally reboots automatically into OrangeFox.

### With Odin

1. Obtain `OrangeFox-R12.0-Unofficial-d2s.img.tar` from the build output or extract it from the ZIP installer.
2. Reboot the phone into Samsung Download mode and connect it to the PC.
3. Open Odin, select the TAR file in the **AP** slot, and disable **Auto Reboot**.
4. Flash the TAR. After Odin reports success, reboot directly into recovery using the device's hardware keys.
5. Flash the matching OrangeFox ZIP from OrangeFox to complete the installation.

First-time installation on stock One UI may require ROM-specific AVB and encryption preparation, including formatting Data. A data format erases internal storage. An update to an existing working recovery installation does not normally require formatting Data.

General installation reference: [Installing OrangeFox Recovery](https://wiki.orangefox.tech/guides/installing_orangefox).

## Status and known issues

- Boot and navigation were confirmed on the current build. Theme scaling, battery display and the Samsung flashlight path have been corrected.
- Access to unencrypted internal storage works, including saved navigation settings.
- **FBE/FDE decryption is unsupported in the current configuration:** `TW_INCLUDE_CRYPTO` is not enabled and `ro.orangefox.crypto_enabled=0`.
- The startup message **"Successfully decrypted!"** can appear while reapplying theme/navigation settings. It does not establish that encrypted storage was decrypted.
- Backup/restore and compatibility across different stock/custom ROMs have not been fully tested.

## Thanks to

- [corsicanu](https://github.com/corsicanu) for the original d2s recovery tree and Samsung recovery work.
- [TeamWin](https://github.com/TeamWin) for TWRP and the upstream device tree.
- [OrangeFox Recovery Project](https://gitlab.com/OrangeFox) for OrangeFox Recovery.
- [Elchanz3](https://github.com/Elchanz3) for this adaptation and the kernel repository.

## Kernel sources

Repository: [Elchanz3/android_kernel_samsung_universal9820](https://github.com/Elchanz3/android_kernel_samsung_universal9820/tree/android-9.0).

- Branch: `android-9.0`
- Build path: `kernel/samsung/universal9820`
- Defconfig: `exynos9820-d2s_defconfig`
- Outputs: kernel `Image` and d2s DTBO overlays, packaged into the recovery image

## Copyright

```
#
# Copyright (C) 2022 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#  *  Copyright (C) 2025 The OrangeFox Recovery Project
#  *
#  * This program is free software: you can redistribute it and/or modify
#  * it under the terms of the GNU General Public License as published by
#  * the Free Software Foundation, either version 3 of the License, or
#  * (at your option) any later version.
#  *
#  * This program is distributed in the hope that it will be useful,
#  * but WITHOUT ANY WARRANTY; without even the implied warranty of
#  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  * GNU General Public License for more details.
#  *
#  * You should have received a copy of the GNU General Public License
#  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
```
