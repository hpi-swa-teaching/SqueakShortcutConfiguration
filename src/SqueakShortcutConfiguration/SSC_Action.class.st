Class {
	#name : #'SSC_Action',
	#superclass : #Object,
	#instVars : [
		'title',
		'method',
		'key'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #hashing,
	#'squeak_changestamp' : 'MZ 6/19/2024 11:18'
}
SSC_Action >> = anAction [
	^ (self species == anAction species) 
		and: [self hash = anAction hash]
]

{
	#category : #hashing,
	#'squeak_changestamp' : 'MZ 6/19/2024 11:08'
}
SSC_Action >> hash [
	^ (title hash bitXor: key hash) bitXor: method hash
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/18/2024 23:11'
}
SSC_Action >> key [
	^ key
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/18/2024 23:11'
}
SSC_Action >> key: aKey [
	key := aKey
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
	#'squeak_changestamp' : 'MZ 6/24/2024 11:49'
}
SSC_Action >> printOn: aStream [ 
	aStream nextPutAll: '(Ctrl+'.
	key storeOn: aStream.
	aStream nextPutAll: ')  ';
		 nextPutAll: self title
		
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
