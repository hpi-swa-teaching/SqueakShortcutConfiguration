Class {
	#name : #'SSC_EventCapturer',
	#superclass : #'SSC_Dialog',
	#instVars : [
		'captureMorph'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:36'
}
SSC_EventCapturer class >> getUserChoice [

	| dialog |
	dialog := self new.
	ToolBuilder open: dialog.
	^ dialog result
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'Moritz Grimm 7/12/2024 09:56'
}
SSC_EventCapturer >> buildWith: aToolBuilder [ 
	| dialog |
	dialog := super buildWith: aToolBuilder.
	self captureMorph: SSC_EventCaptureMorph new.
	(aToolBuilder widgetAt: #content)
		addMorph: self captureMorph.
	^ dialog
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:37'
}
SSC_EventCapturer >> captureMorph [

	^ captureMorph
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:37'
}
SSC_EventCapturer >> captureMorph: anObject [

	captureMorph := anObject.
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'yl 6/22/2024 19:37'
}
SSC_EventCapturer >> createDialogSpecWith: aToolBuilder [

	| dialogSpec |
	dialogSpec := super createDialogSpecWith: aToolBuilder.
	dialogSpec extent: self positionEventCapturerWindow.
	^ dialogSpec
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'Moritz Grimm 7/12/2024 10:06'
}
SSC_EventCapturer >> positionEventCapturerWindow [
	^ 180@60
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:25'
}
SSC_EventCapturer >> setResult [ 

	self result: self captureMorph keyEvent
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:38'
}
SSC_EventCapturer >> title [ 

	^ 'Event capturer'
]
