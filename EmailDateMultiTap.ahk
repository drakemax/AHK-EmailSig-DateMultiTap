; This is a AHK script that Uses:
;  Ctrl + 1 to show different email signatures based on the number of taps 
; Ctrl + 2 to show today's date in different formats depending on number of time you tap the keys 
; It utilises TapHoldManager class  by evilC - https://github.com/evilC/TapHoldManager

; further down there are hotkeys for  Stream Deck for PC volume control
; further down there is script for hiding icons on Desktop and toggling them on/off
; further down there is script for putting an emoji at beginning and end of Email Subject text, 
; one with Fleur-de-lis icons and another with Maple leaves , the maple leaves then sends an email to specific address,
; based on a bookmarklet selectiong a webpage URL to put in email body. 

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#SingleInstance force

#include C:\Users\%A_UserName%\Documents\AutoHotkey\Lib
#include <TapHoldManager> ; The script will not work without this library!!!

;-----------------------Global  Variables -----------------------------
PauseTime := 6000 ; used for website login pause
; MsgBox, %pausetime%

thm := new TapHoldManager() ; Initialization of the THM (TapHoldManager)

thm.Add("^1", Func("Func1")) ; Assigning a script to a "Ctrl+ 1"  key through a "Callback Function"
thm.Add("^2", Func("Func2")) ; Assigning a script to a "Ctrl+ 1"  key through a "Callback Function"
return

; This is a callback function that is responsible for what"s gonna happen whn the key was tapped/held/tap+hold
Func1(isHold, taps, state){

	; "IF" - a "gatekeeper" condition that only allows to pass the thread when the key wasn"t being held (isHold = 0), was tapped once (taps = 1) and it reacts only to a final press-down of the key (not to a release) (state = 1) 
	if (isHold=0) & (taps=1) & (state){
		Send, cheers,`r	
		sleep 100
		Send, Max {Enter}
		;just showing two different SPACEs here. Nothing fancy.
	}
	if (isHold=0) & (taps=2) & (state){
		; using cut/paste means it all goes in together, not a long time writing strings 
		FileRead, OutputVar, E-fullSignature.txt
		sleep, 500

		Clipboard:=OutputVar
		Send, ^v 
		sleep 100
		Send, {Enter}
	}
	if (isHold=0) & (taps=3) & (state){
		Send, Kind regards,`r 
		sleep 100
		Send, Max Drake{Enter}
		sleep 100
		Send,{Enter}
	}
	if (isHold=0) & (taps=4) & (state){
		Send, Kind regards,`r
		sleep 100
		Send, Max Drake{Enter}
		sleep 100
		Send, 02102335042{Enter}

	}
	if (isHold=0) & (taps=5) & (state){
		Send, Yours sincerely,`r
		sleep 100
		Send, Max Drake{Enter}
		sleep 100
		Send, 02102335042{Enter}
	}
}

Func2(isHold, taps, state){

	; "IF" - a "gatekeeper" condition that only allows to pass the thread when the key wasn"t being held (isHold = 0), was tapped once (taps = 1) and it reacts only to a final press-down of the key (not to a release) (state = 1) 
	if (isHold=0) & (taps=1) & (state){
		FormatTime, YrMonthDay,,yyyMMdd
		Send, %YrMonthDay% ; current date formats yyy-mm-dd-- was sendInput but that didnt work with file rename
		Return

	}
	if (isHold=0) & (taps=2) & (state){
		FormatTime, DayMonthYrDash,,dd-MM-yyy
		Send, %DayMonthYrDash% ; current date formats yyy-mm-dd-- was sendInput but that didnt work with file rename
		Return

	}
	if (isHold=0) & (taps=3) & (state){
		FormatTime, LongDateTime,,dddd, MMMM d, yyyy
		SendInput, %LongDateTime% `n ; current date formats long format

		Return
	}
	if (isHold=0) & (taps=4) & (state){
		FormatTime, CurrentDateTime,,yyy-MM-dd h:mm tt
		SendInput, %CurrentDateTime% `n ; current date/time formats yyy-mm-dd & Time in AM/PM
		Return
	}
	if (isHold=0) & (taps=5) & (state){
		SendInput, hello world
	}
}

return
; ---------------Hotkeys for Volume  Added at head --------

;see this forum post on mike mute- This works on  Microsoft Surface Book 16gb as I've 
;found the id of the microphone at "6" 
;https://www.autohotkey.com/boards/viewtopic.php?t=15509

>!4:: ;RAlt+4

	SoundSet, +1, MASTER, mute, 6 ;12 was my mic id number use the code below the dotted line to find your mic id. you need to replace all 12's  <---------IMPORTANT
	SoundGet, master_mute, , mute, 6

	ToolTip, Mike %master_mute% Mute ;use a tool tip at mouse pointer to show what state mic is after toggle
	SetTimer, RemoveToolTip, 1000
return
RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return
>!5::
	SoundSet 1, Microphone, mute ; mute the microphone
	ToolTip, mute the microphone
	SetTimer, RemoveToolTip, 1000
return
>!6::
	SoundSet 100, Microphone, mute ; mute the microphone
	ToolTip, microphone 100 level
	SetTimer, RemoveToolTip, 1000
return
>!7::
	SoundSet -10 
	ToolTip, Sound Down -10
	SetTimer, RemoveToolTip, 1000
return
>!8::
	SoundSet +10
	ToolTip, Sound Up +10
	SetTimer, RemoveToolTip, 1000
return
>!9::
	SoundSet, 100
	ToolTip, Sound set to 100 RAlt0 to mute
	SetTimer, RemoveToolTip, 1000
return
>!0::	

	SoundSet, 1 ; mute the microphone
	ToolTip, Mute speakers RAlt9 to unmute
	SetTimer, RemoveToolTip, 1000
return
; ---------------Hotkeys for Volume End here--------
; ---------------Hotkeys for adding emoji to email subject--------
>!2::	; RightAlt + 2  -Emoji general
	Send, ⚜️
	send,{Ctrl down}{Left 50}️
	send,{Ctrl up}
	send,⚜️
	send, {Tab} Dear
return

>!3::	; RightAlt + 3  -Emoji email me webpage
	Send,🍁️
	send,{Ctrl down}{Left 50}️
	send,{Ctrl up}
	send,🍁️
	send, {Tab} 
	send,{Ctrl down}{Left 10}
	send,{Ctrl up}
	send,{Enter}
	send,{up}
	send, 	Max, Something of interest
	send,{Ctrl down}{Enter}
	send,{Ctrl up}
return

;https://scriptmime.com/scripts/script-page/script/?id=5&name=%2Fhide-desktop-icons-with-a-hotkey-press
>!1:: ; RightAlt + 1 toggle hide desktop icons
	If (toggle := !toggle){
		Control, Hide,, SysListView321, ahk_class WorkerW
		Control, Hide,, SysListView321, ahk_class Progman
	}

	else{
		Control, Show,, SysListView321, ahk_class WorkerW
		Control, Show,, SysListView321, ahk_class Progman
	}

return

;-------------------------------------------------
;------------LOGIN MY WEBSITES-----------------

>!p:: ; cr8ive.cf

	IfWinExist, ahk_exe firefox.exe
	{ WinActivate

		Run, % "firefox.exe https://cr8ive.cf/wp-login.php?redirect_to=http%3A%2F%2Fcr8ive.cf%2Fwp-admin%2F%3Floggedout%3Dtrue&reauth=1 -new-tab"
		sleep, %PauseTime%
		send, {Click 1474 721 }
		;send, ^A
		send, {BackSpace 10}
		send, {del 9}

		sendraw, admin
		;send, {Enter}
		send, {Tab}
		send, {BackSpace 10}
		; send, {Click 1474 813 }
		sendraw, drake1234
		; send, {Enter}
		send, {Click 1659 885 }
	}
return

>!o:: ;pir2.tk

	IfWinExist, ahk_exe firefox.exe
	{ WinActivate

		Run, % "firefox.exe https://pir2.tk/wp-login.php -new-tab"
		sleep, %PauseTime%
		send, {Click 1474 721 }
		;send, ^A
		send, {BackSpace 10}
		send, {del 9}

		sendraw, admin
		;send, {Enter}
		send, {Tab}
		send, {BackSpace 10}
		; send, {Click 1474 813 }
		sendraw, drake1234
		; send, {Enter}
		send, {Click 1659 921 }
	}
return

>!i:: ;apriori.ml ;https://apriori.ml/wp-login.php?redirect_to=https%3A%2F%2Fapriori.ml%2Fwp-admin%2F&reauth=1

	IfWinExist, ahk_exe firefox.exe
	{ WinActivate

		Run, % "firefox.exe https://apriori.ml/wp-login.php?redirect_to=https%3A%2F%2Fapriori.ml%2Fwp-admin%2F&reauth=1 -new-tab"
		sleep, %PauseTime%
		send, {Click 1474 721 }
		;send, ^A
		send, {BackSpace 10}
		send, {del 9}

		sendraw, admin
		;send, {Enter}
		send, {Tab}
		send, {BackSpace 10}
		; send, {Click 1474 813 }
		sendraw, drake1234
		; send, {Enter}
		send, {Click 1659 921 }
	}
return

>!u:: ;max drake ;https://maxdrake.tk/wp-login.php?

	IfWinExist, ahk_exe firefox.exe
	{ WinActivate

		Run, % "firefox.exe https://maxdrake.tk/wp-login.php -new-tab"
		sleep, %PauseTime%
		send, {Click 1474 721 }
		;send, ^A
		send, {BackSpace 10}
		send, {del 9}

		sendraw, admin
		;send, {Enter}
		send, {Tab}
		send, {BackSpace 10}
		; send, {Click 1474 813 }
		sendraw, drake1234
		; send, {Enter}
		send, {Click 1659 927 }
	}
return

>!y:: ;AdGustum

	IfWinExist, ahk_exe firefox.exe
	{ WinActivate

		Run, % "firefox.exe https://www.blogger.com/blogger.g?blogID=6110379966611541423#allposts -new-tab"
		sleep, %PauseTime%
		send, {Click 1474 721 }
		;send, ^A
		send, {BackSpace 10}
		send, {del 9}

		sendraw, admin
		;send, {Enter}
		send, {Tab}
		send, {BackSpace 10}
		; send, {Click 1474 813 }
		sendraw, drake1234
		; send, {Enter}
		send, {Click 1659 927 }
	}
return

; This can also be done by 
; #v:: ; Text–only paste from ClipBoard
; 	Clip0 = %ClipBoardAll%
; 	ClipBoard = %ClipBoard% ; Convert to text
; 	Send ^v ; For best compatibility: SendPlay
; 	Sleep 50 ; Don't change clipboard while it is pasted! 

; 	(Sleep > 0)
; 	ClipBoard = %Clip0% ; Restore original ClipBoard
; 	VarSetCapacity(Clip0, 0) ; Free memory
; Return

; Yellow dot at cursor-https://www.youtube.com/watch?v=hdoA8pH3yy4&list=PLa9z1lCs1x9JEEFS9vArkbg0p8D8hbArr&index=11
; Ripple Effect-https://www.youtube.com/watch?v=c4zr56knBDI&list=PLa9z1lCs1x9JEEFS9vArkbg0p8D8hbArr&index=12
; Onscreen display of keystrokes-https://www.youtube.com/watch?v=c4zr56knBDI&list=PLa9z1lCs1x9JEEFS9vArkbg0p8D8hbArr&index=12

;----------Yellow dot at cursor-----------------
SetWinDelay, -1
CoordMode, Mouse, Screen

^#w::
	CircleSize := 90
	Gui, -Caption +Hwndhwnd +AlwaysOnTop +ToolWindow +E0x20 ;+E0x20 click thru
	;Gui, Color, cFFFF00 ;hex code yellow
	Gui, Color, cFFA500 ;hex code orange
	Gui, Show, x0 y-%CircleSize% w%CircleSize% h%CircleSize% NA, ahk_id %hwnd%
	WinSet, Transparent, 60, ahk_id %hwnd%
	WinSet, Region, 0-0 w%CircleSize% h%CircleSize% E, ahk_id %hwnd%
	SetTimer, Circle, 10
return

Circle:
	MouseGetPos, X, Y
	X -= CircleSize / 2 - 3
	Y -= CircleSize / 2 - 2
	WinMove, ahk_id %hwnd%, , %X%, %Y%
	WinSet, AlwaysOnTop, On, ahk_id %hwnd%
return

^#e::Reload ; Reload script with Ctrl+Win+e

^Esc::ExitApp