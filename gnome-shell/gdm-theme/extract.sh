#! /usr/bin/env sh

workdir="./theme"

mkdir -p $workdir

echo '<?xml version="1.0" encoding="UTF-8"?>' >$workdir/gnome-shell-theme.gresource.xml
echo '<gresources><gresource prefix="/org/gnome/shell/theme">' >>$workdir/gnome-shell-theme.gresource.xml

for r in $(gresource list /usr/share/gnome-shell/gnome-shell-theme.gresource); do
    gfile="${r#\/org\/gnome\/shell\/theme/}"
    mkdir -p "$(dirname $workdir/$gfile)"
    gresource extract /usr/share/gnome-shell/gnome-shell-theme.gresource $r >$workdir/$gfile
    echo "<file>$gfile</file>" >>$workdir/gnome-shell-theme.gresource.xml
done

echo '</gresource></gresources>' >>$workdir/gnome-shell-theme.gresource.xml
