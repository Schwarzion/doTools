; Author : Schwarzion <https://github.com/Schwarzion>
; This script is only for educational purpose

#NoEnv 
#SingleInstance Force
#KeyHistory 0 ;only to not show inputs for debuging

IniRead, nbAcc, settings.ini, Main

SendMode Input 
SetWorkingDir %A_ScriptDir%

; Just add the name of you characters in the order you want (note that the order will actually be used for window switching)
; all
playerList := ["player1","player2","player3"]

; specific assignments depending on if you want to have 2 sets of players
questsPlayerList := ["player1","player2"]

; Raccourcis personnage
; <KEY>:: Winactivate <WINDOW NAME>
F1:: Winactivate player1
F2:: Winactivate player2
f3:: Winactivate player3


;Define a delay to not look like a bot
getRandomSleep(min, max) {
    Random, sleepTime , min, max
    return sleepTime
}

;Move only one character
movePlayer(character) {
    MouseGetPos, xpos, ypos
    ControlClick, x%xpos% y%ypos%, %character%
    Sleep, 330
}

;Move specific players (useful for quests)
moveQuestsPlayer(questsPlayerList) {
     MouseGetPos, xpos, ypos
    for key, val in questsPlayerList
    {
        ControlClick, x%xpos% y%ypos%, %val%
        Sleep, 800
    }
}

;Fast checking for players window (making sure they are at the same point)
checkPlayersWindow(playerList) {
    MouseGetPos, xpos, ypos
    for key, val in playerList
    {
        Winactivate %val%
        Sleep, 200
    }
}

;Retrieve User Inputs
retrieveInputs()
{
    return "string"
}

;Move all character
movePlayers(playerList) {
    MouseGetPos, xpos, ypos
    for key, val in playerList
    {
        ControlClick, x%xpos% y%ypos%, %val%
        Sleep, getRandomSleep(300, 600)
    }
}

;Move all character with fast sleep
movePlayersNoSleep(playerList) {
    MouseGetPos, xpos, ypos
    for key, val in playerList
    {
        ControlClick, x%xpos% y%ypos%, %val%
        Sleep, 20
    }
}

;Open Haver-sac (useful for tp)
tp(playerList) {
    for key, val in playerList
    {
        WinActivate %val%
        SendInput h
        Sleep, 50
    }
}

;Close all players client
quit(playerList) {
    for key, val in playerList
    {
        WinActivate %val%
        Send !{f4}
        Sleep, 50
    }
}

;Make all players sit
sitAll(playerList) {
    for key, val in playerList
    {
        Winactivate %val%
        MouseClick, left, 50, 1420
        SendRaw, /sit
        SendInput {enter}
        Sleep, getRandomSleep(800, 1600)
    }
}

;Open a messagebox containing cursor coordinates
testCursorPos() {
    MouseGetPos, xpos, ypos 
    MsgBox, The cursor is at X%xpos% Y%ypos%.
}

;Move all character using arrow keys
movePlayersWithArrow(playerList, x, y) {
    for key, val in playerList
    {
        ControlClick, x%x% y%y%, %val%
        Sleep, getRandomSleep(300, 600)
    }
}

;Tool functions
F7::testCursorPos()
F8::sitAll(playerList)
F9::tp(playerList)
F10::quit(playerList)
RControl::checkPlayersWindow(playerList) ;Right Control

;Moving functions
; ²::moveQuestsPlayer(questsPlayerList) ;tild button (²)
XButton2::movePlayers(playerList) ;Mouse left button up
XButton1::movePlayersNoSleep(playerList) ;Mouse right button up



;Arrow keys
Down::movePlayersWithArrow(playerList, 1196, 1258)
Up::movePlayersWithArrow(playerList, 1256, 33)
Left::movePlayersWithArrow(playerList, 411, 686)
Right::movePlayersWithArrow(playerList, 2221, 766)
