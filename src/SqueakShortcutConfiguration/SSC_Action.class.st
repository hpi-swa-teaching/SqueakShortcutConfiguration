Class {
	#name : #'SSC_Action',
	#superclass : #Object,
	#instVars : [
		'title',
		'method',
		'key',
		'shift',
		'id'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:16'
}
SSC_Action class >> printKey: aKey on: aStream [ 
	aStream nextPutAll: 'Ctrl+'.
	aKey storeOn: aStream.
]

{
	#category : #hashing,
	#'squeak_changestamp' : 'MZ 6/19/2024 11:18'
}
SSC_Action >> = anAction [
	^ (self species == anAction species) 
		and: [self hash = anAction hash]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/18/2024 11:59'
}
SSC_Action >> action1 [
	Transcript show: 'action1 called'; cr.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/18/2024 22:31'
}
SSC_Action >> action2WithEventAsParameter: anEvent [
	Transcript show: 'action2 called with event '; show: anEvent; cr.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 7/2/2024 19:27'
}
SSC_Action >> copy [
	^ SSC_Action new
		id: id;
		key: key;
		method: method;
		shift: shift;
		title: title
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/18/2024 22:19'
}
SSC_Action >> handlesKeyboard: anEvent [
	^ true
]

{
	#category : #hashing,
	#'squeak_changestamp' : 'MZ 6/29/2024 22:19'
}
SSC_Action >> hash [
	^ ((title hash bitXor: key hash) bitXor: method hash) bitXor: shift hash
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 7/2/2024 18:36'
}
SSC_Action >> id [
	^ id
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 7/2/2024 18:37'
}
SSC_Action >> id: anObject [
	id := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/29/2024 21:54'
}
SSC_Action >> key [
	self shift ifTrue: [^ key asUppercase] ifFalse: [^ key]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/29/2024 22:00'
}
SSC_Action >> key: aKey [
	key := aKey.
	shift isNil ifTrue: [shift := aKey isUppercase].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/18/2024 23:30'
}
SSC_Action >> keyStroke: anEvent [
	self class SSCActions do: [:action | 
		(action matches: anEvent) ifTrue: [action performOn: self withEvent: anEvent]]
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'MZ 6/18/2024 23:19'
}
SSC_Action >> matches: anEvent [
	^ (key = anEvent keyCharacter) and: anEvent controlKeyPressed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/18/2024 12:06'
}
SSC_Action >> method [
	^ method
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/18/2024 22:11'
}
SSC_Action >> method: aSymbol [
	method := aSymbol.
	title ifNil: [title := method asString]
]

{
	#category : #'event handling',
	#'squeak_changestamp' : 'MZ 6/18/2024 23:08'
}
SSC_Action >> performOn: anObject withEvent: anEvent [
	"optionally pass the event as the first parameter"
	anObject perform: method withEnoughArguments: {anEvent}.
]

{
	#category : #printing,
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:16'
}
SSC_Action >> printOn: aStream [
	aStream nextPutAll: '('.
	self class printKey: key on: aStream.
	aStream nextPutAll: ')  ';
		 nextPutAll: self title
		
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/29/2024 21:53'
}
SSC_Action >> shift [
	^ shift
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/29/2024 21:53'
}
SSC_Action >> shift: aBoolean [
	shift := aBoolean
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/18/2024 12:04'
}
SSC_Action >> title [
	^ title
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/18/2024 12:04'
}
SSC_Action >> title: aString [
	title := aString
]
