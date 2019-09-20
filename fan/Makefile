PREFIX := /usr
SYSTEMD := /etc/systemd/system

all: install

install: dell-fan-control.service
	install -D dell-fan-control $(PREFIX)/bin/dell-fan-control
	install -Dm 644 i8kmon.conf /etc/i8kutils/i8kmon.conf
	install -Dm 644 $< $(SYSTEMD)/$<
	install -Dm 644 $(<:.service=-sleep.service) $(SYSTEMD)/$(<:.service=-sleep.service)
	systemctl daemon-reload
	systemctl start $<
	systemctl enable $<
	systemctl enable $(<:.service=-sleep.service)

clean: dell-fan-control.service
	systemctl stop $<
	systemctl disable $<
	systemctl disable $(<:.service=-sleep.service)
	$(RM) $(SYSTEMD)/$<
	$(RM) $(SYSTEMD)/$(<:.service=-sleep.service)
	systemctl daemon-reload
	$(RM) /etc/i8kutils/i8kmon.conf
	$(RM) $(PREFIX)/bin/dell-fan-control
