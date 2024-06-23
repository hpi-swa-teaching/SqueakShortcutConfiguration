Class {
	#name : #'SSC_Test_Browser',
	#superclass : #TestCase,
	#instVars : [
		'browserWindow',
		'browser'
	],
	#category : #'SqueakShortcutConfiguration-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/23/2024 15:45'
}
SSC_Test_Browser >> actionsListMorph [
	^ browserWindow submorphNamed: SSC_ShortcutBrowser actionsListName
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/23/2024 15:46'
}
SSC_Test_Browser >> classListMorph [
	^ browserWindow submorphNamed: SSC_ShortcutBrowser classListName
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/23/2024 15:08'
}
SSC_Test_Browser >> setUp [
	super setUp.
	browserWindow := SSC_ShortcutBrowser open.
	browser := browserWindow model.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/23/2024 15:05'
}
SSC_Test_Browser >> tearDown [
	browserWindow abandon
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/23/2024 17:26'
}
SSC_Test_Browser >> testActionsEditing [
	|event|
	
	event := SSC_Test_KeyboardEvent new.
	
	"automatically submit the dialog"
	[ |eventCapturer|
		100 milliSeconds busyWait.
		eventCapturer := (World submorphNamed: #sscDialog) model.
		eventCapturer captureMorph eventKey: event.
		eventCapturer accept] fork.

	browser classIndex: 1.
	browser actionIndex: 1.
	browser actionDoubleClicked.
	
	self assert: (self actionsListMorph getList first key = event keyCharacter).
	

	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/23/2024 15:47'
}
SSC_Test_Browser >> testActionsListContents [
	browser classIndex: 1.
	self assert: (SSC_Example SSCActions allSatisfy: [:action | self actionsListMorph getList includes: action]).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/23/2024 15:09'
}
SSC_Test_Browser >> testClassContents [
	self assert: (self classListMorph getList includes: #SSC_Example)
]
