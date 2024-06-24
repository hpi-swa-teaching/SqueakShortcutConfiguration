Class {
	#name : #'SSC_Test_KeyboardEvent',
	#superclass : #KeyboardEvent,
	#instVars : [
		'keyCharacter'
	],
	#category : #'SqueakShortcutConfiguration-Tests'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/24/2024 10:26'
}
SSC_Test_KeyboardEvent >> initialize [
	super initialize.
	keyCharacter := $X.
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
