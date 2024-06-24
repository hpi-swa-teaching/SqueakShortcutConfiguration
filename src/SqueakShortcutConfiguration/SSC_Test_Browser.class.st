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
	#'squeak_changestamp' : 'MZ 6/24/2024 10:28'
}
SSC_Test_Browser >> changeSelectedActionKeyTo: aKey [
	|event|
	
	event := SSC_Test_KeyboardEvent new keyCharacter: aKey.

	"automatically submit the dialog"
	[ |eventCapturer|
		100 milliSeconds busyWait.
		eventCapturer := (World submorphNamed: #sscDialog) model.
		eventCapturer captureMorph eventKey: event.
		eventCapturer accept] fork.
	
	browser actionDoubleClicked.
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
	#'squeak_changestamp' : 'MZ 6/24/2024 10:33'
}
SSC_Test_Browser >> testActionsEditing [
	SSC_API configurableClasses do: [:class |	self testActionsEditingForClassWithName: class asString].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/24/2024 10:31'
}
SSC_Test_Browser >> testActionsEditingForClassWithName: aString [
	|event oldKey|
	
	browser classIndex: (browser classNames indexOf: aString).
	browser actionIndex: 1.
	
	oldKey := browser actionsListRepresentation first key.
	
	event := SSC_Test_KeyboardEvent new.
	
	self changeSelectedActionKeyTo: $X.
	self assert: (self actionsListMorph getList first key = $X).
	
	browser classIndex: (browser classNames indexOf: aString).
	browser actionIndex: 1.
	self changeSelectedActionKeyTo: oldKey.

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/24/2024 09:23'
}
SSC_Test_Browser >> testActionsListContents [
	browser classIndex: (browser classNames indexOf: 'SSC_Example').
	self assert: (SSC_Example SSCActions allSatisfy: [:action | self actionsListMorph getList includes: action]).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/23/2024 15:09'
}
SSC_Test_Browser >> testClassContents [
	self assert: (self classListMorph getList includes: #SSC_Example)
]
