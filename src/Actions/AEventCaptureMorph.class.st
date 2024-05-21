"
Class for grabbing user input
"
Class {
	#name : #AEventCaptureMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'stringMorph',
		'eventKey'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:31'
}

{
	#category : #initialization,
	#'squeak_changestamp' : 'WoC 9/25/2020 16:23'
}
AEventCaptureMorph >> addStringMorph [

	self stringMorph: StringMorph new.
	self stringMorph contents: ''.
	self addMorphCentered: self stringMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/21/2020 13:08'
}
AEventCaptureMorph >> contents [

	self stringMorph contents
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/21/2020 13:08'
}
AEventCaptureMorph >> contents: aString [

	self stringMorph contents: aString
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/30/2020 22:38'
}
AEventCaptureMorph >> eventAsString [

	| stream |
	stream := WriteStream on: ''.
	self eventKey printKeyStringOn: stream.
	^ stream contents
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/25/2020 20:15'
}
AEventCaptureMorph >> eventKey [

	^ eventKey
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/25/2020 20:15'
}
AEventCaptureMorph >> eventKey: anObject [

	eventKey := anObject.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'WoC 9/21/2020 13:02'
}
AEventCaptureMorph >> handlesKeyboard: evt [

	^ true
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'WoC 9/25/2020 16:24'
}
AEventCaptureMorph >> initialize [

	super initialize.
	self
		initializeStyle;
		addStringMorph;
		initializeLayout
		
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'WoC 9/25/2020 16:24'
}
AEventCaptureMorph >> initializeLayout [

	self layoutPolicy: TableLayout new.
	self vResizing: #spaceFill.
	self hResizing: #spaceFill.
	self listCentering: #center.
	self wrapCentering: #center
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'ft 8/5/2022 16:06'
}
AEventCaptureMorph >> initializeStyle [

	self color: Color transparent.
	self extent: self positionTextBox
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'WoC 10/15/2020 04:43'
}
AEventCaptureMorph >> keyStroke: evt [

	self eventKey: evt.
	self contents: self eventAsString
]

{
	#category : #default,
	#'squeak_changestamp' : 'ft 8/5/2022 16:06'
}
AEventCaptureMorph >> positionTextBox [

	^ 180@50
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/21/2020 13:06'
}
AEventCaptureMorph >> stringMorph [

	^ stringMorph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/21/2020 13:06'
}
AEventCaptureMorph >> stringMorph: anObject [

	stringMorph := anObject.
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'WoC 9/25/2020 13:48'
}
AEventCaptureMorph >> wantsKeyboardFocus [

	^ true
]
