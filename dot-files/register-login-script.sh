#!/bin/bash

cp ~/.emacs.d/dot-files/login-script.sh ~
cp ~/.emacs.d/dot-files/com.user.loginscript.plist ~/Library/LaunchAgents/

launchctl load ~/Library/LaunchAgents/com.user.loginscript.plist
launchctl start com.user.loginscript
