cat <<EOF >~/.local/share/applications/Brave.desktop
[Desktop Entry]
Version=1.0
Name=Brave Browser
Comment=Browse the web
Exec=/usr/bin/brave-browser %U
Icon=brave-browser
Terminal=false
Type=Application
Categories=Network;WebBrowser;
StartupNotify=true
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/x-web-app-manifest+json;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;
EOF