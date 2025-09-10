;Author : Schwarzion <https://github.com/Schwarzion>
;This script is only for educational purpose

;Coordinates to click on chat
;You can use GetMousePos() function to get your own coordinates
chatPosY := <CHAT_Y_POST>
chatPosX := <CHAT_X_POST>
;Coordinates to accept invite
invitePosX := <INVITE_ACCEPT_X_POST>
invitePosY := <INVITE_ACCEPT_Y_POST>

;Current Dofus version
version := "<CURRENT_VERSION> - Release"

; Replace with your actual Dofus window titles
; Leader needs to be first in dofusWindows list and not present in inviteGroup list
dofusWindows := ["player1 - <CLASSE> - version", "player2 - <CLASSE> - version", "player3 - <CLASSE> - version"]
inviteGroup := ["player2", "player3"]

; Hotkeys to switch to each window and click
F1::SwitchAndClick(1)
F2::SwitchAndClick(2)
F3::SwitchAndClick(3)

;Keybinds attributions (list of key names : https://www.autohotkey.com/docs/v1/KeyList.htm)
;<KEY>::<FUNCTION>
XButton2::ClickAllDofusWindowsAtMouse()
F9::HavreSac()
F10::GroupInvite()
F11::ControlClickAllDofusWindowsAtMouse()
Delete::GetMousePos()

;Open Havre-sac (useful for tp)
HavreSac() {
    global dofusWindows
    ; MouseGetPos, mouseX, mouseY
    Loop, % dofusWindows.Length() {
        title := dofusWindows[A_Index]
        if WinExist(title) {
            WinActivate
            SendInput h
            Sleep, 50
        }
    }
}

;Close all clients
quit() {
    global dofusWindows
    Loop, % dofusWindows.Length() {
        title := dofusWindows[A_Index]
        if WinExist(title) {
            WinActivate
            Send !{f4}
            Sleep, 50
        }
    }
}

;Switch to the specified Dofus window and click at the specified coordinates
SwitchAndClick(index) {
    global dofusWindows, clickX, clickY
    title := dofusWindows[index]
    if WinExist(title) {
        WinActivate
    }
}

;Click all Dofus windows at the current mouse position
ClickAllDofusWindowsAtMouse() {
    global dofusWindows
    MouseGetPos, mouseX, mouseY
    Loop, % dofusWindows.Length() {
        title := dofusWindows[A_Index]
        if WinExist(title) {
            WinActivate
            Click, %mouseX%, %mouseY%
            Sleep, 20
        }
    }
    title := dofusWindows[1]
    if WinExist(title) {
        WinActivate
    }
}

;Control Click on all characters, useful for map auto pilot
ControlClickAllDofusWindowsAtMouse() {
    global dofusWindows
    MouseGetPos, mouseX, mouseY
    Loop, % dofusWindows.Length() {
        title := dofusWindows[A_Index]
        if WinExist(title) {
            WinActivate
            Send, {Ctrl down}
            Click, %mouseX%, %mouseY%
            Send, {Ctrl up}
            Sleep, 80
        }
    }
    title := dofusWindows[1]
    if WinExist(title) {
        WinActivate
    }
}

;Need rework as some invite are not sent as commands
GroupInvite() {
    global dofusWindows
    global inviteGroup
    global chatPosX, chatPosY
    if WinExist(dofusWindows[1]) {
        WinActivate
        Loop, % inviteGroup.Length() {
            char := inviteGroup[A_Index]
            Click, %chatPosX%, %chatPosY%
            SendInput, ^a
            Send `/`invite %char%
            SendInput {Enter}
            Sleep, 100
        }
    }
    GroupAccept()
}

;Need rework as some invite are not sent as commands
GroupAccept() {
    global dofusWindows
    global inviteGroup
    global invitePosX, invitePosY
    Loop, % dofusWindows.Length() {
        title := dofusWindows[A_Index]
        if WinExist(title) and A_Index != 1 {
            WinActivate
            Click, %invitePosX%, %invitePosY%
            Sleep, 80
        }
    }
    title := dofusWindows[1]
    if WinExist(title) {
        WinActivate
    }
}

;As we tp, we need to follow the leader again
;So leaving the group, then reinvite all members and adding a click on accept is the fastest way to achieve this
;Need to find a way to leave group as the command does not exist
; RegroupToFollow() {
;     global dofusWindows
;     if WinExist(dofusWindows[1]) {
;         WinActivate
;         Click, %chatPosX%, %chatPosY%
;         Send, ^a
;         Send `/`invite %char%
;         SendInput {Enter}
;     }
;     GroupInvite()
; }

;Get position of cursor (for debug only)
GetMousePos() {
    MouseGetPos, mouseX, mouseY
    MsgBox, The cursor is at X%mouseX% Y%mouseY%
}
