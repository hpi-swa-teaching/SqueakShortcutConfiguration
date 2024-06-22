Class {
	#name : #'SSC_EventCaptureMorph',
	#superclass : #BorderedMorph,
	#instVars : [
		'eventKey',
		'stringMorph'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:26'
}
SSC_EventCaptureMorph >> addStringMorph [

	self stringMorph: StringMorph new.
	self stringMorph contents: ''.
	self addMorphCentered: self stringMorph
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:27'
}
SSC_EventCaptureMorph >> contents [ 

	self stringMorph contents
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:27'
}
SSC_EventCaptureMorph >> contents: aString [ 

	self stringMorph contents: aString
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:27'
}
SSC_EventCaptureMorph >> eventAsString [ 

	| stream |
	stream := WriteStream on: ''.
	self eventKey printKeyStringOn: stream.
	^ stream contents
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:27'
}
SSC_EventCaptureMorph >> eventKey [ 

	^ eventKey
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:27'
}
SSC_EventCaptureMorph >> eventKey: anObject [ 

	eventKey := anObject.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:28'
}
SSC_EventCaptureMorph >> handlesKeyboard: evt [ 

	^ true
]

{
	#category : #'as yet unclassified',
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
	#category : #'as yet unclassified',
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:28'
}
SSC_EventCaptureMorph >> initializeStyle [ 

	self color: Color transparent.
	self extent: self positionTextBox
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:28'
}
SSC_EventCaptureMorph >> keyStroke: evt [ 

	self eventKey: evt.
	self contents: self eventAsString
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:28'
}
SSC_EventCaptureMorph >> positionTextBox [ 

	^ 180@50
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:29'
}
SSC_EventCaptureMorph >> stringMorph [

	^ stringMorph
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:29'
}
SSC_EventCaptureMorph >> stringMorph: anObject [ 

	stringMorph := anObject.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/22/2024 19:29'
}
SSC_EventCaptureMorph >> wantsKeyboardFocus [

	^ true
]
