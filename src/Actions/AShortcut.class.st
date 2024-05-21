Class {
	#name : #AShortcut,
	#superclass : #Object,
	#instVars : [
		'modifierPressed',
		'shiftPressed',
		'key'
	],
	#category : #'Actions-Core'
}

{
	#category : #creation,
	#'squeak_changestamp' : 'WoC 9/28/2020 13:10'
}
AShortcut class >> from: evt [

	^ self new
		modifierPressed: (evt controlKeyPressed or: [evt commandKeyPressed]);
		shiftPressed: evt shiftPressed;
		key: (Character codePoint: evt keyValue);
		yourself
	
]

{
	#category : #creation,
	#'squeak_changestamp' : 'WoC 9/30/2020 02:32'
}
AShortcut class >> modifier: aCharacter [

	^ self new
		modifierPressed: true;
		shiftPressed: false;
		key: aCharacter;
		yourself
]

{
	#category : #creation,
	#'squeak_changestamp' : 'WoC 9/30/2020 02:32'
}
AShortcut class >> modifierShift: aCharacter [

	^ self new
		modifierPressed: true;
		shiftPressed: true;
		key: aCharacter;
		yourself
]

{
	#category : #creation,
	#'squeak_changestamp' : 'WoC 9/30/2020 02:32'
}
AShortcut class >> onlyKey: aCharacter [

	^ self new
		modifierPressed: false;
		shiftPressed: false;
		key: aCharacter;
		yourself
]

{
	#category : #comparing,
	#'squeak_changestamp' : 'WoC 9/25/2020 14:25'
}
AShortcut >> = anEventKey [

	anEventKey class = self class
		ifFalse: [^ false].
	^ self modifierPressed = anEventKey modifierPressed and: [self key = anEventKey key]
	
]

{
	#category : #converting,
	#'squeak_changestamp' : 'WoC 9/30/2020 02:11'
}
AShortcut >> asString [

	| string |
	string := ''.
	self modifierPressed ifTrue: [string := self platformModifierString].
	self shiftPressed ifTrue: [string := string , '<shift>'].
	^ string , (self keyStringFor: self key)
]

{
	#category : #comparing,
	#'squeak_changestamp' : 'WoC 9/25/2020 14:33'
}
AShortcut >> hash [

	^ self asString hash
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/25/2020 14:08'
}
AShortcut >> key [

	^ key
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/25/2020 14:08'
}
AShortcut >> key: anObject [

	key := anObject.
]

{
	#category : #converting,
	#'squeak_changestamp' : 'WoC 9/28/2020 13:08'
}
AShortcut >> keyStringFor: aCharacter [

	^ '<' , (aCharacter caseOf: {
		[ Character space ] -> [ 'space' ].
		[ Character tab ] -> [ 'tab' ].
		[ Character cr ] -> [ 'cr' ].
		[ Character lf ] -> [ 'lf' ].
		[ Character enter ] -> [ 'enter' ].

		[ Character backspace ] -> [ 'backspace' ].
		[ Character delete ] -> [ 'delete' ].

		[ Character escape ] -> [ 'escape' ].

		[ Character arrowDown ] -> [ 'down' ].
		[ Character arrowUp ] -> [ 'up' ].
		[ Character arrowLeft ] -> [ 'left' ].
		[ Character arrowRight ] -> [ 'right' ].

		[ Character end ] -> [ 'end' ].
		[ Character home ] -> [ 'home' ].
		[ Character pageDown ] -> [ 'pageDown' ].
		[ Character pageUp ] -> [ 'pageUp' ].

		[ Character euro ] -> [ 'euro' ].
		[ Character insert ] -> [ 'insert' ].

		} otherwise: [ ^ aCharacter asLowercase ]) , '>'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/25/2020 14:08'
}
AShortcut >> modifierPressed [

	^ modifierPressed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/25/2020 14:08'
}
AShortcut >> modifierPressed: anObject [

	modifierPressed := anObject.
]

{
	#category : #converting,
	#'squeak_changestamp' : 'WoC 9/26/2020 19:12'
}
AShortcut >> platformModifierString [

	^ Smalltalk platformName = 'Mac OS'
		ifTrue: ['<cmd>']
		ifFalse: ['<ctrl>']
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/28/2020 13:10'
}
AShortcut >> shiftPressed [

	^ shiftPressed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/28/2020 13:10'
}
AShortcut >> shiftPressed: anObject [

	shiftPressed := anObject.
]
