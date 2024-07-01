Extension { #name : #TextEditor }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/29/2024 22:32'
}
TextEditor class >> SSCActions [
	^ (self cmdMapToActionsList: cmdActions shift: false), (self cmdMapToActionsList: shiftCmdActions shift: true)
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 7/1/2024 21:21'
}
TextEditor class >> SSCActions: someActions [
	|newActions newShiftActions|
	newShiftActions := someActions select: [:action | action shift].
	newActions :=  someActions reject: [:action | action shift].
	
	cmdActions := self actionsListToCmdMap: newActions.
	
	shiftCmdActions := self actionsListToCmdMap: newShiftActions.
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/29/2024 22:29'
}
TextEditor class >> cmdKeyShortcuts [
	| cmdMap cmds |
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
	
	^ cmdMap
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/29/2024 22:32'
}
TextEditor class >> defaultSSCActions [
	^ (self cmdMapToActionsList: self cmdKeyShortcuts shift: false), (self cmdMapToActionsList: self shiftCmdKeyShortcuts shift: true)
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/29/2024 22:30'
}
TextEditor class >> shiftCmdKeyShortcuts [
	| cmdMap cmds |

	"shift-command and control shortcuts"
	cmdMap := Array new: 256 withAll: #noop:.  		"use temp in case of a crash"
	cmdMap at: ( 1 + 1) put: #cursorHome:.			"home key"
	cmdMap at: ( 4 + 1) put: #cursorEnd:.				"end key"
	cmdMap at: ( 8 + 1) put: #forwardDelete:.			"ctrl-H or delete key"
	cmdMap at: (11 + 1) put: #cursorPageUp:.			"page up key"
	cmdMap at: (12 + 1) put: #cursorPageDown:.		"page down key"
	cmdMap at: (13 + 1) put: #crWithIndent:.			"ctrl-Return"
	cmdMap at: (27 + 1) put: #offerMenuFromEsc:.	"escape key"
	cmdMap at: (28 + 1) put: #cursorLeft:.			"left arrow key"
	cmdMap at: (29 + 1) put: #cursorRight:.			"right arrow key"
	cmdMap at: (30 + 1) put: #cursorUp:.				"up arrow key"
	cmdMap at: (31 + 1) put: #cursorDown:.			"down arrow key"
	cmdMap at: (32 + 1) put: #selectWord:.			"space bar key"
	cmdMap at: (45 + 1) put: #changeEmphasis:.		"cmd-sh-minus"
	cmdMap at: (61 + 1) put: #changeEmphasis:.		"cmd-sh-plus"
	cmdMap at: (127 + 1) put: #forwardDelete:.		"del key"

	cmds := #(
		$c	compareToClipboard:
		$h	cursorTopHome:
		$j	doAgainUpToEnd:
		$k	changeStyle:
		$m	selectCurrentTypeIn:
		$s	findAgain:
		$u	changeLfToCr:
		$x	makeLowercase:
		$y	makeUppercase:
		$z	redo: "makeCapitalized:"
	).
	1 to: cmds size by: 2 do: [ :i |
		cmdMap at: ((cmds at: i) asciiValue + 1) put: (cmds at: i + 1).			"plain keys"
		cmdMap at: ((cmds at: i) asciiValue - 32 + 1) put: (cmds at: i + 1).		"shifted keys"
		cmdMap at: ((cmds at: i) asciiValue - 96 + 1) put: (cmds at: i + 1).		"ctrl keys"
	].

	^ cmdMap
]
