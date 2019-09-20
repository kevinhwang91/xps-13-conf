PREFIX ?= /usr
RETRY ?= 4
PREFIX_X11_CONF = /etc/X11

all: install

install: service
	install -d $(PREFIX)/bin
	install gxs $(PREFIX)/bin/gxs
	install -m 644 xorg.conf.egpu $(PREFIX_X11_CONF)/xorg.conf.egpu
	install -m 644 xorg.conf.igpu $(PREFIX_X11_CONF)/xorg.conf.igpu

service: gpu-xserver-switch.service
	sed -e 's@#PREFIX#@$(PREFIX)@g' -e 's@#RETRY#@$(RETRY)@g' < $< > /etc/systemd/system/$<
	systemctl daemon-reload

.PHONY: clean install
clean: gpu-xserver-switch.service
	$(RM) $(PREFIX_X11_CONF)/xorg.conf.egpu
	$(RM) $(PREFIX_X11_CONF)/xorg.conf.igpu
	$(RM) $(PREFIX_X11_CONF)/xorg.conf
	$(RM) $(PREFIX)/bin/gxs
	systemctl disable $<
	systemctl daemon-reload
	$(RM) /etc/systemd/system/$<
