PREFIX := $(HOME)/.local
SYSTEMD_USER = $(HOME)/.config/systemd/user

all:install

install: pause-audio-on-lock.service
	install -D pause-audio-on-lock $(PREFIX)/bin/pause-audio-on-lock
	install -Dm 644 $< $(SYSTEMD_USER)/$<
	sed -E -i "s|ExecStart=.*|ExecStart=$(PREFIX)/bin/pause-audio-on-lock|g" $(SYSTEMD_USER)/$<
	systemctl --user daemon-reload
	systemctl --user start $<
	systemctl --user enable $<

clean: pause-audio-on-lock.service
	systemctl --user stop $<
	systemctl --user disable $<
	$(RM) $(SYSTEMD_USER)/$<
	systemctl --user daemon-reload
	$(RM) $(PREFIX)/bin/pause-audio-on-lock
