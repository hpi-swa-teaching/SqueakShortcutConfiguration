Class {
	#name : #DefaultShortcutAPITests,
	#superclass : #TestCase,
	#category : 'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'DdJ 6/15/2022 17:31'
}
DefaultShortcutAPITests >> testActionShortcutPairCreation [
	|exampleAPICall expectedShortcuts resultRecipient createdShortcut expectedShortcut|
	exampleAPICall := {
		{'Move up' . #moveUp . 'Moves the currently selected items above the items over it' . $a . #cmdPressed}.
		{'Add line' . #addSeparator . 'Adds a seperator/line'. $A . #cmdPressed}.
		{'Move up' . #moveDown . 'Moves the currently selected items under the items under it' }.
	}.
	
	expectedShortcuts := {
	 	KeyboardEvent new setType: #keystroke buttons: 64 position: 0 @ 0 keyValue: $a asciiValue hand: nil stamp: $a.
		KeyboardEvent new setType: #keystroke buttons: 72 position: 0 @ 0 keyValue: $A asciiValue hand: nil stamp: $A.
		nil.
	}.
	
	resultRecipient := OrderedCollection new.
	exampleAPICall do: [:each | AAction createActionShortcutPair: each in: resultRecipient.].
	
	1 to: exampleAPICall size do: [ :i |
		createdShortcut := (resultRecipient at: i) second.
		expectedShortcut := expectedShortcuts at: i.
		self assert: createdShortcut = expectedShortcut.].
		
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'DdJ 6/15/2022 16:48'
}
DefaultShortcutAPITests >> testDefaultShortcutIngetrity [
	AMenuBrowser actions do: [:each | 
		self assert: (each first isKindOf: AAction).
		self assert: ((each second isNil) | (each second isKindOf: KeyboardEvent))].
	
]
