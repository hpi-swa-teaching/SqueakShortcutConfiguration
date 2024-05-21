"
Class for creating Actions (triple of description, action and defaultShortcut)
"
Class {
	#name : #AAction,
	#superclass : #AActionDescription,
	#instVars : [
		'description',
		'action'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:45'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'wb 7/14/2022 10:37'
}
AAction class >> createActions: aCollection [ 
	|shortcut apiCallLength|

	apiCallLength := 5.
	shortcut := nil.
	(aCollection size = apiCallLength)
		ifTrue:[
			(aCollection fourth isCharacter and: aCollection fifth isSymbol)
		 		ifTrue:[ shortcut := (self createShortcutwithKeyValue: aCollection fourth andSymbol: aCollection fifth) ]
				ifFalse:[^self error: 'You tried to create the default Action ', (aCollection first) asString , ' but did not meet the requirements for the API. Please check your #actions'].].
		
	^{(self from: aCollection). shortcut}
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'wb 6/22/2022 13:55'
}
AAction class >> createShortcutwithKeyValue: keyVal andSymbol:  symbol [
	|shortcut buttonNumber cmdButtonNumber shiftCmdButtonNumber|
		cmdButtonNumber := 64.
		shiftCmdButtonNumber := 72.
		
		(symbol = #cmdPressed) ifTrue:[buttonNumber := cmdButtonNumber.].
		(keyVal isUppercase) ifTrue: [buttonNumber := shiftCmdButtonNumber.].
		^ shortcut := KeyboardEvent new 
					setType: #keystroke buttons: buttonNumber position: 0 @ 0 keyValue: keyVal asciiValue hand: nil stamp:keyVal
]

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
	#'squeak_changestamp' : 'KK 6/27/2022 15:50'
}
AAction >> executeSubsetActionIn: aMorph for: anObject at: aPosition keyboardFocus: aMorphWithFocus or: hasAnOwnerKeyboardFocus [ 
	
	"execute action if aMorph matches the mouse position and morph knownname and has keyboardfocus or an owner has keyboardfocus"
	
	| hasKeyboardFocus |
	
	(aMorph containsPoint: aPosition) ifFalse: [^ false ].
	
	hasKeyboardFocus := hasAnOwnerKeyboardFocus or: (aMorph = aMorphWithFocus).
	
	(aMorph knownName notNil and: hasKeyboardFocus) ifTrue: [
		self action 
			at: aMorph knownName 
			ifPresent: [:association | association value cull: anObject. ^ true]].
	
	aMorph submorphsDo: [ :submorph | 
		self executeSubsetActionIn: submorph 
			for: anObject 
			at: aPosition 
			keyboardFocus: aMorphWithFocus 
			or: hasKeyboardFocus].
		
	^ false
	
]

{
	#category : #evaluating,
	#'squeak_changestamp' : 'KK 6/27/2022 15:48'
}
AAction >> executeSubsetActionInWorldFor: anObject at: aPosition [
	
	^ self executeSubsetActionIn: World 
			for: anObject 
			at: aPosition 
			keyboardFocus: self keyboardFocusedMorphInWorld
			or: false
	
]

{
	#category : #evaluating,
	#'squeak_changestamp' : 'KK 6/27/2022 13:37'
}
AAction >> for: anObject [
	
	self action cull: anObject
]

{
	#category : #evaluating,
	#'squeak_changestamp' : 'KK 6/27/2022 14:12'
}
AAction >> for: anObject at: aPosition [

	self action isDictionary 
		ifTrue: [self executeSubsetActionInWorldFor: anObject at: aPosition]
		ifFalse: [self for: anObject]
	
]

{
	#category : #evaluating,
	#'squeak_changestamp' : 'KK 6/27/2022 14:17'
}
AAction >> has: aMorph partOfKeyboardFocus: aFocusedMorph [

		(aMorph = aFocusedMorph) ifTrue: [^ true].

]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 10/14/2020 23:10'
}
AAction >> isAction [

	^ true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:31'
}
AAction >> isGlobal [

	^false
]

{
	#category : #evaluating,
	#'squeak_changestamp' : 'KK 6/27/2022 13:41'
}
AAction >> keyboardFocusedMorphInWorld [

	World hands ifNil: [^ nil].
	World hands isEmpty ifTrue: [^ nil].
	^ World hands first keyboardFocus
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
