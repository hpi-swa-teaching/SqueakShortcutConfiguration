Class {
	#name : #'SSC_Test_KeyboardEvent',
	#superclass : #KeyboardEvent,
	#instVars : [
		'keyCharacter',
		'shiftPressed'
	],
	#category : #'SqueakShortcutConfiguration-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 7/1/2024 21:52'
}
SSC_Test_KeyboardEvent >> initialize [
	super initialize.
	keyCharacter := $Ü.
	shiftPressed := true.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/24/2024 10:26'
}
SSC_Test_KeyboardEvent >> keyCharacter [
	^ keyCharacter
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/24/2024 10:26'
}
SSC_Test_KeyboardEvent >> keyCharacter: aKeyChar [
	keyCharacter := aKeyChar
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 7/1/2024 21:45'
}
SSC_Test_KeyboardEvent >> printOn: aStream [
	aStream
		nextPutAll: '[SSC_Test_KeyboardEvent keyChar: ';
		nextPut: self keyCharacter;
		nextPut: $].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 7/1/2024 21:47'
}
SSC_Test_KeyboardEvent >> shiftPressed [
	^ shiftPressed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 7/1/2024 21:46'
}
SSC_Test_KeyboardEvent >> shiftPressed: aBoolean [
	shiftPressed := aBoolean
]
