Class {
	#name : #AShortcutTests,
	#superclass : #ActionsTest,
	#category : #'Actions-Test'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'TA 8/4/2022 09:45'
}
AShortcutTests >> testShortcutComparison [

	|keyBoardEvent shortcut1 shortcut2 shortcut3|
	
	keyBoardEvent := KeyboardEvent new setType: #keystroke buttons: 72 position: 42@42 keyValue: $b asciiValue hand: nil stamp: nil.
	shortcut1 := AShortcut from: keyBoardEvent.
	shortcut2 := AShortcut modifierShift: $b.
	shortcut3 := AShortcut modifier: $B.
	
	self assert: shortcut1 = shortcut2.
	self assert: shortcut1 hash = shortcut2 hash.
	self assert: shortcut1 ~= shortcut3.
	
]

{
	#category : #testing,
	#'squeak_changestamp' : 'KK 8/4/2022 19:01'
}
AShortcutTests >> testShortcutFromOnlyAKeyIntegrity [

	| shortcut key|
	
	key := $d.
	shortcut := AShortcut onlyKey: key.
	
	self 
		deny: shortcut shiftPressed;
		deny: shortcut modifierPressed;
		assert: shortcut key equals: key;
		assert: shortcut asString equals: 'd'.
	
]

{
	#category : #testing,
	#'squeak_changestamp' : 'KK 8/4/2022 18:59'
}
AShortcutTests >> testShortcutIntegrity [

	| shortcut |
	
	shortcut := AShortcut from: self shortcutCtrld.
	self assert: shortcut shiftPressed not.
	self assert: shortcut modifierPressed.
	self assert: shortcut key = $d.
	self assert: (shortcut asString = '<ctrl>d' or: shortcut asString = '<cmd>d').
	
	shortcut shiftPressed: true.
	self assert: shortcut shiftPressed.
	self assert: (shortcut asString = '<ctrl><shift>d' or: shortcut asString = '<cmd><shift>d')
	
]
