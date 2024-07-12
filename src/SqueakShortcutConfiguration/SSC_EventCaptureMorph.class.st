Class {
	#name : #'SSC_EventCaptureMorph',
	#superclass : #BorderedMorph,
	#instVars : [
		'stringMorph',
		'keyEvent'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:26'
}
SSC_EventCaptureMorph >> addStringMorph [

	self stringMorph: StringMorph new.
	self stringMorph contents: ''.
	self addMorphCentered: self stringMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'yl 6/22/2024 19:27'
}
SSC_EventCaptureMorph >> contents [ 

	self stringMorph contents
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'yl 6/22/2024 19:27'
}
SSC_EventCaptureMorph >> contents: aString [ 

	self stringMorph contents: aString
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:26'
}
SSC_EventCaptureMorph >> eventAsString [ 
	| stream |
	stream := WriteStream on: String new.
	SSC_Action printKey: self keyEvent keyCharacter on: stream.
	^ stream contents
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'yl 6/22/2024 19:28'
}
SSC_EventCaptureMorph >> handlesKeyboard: evt [ 

	^ true
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'yl 6/22/2024 19:28'
}
SSC_EventCaptureMorph >> initialize [ 

	super initialize.
	self
		initializeStyle;
		addStringMorph;
		initializeLayout 
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'yl 6/22/2024 19:28'
}
SSC_EventCaptureMorph >> initializeLayout [ 

	self layoutPolicy: TableLayout new.
	self vResizing: #spaceFill.
	self hResizing: #spaceFill.
	self listCentering: #center.
	self wrapCentering: #center
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'yl 6/22/2024 19:28'
}
SSC_EventCaptureMorph >> initializeStyle [ 

	self color: Color transparent.
	self extent: self positionTextBox
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:26'
}
SSC_EventCaptureMorph >> keyEvent [ 

	^ keyEvent
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:26'
}
SSC_EventCaptureMorph >> keyEvent: anObject [ 

	keyEvent := anObject.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:26'
}
SSC_EventCaptureMorph >> keyStroke: evt [ 
	evt controlKeyPressed
		ifTrue: [self keyEvent: evt. self contents: self eventAsString]
		ifFalse: [self contents: 'Enter Ctrl-Shortcut']
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'Moritz Grimm 7/12/2024 10:07'
}
SSC_EventCaptureMorph >> positionTextBox [
	^ 180@50
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'yl 6/22/2024 19:29'
}
SSC_EventCaptureMorph >> stringMorph [

	^ stringMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'yl 6/22/2024 19:29'
}
SSC_EventCaptureMorph >> stringMorph: anObject [ 

	stringMorph := anObject.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'yl 6/22/2024 19:29'
}
SSC_EventCaptureMorph >> wantsKeyboardFocus [

	^ true
]
