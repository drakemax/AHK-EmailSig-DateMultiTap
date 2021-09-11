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

#InstallMouseHook ; 

#SingleInstance force

#include C:\Users\%A_UserName%\Documents\AutoHotkey\Lib
#include <TapHoldManager> ; The script will not work without this library!!!

;-----------------------GLOBAL VARIABLES -----------------------------
;-----------------------Recent Files Macro Global  Variables --------------
PauseTime := 6000 ; used for website login pause
; MsgBox, %pausetime%
;-----------------------Recent Files Macro Global  Variables -----------------------------
; FileList is for Recent Files Macro storing file 
FileList= C:\Users\drake\Downloads\AHK-Working\FileRecent\RecentFiles.csv
; FileListOut is temp file for Recent Files Macro storing file , copies data less selected linme to delelte
;and then deletes original file and names this original file (filelist)
FileListOut= C:\Users\drake\Downloads\AHK-Working\FileRecent\RecentFilesOut.csv
; StartFolderX is for Recent Files Macro starting folder for looking for files/foilders to select
StartFolderX=C:\Users\drake\Downloads
; IniFile is for Recent Files Macro countx for file in list number (used to delete a line)
IniFile=C:\Users\drake\Downloads\AHK-Working\FileRecent\RecentFilesCount.ini
FileListOut= C:\Users\drake\Downloads\AHK-Working\FileRecent\RecentFilesOut.csv
;-----------------------Global  Variables -----------------------------
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
		FormatTime, LongDateTime,,dddd d MMMM yyyy
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

>!4:: ;RAlt+4- master mute

	SoundSet, +1, MASTER, mute, 6 ;12 was my mic id number use the code below the dotted line to find your mic id. you need to replace all 12's  <---------IMPORTANT
	SoundGet, master_mute, , mute, 6

	ToolTip, Mike %master_mute% Mute ;use a tool tip at mouse pointer to show what state mic is after toggle
	SetTimer, RemoveToolTip, 1000
return
RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return
>!5:: ; mute the microphone
	SoundSet 1, Microphone, mute ; mute the microphone
	ToolTip, mute the microphone
	SetTimer, RemoveToolTip, 1000
return
>!6:: ;microphone FULL ON
	SoundSet 100, Microphone, mute 
	ToolTip, microphone 100 level
	SetTimer, RemoveToolTip, 1000
return
>!7:: ;sound down
	SoundSet -10 
	ToolTip, Sound Down -10
	SetTimer, RemoveToolTip, 1000
return
>!8:: ;sound up
	SoundSet +10
	ToolTip, Sound Up +10
	SetTimer, RemoveToolTip, 1000
return
>!9:: ;sound full
	SoundSet, 100
	ToolTip, Sound set to 100 RAlt0 to mute
	SetTimer, RemoveToolTip, 1000
return
>!0::	;mute speakers 
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

;----------Yellow dot at cursor-----------------
; Yellow dot at cursor-https://www.youtube.com/watch?v=hdoA8pH3yy4&list=PLa9z1lCs1x9JEEFS9vArkbg0p8D8hbArr&index=11
; Ripple Effect-https://www.youtube.com/watch?v=c4zr56knBDI&list=PLa9z1lCs1x9JEEFS9vArkbg0p8D8hbArr&index=12
; Onscreen display of keystrokes-https://www.youtube.com/watch?v=c4zr56knBDI&list=PLa9z1lCs1x9JEEFS9vArkbg0p8D8hbArr&index=12

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

; Ctrl------goes to beginning of line or end of line in text doc------
;Ctrl---------Goes to top or bottom in Explorer directory----------
^LButton::SendInput, {Home} ;Home Ctrl+ Left Mouse Button Home 
^!j::SendInput, {Home}
^RButton::SendInput, {End} ;End Ctrl+ Right Mouse Button Home 
^!l::SendInput, {End}

; Alt------goes down one line or up one line in text doc------
!LButton::SendInput, {Up} ;Home shift+ Left Mouse Button Home 
^!i::SendInput, {Up}

!RButton::SendInput, {Down} ;End shift+ Right Mouse Button Home 
^!m::SendInput, {Down} ;End shift+ Right Mouse Button Home

; ------Shift + L/R Button - backspace (start at end of line, or Delete, start at beginning of line------
+LButton:: ; Capslock, followed by L button on mouse   Backspace Key
	{
		ButtonsHoldRepeat("Shift","LButton", "Backspace") ;     ButtonsHoldRepeat("CapsLock","LButton", "Backspace")
		Exit
	}
return
^!u:: ; Capslock, followed by L button on mouse   Backspace Key
	{
		ButtonsHoldRepeat("RShift","u", "Backspace") ;     ButtonsHoldRepeat("CapsLock","LButton", "Backspace")
		Exit
	}
return
+RButton:: ; Capslock, followed by L button on mouse   Delete Key
	{
		ButtonsHoldRepeat("Shift","RButton", "Delete") ; ButtonsHoldRepeat("CapsLock","RButton", "Backspace")
		Exit
	}
return
^!o:: ; CRShift, followed by o    Delete Key
	{
		ButtonsHoldRepeat("RShift","u", "Delete") ; ButtonsHoldRepeat("CapsLock","RButton", "Backspace")
		Exit
	}
return

ButtonsHoldRepeat(TriggerKey1, TriggerKey2, OutputKey)
{
	GetKeyState, %TriggerKey1%,P ;Retrieve the physical state (i.e. whether the user is physically holding it down). 
	GetKeyState, %TriggerKey2%,P

	; while GetKeyState, (TriggerKey1,"p") or GetKeyState(TriggerKey2,"p")    
	;   { }
	while GetKeyState(TriggerKey1,"p") and GetKeyState(TriggerKey2,"p") 
	{
		SendInput, {%OutputKey%}
		sleep, 200 ; delay before repeated button presses
		While GetKeyState(TriggerKey1,"p") and GetKeyState(TriggerKey2,"p")
		{
			SendInput, {%OutputKey%}
			sleep, 30 ; how fast the output key pie_repeatLastFunction()			
		}
	}

	KeyWait,Capslock,U
	sleep 100
	SetCapsLockState , Off

return
} 

+#f:: ; Copies a file to "U:\_____TEMP_SHARE" dir
	StartingFolder= C:\Users\drake\Downloads\AHK-Working
	dest := "U:\_____TEMP_SHARE"

	; pop up to select a file
	FileSelectFile, SelectedFile, 3, %StartingFolder%, TITLE: Open FILE

	FileCopy, %SelectedFile%, %dest%, Overwrite

	IfNotExist %dest%
	msgbox dest didn't exist! (ErrorLevel is %ErrorLevel%)
return

+#d:: ; copy folder to "U:\_____TEMP_SHARE" dir and names the same

	StartingFolder= C:\Users\drake\Downloads\AHK-Working
	; FileSelectFolder, SelectedFolder, %StartingFolder%, 3, TITLE: Open FOLDER
	; msgbox %StartingFolder% ----- %SelectedFolder%
	TargetFolder := "U:\_____TEMP_SHARE"

	;FileCopyDir, %SelectedFolder%, %dest%, Overwrite

	FileSelectFolder, SourceFolder,%StartingFolder%, 3, Select the folder to copy
	if SourceFolder =
		return

	;   MsgBox, 4, , A copy of the folder "%SourceFolder%" will be put into "%TargetFolder%". Continue?
	;   IfMsgBox, No
	; return
	SplitPath, SourceFolder, SourceFolderName1 ; Extract only the folder name from its full path.
	DT= %A_YYYY%-%A_MM%-%A_DD%
	SourceFolderName=%SourceFolderName1%-%DT%-Main
	FileCopyDir, %SourceFolder%, %TargetFolder%\%SourceFolderName%
	if ErrorLevel
		MsgBox The folder could not be copied, perhaps because a folder of that name already exists in "%TargetFolder%".
return

;_________----------__________---------RECENT FILES _______---------_________

^#a:: ;select file
	FileSelectFile, SelectedFile, 3, C:\Users\drake\Downloads, SELECT FILE TO SAVE ;, Text Documents (*.txt, *.ahk)

	DT= %A_YYYY%-%A_MM%-%A_DD%

	splitpath, SelectedFile, FileN
	splitpath, SelectedFile, ,,OutExtension

	IniRead, Countx, %IniFile%,Counter, counter1

	Countx+=1
	; boxes for input file desc and project code
	InputBox, Desc , %SelectedFolder% , DESCRIPTION
	InputBox, Proj , %SelectedFolder% , PROJECT
	; concatenate file line number, date, and other file info
	FileToSave =%Countx%, %DT%,,%OutExtension%,%Proj%,%Desc%,%SelectedFile%,%FileN%,`n
	;This appends the information to main file.
	FileAppend, %FileToSave%, %FileList%
	;updates couter for file /folder number in list
	IniWrite, %Countx%, %IniFile%, Counter, counter1
Return
;}
^#q:: ;select folder
	;Refer to above ^#a for comments 
	FileSelectFolder, SelectedFolder,%StartFolderX%,,SELECT FOLDER TO SAVE 

	InputBox, Desc , %SelectedFolder%, DESCRIPTION
	InputBox, Proj , %SelectedFolder%, PROJECT 

	IniRead, Countx, %IniFile%,Counter, counter1
	Countx+=1
	DT= %A_YYYY%-%A_MM%-%A_DD%

	splitpath, SelectedFolder, FolderN
	DummyExt=Dir

	FileToSave =%Countx%, %DT%,,%DummyExt%,%Proj%,%Desc%,%SelectedFolder%,%FolderN%,`n
	FileAppend, %FileToSave%, %FileList%
	IniWrite, %Countx%, %IniFile%, Counter, counter1
Return

^#d::
	; delete a line (create temp file, writeline to new less one selected, deletes old file and creates new 
	;file of same name from temp file)
	InputBox, LineNumDel , Which LINE NUMBER CODE to Delete ?
	{

		Loop, Read, %FileList%
		{
			LineNumber = %A_Index%
			Loop, Parse, A_LoopReadLine, CSV
			{
				var%A_Index% := A_LoopField

			}

			x=%A_LoopReadLine%`n

			IfNotEqual, var1 , %LineNumDel%
			{
				FileAppend, %x%, %FileListOut%
			}

		}
	}
	FileDelete, %FileList%
	FileCopy, %FileListOut%, %FileList% , Overwrite
	FileDelete, %FileListOut%
return
^#s:: ; This edits file (if you want to change project code or desc)
	Run C:\Program Files (x86)\Notepad++\notepad++.exe "%FileList%"
return

^#e::Reload ; Reload script with Ctrl+Win+e

^Esc::ExitApp

/*
MultiPaste.ahk by Jack Dunning June 20, 2019   Updated July 5, 2019

Many Windows users will find this AutoHotkey script handy for copying data-sets and breaking
them up into its component parts for pasting into form fields. You can use the app to copy and 
parse portions of Web tables, groups of cells in a spreadsheet, single-line street addresses, 
and many other pieces of data then insert those items into individual fields in another window. 

After selecting a section of a page (left-click, hold, and drag), activate the Hotkey combination 
CTRL+ALT+F to open a MsgBox window displaying the parsed information in its components. 
The MsgBox stays always-on-top while you move to your input screen.

Next, select the target input field and press the Hotkey combination CTR:+ALT+WIN+W to activate
the Input command. You have five seconds to press one of the number keys (0-9). AutoHotkey inserts 
the text next to the pressed number key in the MsgBox into the selected field.

This script parses text in the Windows Clipboard based upon the tab `t character, new lines, commas in 
single-line addresses, plus US and UK postal codes, for placement in the variable array listed in the 
MsgBox. This script works in a wide variety of situations although Web formatting may limit its usefulness.

The script uses Regular Expressions in a number of places to recognize dates and postal codes. Script discussion
begins with the blog:

https://jacksautohotkeyblog.wordpress.com/brute-force-data-set-copy-and-paste-autohotkey-clipboard-technique/

July 5, 2019 Replaced tab removal loop with a single-line RegExReplace() function and corrected date
identifying conditional.

July 27, 2019 Changed date RegEx to include dates separated by dashes and dots, as well as, forward slashes.

September 9, 2019 Added conditional Hotkeys Alt+1 throught Alt+0 for pasting items. Only active with
MsgBox titled "Multi Paste" open.

Per suggestion, Clipboard contents transferred to variable (ClipboardCopy) before manipulation.

October 1, 2020 Hotkeys changed to $ plus digit (0-9). This makes single key Hotkeys. The $ prevents 
internal re-firing of digits with SendInput command.
*/

+!F:: ; SHFT+ALT+F to select text 
	OldClipboard := ClipboardAll
	Clipboard = ;clears the Clipboard
	SendInput, ^c
	ClipWait 0 ; pause for Clipboard data
	If ErrorLevel
	{
		MsgBox, Error message for non-selection
		}

	ClipboardCopy := Clipboard
	; Replace all new paragraph marks with tabs for parsing
	ClipboardCopy := StrReplace(ClipboardCopy, "`r`n" , "`t")
	; Just in case the data-set includes a stray `r or`n 
	ClipboardCopy := StrReplace(ClipboardCopy, "`r" , "`t") 
	ClipboardCopy := StrReplace(ClipboardCopy, "`n" , "`t") 

	; For single-line addresses replace commas
	ClipboardCopy := StrReplace(ClipboardCopy, "`, " , "`t")

	;  To parse US zip codes
	ClipboardCopy := RegExReplace(ClipboardCopy, "\s(\d\d\d\d\d)", "`t$1")

	;  To parse UK postal codes
	ClipboardCopy := RegExReplace(ClipboardCopy, "\s([A-Za-z][A-Za-z]?\d\w?)", "`t$1")

	; Designed to removes excess tabs, replaced this loop with the one-line RegEx
	; which follows. Loop doesn't work if a space appears between tabs the 
	; RegEx does.

	;  Loop 
	;  {
	;   ClipboardCopy := StrReplace(ClipboardCopy, "`t`t" , "`t")
	;    If ! InStr(Clipboard, "`t`t")
	;      Break
	;  }

	ClipboardCopy := RegExReplace(ClipboardCopy, "`t\s*`t" , "`t")

	; Sparse data-set
	Transaction := StrSplit(ClipboardCopy , "`t", , MaxParts := -1) ; [v1.1.28} 

	; Display MsgBox always-on-top (4096) for pasting into target fields 
	; Word-wrapped using line continuation techniques
	MsgBox, 4096,Multi Paste , % "[1] " . Transaction[1] . "`r" 
	. "[2] " . Transaction[2] . "`r" 
	. "[3] " . Transaction[3] . "`r" 
	. "[4] " . Transaction[4] . "`r" 
	. "[5] " . Transaction[5] . "`r" 
	. "[6] " . Transaction[6] . "`r" 
	. "[7] " . Transaction[7] . "`r" 
	. "[8] " . Transaction[8] . "`r" 
	. "[9] " . Transaction[9] . "`r" 
	. "[0] " . Transaction[10]
	Clipboard := OldClipboard
Return

+!d:: ;shft+Alt+d  enact after the selection then choose number on its own for paste
	Input, SingleKey, L2 T5, ,1,2,3,4,5,6,7,8,9,0
	; Special action for date fields
	If SingleKey = 0
		SingleKey := 10

	; Check for date format to parse
	If (Transaction[SingleKey] ~= "\d\d?[/\-.]\d\d?[/\-.]\d\d(\d\d)?")
	{
		If InStr(Transaction[SingleKey],"/")
			date := StrSplit(Transaction[SingleKey],"/")
		If InStr(Transaction[SingleKey],"-")
			date := StrSplit(Transaction[SingleKey],"-")
		If InStr(Transaction[SingleKey],".")
			date := StrSplit(Transaction[SingleKey],".")

		SendInput, % date[1]
		SendInput, /
		SendInput, % date[2]
		SendInput, /
		SendInput, % date[3]

		; msgbox, % date[1] date[2] date[3]
		; For date field tabbing use the following:
		; SendInput, % date[1] . "`t" . date[2] . "`t" . date[3]
	}
	Else If SingleKey != ""
		SendInput, % Transaction[SingleKey]
Return

#If WinExist("Multi Paste")
	$1::SendInput, % Transaction[1]
$2::SendInput, % Transaction[2]
$3::SendInput, % Transaction[3]
$4::SendInput, % Transaction[4]
$5::SendInput, % Transaction[5]
$6::SendInput, % Transaction[6]
$7::SendInput, % Transaction[7]
$8::SendInput, % Transaction[8]
$9::SendInput, % Transaction[9]
$0::SendInput, % Transaction[10]
#If

