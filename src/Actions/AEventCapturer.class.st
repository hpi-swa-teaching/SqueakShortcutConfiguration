"
Class for grabbing user input
"
Class {
	#name : #AEventCapturer,
	#superclass : #ADialog,
	#instVars : [
		'captureMorph'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:31'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/14/2020 22:28'
}
AEventCapturer class >> getUserChoice [

	| dialog |
	dialog := self new.
	ToolBuilder open: dialog.
	^ dialog result
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 10/15/2020 00:49'
}
AEventCapturer >> buildWith: aToolBuilder [

	| dialog |
	dialog := super buildWith: aToolBuilder.
	
	self captureMorph: AEventCaptureMorph new.
	(aToolBuilder widgetAt: #content)
		addMorph: self captureMorph.
	
	^ dialog
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/25/2020 22:09'
}
AEventCapturer >> captureMorph [

	^ captureMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/25/2020 22:09'
}
AEventCapturer >> captureMorph: anObject [

	captureMorph := anObject.
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 10/15/2020 01:37'
}
AEventCapturer >> createDialogSpecWith: aToolBuilder [

	| dialogSpec |
	dialogSpec := super createDialogSpecWith: aToolBuilder.
	dialogSpec extent: 180@60.
	^ dialogSpec
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 12:12'
}
AEventCapturer >> setResult [

	self result: self captureMorph eventKey
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/9/2020 15:17'
}
AEventCapturer >> title [

	^ 'Event capturer'
]
