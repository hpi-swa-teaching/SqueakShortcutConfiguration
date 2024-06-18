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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/18/2024 12:07'
}
SSC_Action >> = anAction [
	^ (self species == anAction species) 
		and: [self hash = anAction hash]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/18/2024 23:09'
}
SSC_Action >> hash [
	^ [title. key. keyModifiers. method] hash
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
	#category : #'as yet unclassified',
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/18/2024 23:08'
}
SSC_Action >> performOn: anObject withEvent: anEvent [
	"optionally pass the event as the first parameter"
	anObject perform: method withEnoughArguments: {anEvent}.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:06'
}
SSC_Action >> printOn: aStream [
	aStream nextPutAll: self title
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
