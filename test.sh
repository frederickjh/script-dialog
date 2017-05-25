#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$SCRIPT_DIR"/script-dialog.sh #folder local version
#source /usr/local/bin/script-dialog #installed version

#GUI=false; terminal=false # force relaunching as if launching from GUI without a GUI interface installed, but only do this for testing
relaunchIfNotVisible

APP_NAME="Test Script"
#WINDOW_ICON="$SCRIPT_DIR/icon.png" # if not set, it'll use standard ones
#INTERFACE="text" #force an interface, but only do this for testing

ACTIVITY="SUDO Test"
sudo -k # clear credentials
superuser echo "Testing SUDO permissions"

if [ "$?" == "0" ]; then
    WINDOW_ICON=$(standardIconInfo)
    messagebox "Password accepted"
else
    WINDOW_ICON=$(standardIconError)
    messagebox "Password denied"
fi

ACTIVITY="Pretending to load..."
{
  for ((i = 0 ; i <= 100 ; i+=5)); do
    progressbar_update $i
    sleep 0.2
  done
} | progressbar
progressbar_finish

ACTIVITY="Salutations"
messagebox "Hello World";

WINDOW_ICON=$(standardIconQuestion)
ACTIVITY="Inquiry"
yesno "Are you well?";
ANSWER=$?

WINDOW_ICON=$(standardIconInfo)
ACTIVITY="Response"
if [ $ANSWER -eq 0 ]; then
  messagebox "Good to hear."
else
  messagebox "Sorry to hear that."
fi

WINDOW_ICON=$(standardIconQuestion)
ACTIVITY="Name"
ANSWER=$(inputbox "What's your name?" " ")

WINDOW_ICON=$(standardIconQuestion)

WINDOW_ICON=$(standardIconInfo)
messagebox "Nice to meet you, $ANSWER"

WINDOW_ICON=$(standardIconPassword)
ACTIVITY="Pretend Login"
ANSWER=($(userandpassword Username Password))

WINDOW_ICON=$(standardIconInfo)
messagebox "So, that was: user: ${ANSWER[0]} - password: ${ANSWER[1]}"

WINDOW_ICON=$(standardIconDocument)
ACTIVITY="Test Script"
displayFile $0

WINDOW_ICON=$(standardIconCalendar)
ACTIVITY="Enter Birthday"
ANSWER=$(datepicker)

WINDOW_ICON=$(standardIconInfo)
messagebox "Cool, it's on $ANSWER"

WINDOW_ICON=$(standardIconQuestion)
ACTIVITY="Pretend Configuration"
ANSWER=($( checklist "Select the appropriate network options for this computer" 4  \
        "NET OUT" "Allow connections to other hosts" ON \
        "NET_IN" "Allow connections from other hosts" OFF \
        "LOCAL_MOUNT" "Allow mounting of local drives" OFF \
        "REMOTE_MOUNT" "Allow mounting of remote drives" OFF ))
        
WINDOW_ICON=$(standardIconInfo)
messagebox "So you chose to enable: ${ANSWER[*]}"

WINDOW_ICON=$(standardIconQuestion)
ACTIVITY="Pretend Configuration 2"
ANSWER=$(radiolist "Favorite Primary Color? " 4  \
        "blue" "Blue" OFF \
        "yellow" "Yellow" OFF \
        "green" "Green" ON \
        "red" "Red" OFF )
        
WINDOW_ICON=$(standardIconInfo)
messagebox "So you like $ANSWER, neat."

WINDOW_ICON=$(standardIconFileOpen)
ANSWER=$(filepicker $HOME "open")

WINDOW_ICON=$(standardIconInfo)
messagebox "File selected was $ANSWER"

WINDOW_ICON=$(standardIconFolderOpen)
ANSWER=$(folderpicker $HOME)

WINDOW_ICON=$(standardIconInfo)
messagebox "Folder selected was $ANSWER"

clear
exit 0;
