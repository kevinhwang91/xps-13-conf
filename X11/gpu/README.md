# gpu-xserver-switch

This script helps you free to configure your external GPU and switch between internal GPU external GPU.

## Features:

* Adaptive configure Xorg Server when external GPU attach after PC startup.
* Command line to switch between internal GPU and external GPU.
* Detach external GPU satfely.
* Support Nvidia Proprietary driver.

## Environment under test:

* Linux Kernal: 4.19 lts
* Linux Distros: Arch Linux & Manjaro
* Desktop Environment: Gnome
* Laptop: XPS 13 9370
* External GPU: Nvidia 1060 3G
* Internal GPU Driver: `modesetting`
* External GPU Driver: `nvidia`

## Requirement

* **Have an external GPU enclosure and set up correctly**.
* Authorized Thunderbolt for external GPU.
* Installled external GPU driver

## Installation

1. **Inspect and backup your current GPU xserver configuration `/etc/X11/xorg.conf` because it will be overrided by `gpu-xserver-switch`.**
2. Run `git clone https://github.com/kevinhwang91/gpu-xserver-switch.git`.
3. Run `cd gpu-xserver-switch && sudo RETRY=4 make`.

`Makefile` include `RETRY` environment to solve PC boots so fast that external GPU couldn't initialized successfully through GPU enclosure, see FAQs.

> `/etc/X11/xorg.conf` maybe doesn't exist, xserver using other configuration path such as `/etc/X11/xorg.conf.d`,`/usr/share/X11`.


## Configurations

1. Run `sudo gxs setup` and select your external GPU card.
2. Edit your internal GPU xserver `/etc/X11/xorg.conf.igpu` configuration.


## Use

Make sure Install `gpu-xserver-switch` successfully before using below command line.

**When do reload, Display Manager will kill current xserver, just like logout.**

### Switch to interlnal GPU

Run `sudo gxs i` or `sudo gxs i <<<'y'` without prompt to do reload.

### Switch to external GPU 

Run `sudo gxs e` or `sudo gxs e <<<'y'` without prompt to do reload.

### Detach GPU enclosure

Run `sudo gxs d` or `sudo gxs d <<<'y'` without prompt to do reload.

## Adaptive switching GPU

Adaptive switching GPU: without manual run command  `sudo gxs e` or `sudo gxs i` to swtich GPU after login.

If you want to adaptively switch GPU after PC startup, Please follow below steps:

1. Make sure you can switch both GPUs using `sudo gxs e <<<'y'` and `sudo gxs i <<<'y'`.
2. Enable gpu-xserver-switch service `sudo systemctl enable gpu-xserver-switch.service`.

## FAQs

**Q**: How to know which GPU used?

**A**: Run `glxinfo | grep 'OpenGL renderer'`

---

**Q**: Could not reload when switching GPU.

**A**: Run `journalctl` or `dmesg` to make sure the GPU initialized successfully and inspect xserver log.

---

**Q**: Could not adaptively switch GPU after PC startup.

**A**: Run `journalctl -b` to make sure the GPU initialized successfully and inspect xserver log, try to make install again increasing value of RETRY and wait for a minute to login at display manager interface such as `GDM`.

---

## Related Project

* [egpu-switcher](https://github.com/hertg/egpu-switcher)
* [gswitch](https://github.com/karli-sjoberg/gswitch)

## License

The project is licensed under a BSD-3-clause license. See the [LICENSE](./LICENSE) file.
