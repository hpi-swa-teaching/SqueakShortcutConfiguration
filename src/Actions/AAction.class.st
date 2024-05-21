Class {
	#name : #AAction,
	#superclass : #AActionDescription,
	#instVars : [
		'description',
		'action'
	],
	#category : #'Actions-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/14/2020 22:11'
}
AAction class >> from: aCollection [

	^ self 
		title: aCollection first
		action: aCollection second
		description: aCollection third
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/14/2020 22:00'
}
AAction class >> title: aSymbol action: aKeywordOrBlock description: aString [

	^ self new
		title: aSymbol;
		action: aKeywordOrBlock;
		description: aString;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/14/2020 21:57'
}
AAction >> action [

	^ action
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/14/2020 21:57'
}
AAction >> action: anObject [

	action := anObject.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/14/2020 23:59'
}
AAction >> asTreeNode [

	^ ATreeNode value: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/28/2020 12:10'
}
AAction >> description [

	^ description ifNil: ['']
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/14/2020 21:57'
}
AAction >> description: anObject [

	description := anObject.
]

{
	#category : #evaluating,
	#'squeak_changestamp' : 'WoC 9/14/2020 21:57'
}
AAction >> for: anObject [

	self action cull: anObject
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 10/14/2020 23:10'
}
AAction >> isAction [

	^ true
]

{
	#category : #printing,
	#'squeak_changestamp' : 'WoC 9/28/2020 12:06'
}
AAction >> printOn: aStream [

	aStream nextPutAll: self title , self shortcutRepresentation
]

{
	#category : #printing,
	#'squeak_changestamp' : 'WoC 9/30/2020 22:52'
}
AAction >> shortcutRepresentation [

	| shortcuts |
	shortcuts := AActions 
		shortcutsFor: self 
		in: self clazz
		ifAbsent: [^ ''].
	^ '(' , ((shortcuts 
		collect: [:each | | stream |
			stream := WriteStream on: ''.
			each printKeyStringOn: stream.
			stream contents]) 
		joinSeparatedBy: ', ' ) , ')'
]

{
	#category : #'write representation',
	#'squeak_changestamp' : 'WoC 10/8/2020 14:09'
}
AAction >> writeListRepresentationOn: aCollection [

	aCollection add: self
]

{
	#category : #'write representation',
	#'squeak_changestamp' : 'WoC 9/29/2020 12:12'
}
AAction >> writeTreeRepresentationInto: aTreeNode [

	aTreeNode addChild: (ATreeNode value: self) 
]
