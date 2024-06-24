Extension { #name : #TextEditor }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/24/2024 09:46'
}
TextEditor class >> SSCActions [
	^ self cmdMapToActionsList: cmdActions
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/24/2024 09:52'
}
TextEditor class >> SSCActions: newActions [
	|actionsByMethod|
	actionsByMethod := Dictionary new.
	self SSCActions do: [:action | actionsByMethod at: action method put: action ].
	newActions do: [:action | actionsByMethod at: action method put: action ].
	
	cmdActions := self actionsListToCmdMap: actionsByMethod values
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/24/2024 09:45'
}
TextEditor class >> defaultSSCActions [
	|cmdMap cmds actions|
	
	actions := super defaultSSCActions asSet.

	cmdMap := Array new: 256 withAll: #noop:.		"use temp in case of a crash"
	cmdMap at: 1 + 1 put: #cursorHome:.				"home key"
	cmdMap at: 4 + 1 put: #cursorEnd:.				"end key"
	cmdMap at: 8 + 1 put: #backspace:.				"ctrl-H or delete key"
	cmdMap at: 11 + 1 put: #cursorPageUp:.			"page up key"
	cmdMap at: 12 + 1 put: #cursorPageDown:.		"page down key"
	cmdMap at: 13 + 1 put: #crWithIndent:.			"cmd-Return"
	cmdMap at: 27 + 1 put: #offerMenuFromEsc:.		"escape key"
	cmdMap at: 28 + 1 put: #cursorLeft:.				"left arrow key"
	cmdMap at: 29 + 1 put: #cursorRight:.				"right arrow key"
	cmdMap at: 30 + 1 put: #cursorUp:.				"up arrow key"
	cmdMap at: 31 + 1 put: #cursorDown:.				"down arrow key"
	cmdMap at: 32 + 1 put: #selectWord:.				"space bar key"
	cmdMap at: 127 + 1 put: #forwardDelete:.		"del key"
			
	'0123456789' 
		do: [:char | cmdMap at: char asciiValue + 1 put: #changeEmphasis:].
	
	cmds := #($a #selectAll: $c #copySelection: $e #exchange: $f #find: $g #findAgain: $j #doAgain: $k #offerFontMenu: $u #align: $v #paste: $w #backWord: $x #cut: $y #swapChars: $z #undo:).
	1 to: cmds size
		by: 2
		do: [:i | cmdMap at: (cmds at: i) asciiValue + 1 put: (cmds at: i + 1)].
	
	^ self cmdMapToActionsList: cmdMap
]
