"
Class that maintains actions and provides functionality
"
Class {
	#name : #AActions,
	#superclass : #Object,
	#classVars : [
		'AreDefaultShortcutsAlreadyActive',
		'Menus',
		'Shortcuts'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:40'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 5/10/2022 18:16'
}
AActions class >> actionPragmas [

	^ self allActionMethods groupBy: [:each | each methodClass theNonMetaClass]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 5/10/2022 18:16'
}
AActions class >> actionPragmasFor: aClass [

	^ self actionPragmas
			at: aClass
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 5/24/2022 19:44'
}
AActions class >> actionsFor: aClass [

	| methods actions |
	methods := (self actionPragmasFor: aClass) collect: [:each | each method].
	actions := OrderedCollection new.
	methods do: [:each | (self actionsFrom: each For: aClass) do: [ :action |actions add: action]].
	actions do: [:each | each clazz: aClass].
	^ actions
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 5/24/2022 20:12'
}
AActions class >> actionsFrom: aCompiledMethod For: aClass [

| methodResult actions|

actions := OrderedCollection new.
methodResult := aCompiledMethod valueWithReceiver: aClass arguments: {}.
methodResult isDictionary
	ifTrue: [methodResult keys do: [:ea | self add: ea IfAnActionTo: actions]]
	ifFalse: [
	methodResult isCollection
		ifTrue: [(methodResult do: [:ea | self add: ea IfAnActionTo: actions])]
		ifFalse: [self add: methodResult IfAnActionTo: actions]
	].
^ actions
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 5/14/2022 15:45'
}
AActions class >> activateDefaultShortcuts [

	self actionPragmas keysAndValuesDo: [:class :methods |
		self activateShortcutsFrom: methods For: class.
	].
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 5/14/2022 16:47'
}
AActions class >> activateDefaultShortcutsFor: aClass [

	self activateShortcutsFrom: (self actionPragmasFor: aClass) For: aClass.
	
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 5/14/2022 15:45'
}
AActions class >> activateShortcutsFrom: methods For: aClass [
		
			methods do: [ :method |
				| actions |
				actions := method valueWithReceiver: aClass arguments: {}.
				actions isDictionary ifTrue: [
					actions keysAndValuesDo: [ :action :shortcut |
						action clazz: aClass.			
						(self testIfIsAction: action) ifTrue: [self addShortcut: shortcut for: action in: aClass].
					].
				].
			].
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'KK 5/10/2022 18:07'
}
AActions class >> add: anObject IfAnActionTo: aCollection [
	(self testIfIsAction: anObject) ifTrue: [aCollection add: anObject]
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'WoC 9/30/2020 13:16'
}
AActions class >> addDefaultShortcut: aShortcut for: anAction in: aClass [

	| shortcuts |
	shortcuts := (Shortcuts at: aClass ifAbsentPut: [Dictionary new]).
	(shortcuts includesKey: anAction title)
		ifFalse:[self addShortcut: aShortcut for: anAction in: aClass name]
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'KK 6/14/2022 17:09'
}
AActions class >> addShortcut: aShortcut for: anAction in: aClass [
	|shortcutDict isResetConfirmed duplicateExists|
	
	shortcutDict := Shortcuts at: aClass ifAbsentPut: [Dictionary new].
	duplicateExists := (self duplicateOf: aShortcut in: shortcutDict).
	
	(duplicateExists)
			ifTrue: [isResetConfirmed := (PopUpMenu confirm: 
				'The Key combination you are about to assign is already used.
				 Do you really want to override: ', 
				(shortcutDict at: aShortcut), ' ?').
				isResetConfirmed 
						ifFalse:[^shortcutDict ]].

	^ shortcutDict at: aShortcut put: anAction 
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 5/10/2022 18:55'
}
AActions class >> allActionMethods [

	| methods |
	methods := OrderedCollection new.
	Smalltalk allClassesDo: [:aClass |
		aClass class methodsDo: [:method |
			(self recognizes: method)
				ifTrue: [methods add: method]
		]].
	^ methods
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 5/19/2022 11:53'
}
AActions class >> checkIfDuplicatesExistsFor: aClass [

	| collection |
	
	collection := SortedCollection sortBlock: [:a :b |  (a title = b title) ifTrue: [^ a ]. a title <= b title].
	(self actionsFor: aClass) do: [:each | each writeListRepresentationOn: collection].
	
	^ nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/26/2020 14:56'
}
AActions class >> classesWithActions [

	^ (self allActionMethods collect: [:each | each methodClass theNonMetaClass])
		asSet 
		asSortedCollection: [:a :b | a name <= b name]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/1/2020 00:50'
}
AActions class >> cleanActionsOf: aClass [
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'wb 5/18/2022 15:49'
}
AActions class >> duplicateOf: aShortcut in: aDict [
	|hashdict keys|
	hashdict := Dictionary new.
	keys := aDict keys.
	
	"check if keystring already exisists in aDict"
	keys do: [:key | (key keyString = aShortcut keyString)
					ifTrue: [Transcript show: (key keyString = aShortcut keyString). ^true]].
	^false
]

{
	#category : #'handle menus',
	#'squeak_changestamp' : 'WoC 10/15/2020 01:53'
}
AActions class >> fillMenu: aMenu for: anObject [

	| classes |
	classes := anObject class withAllSuperclasses.
	classes do: [:each | (Menus at: each ifAbsent: [ATreeNode new]) fill: aMenu for: anObject].
	^ aMenu
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/8/2020 14:11'
}
AActions class >> initializeIfNeccessary [

	self install
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'KK 5/30/2022 18:19'
}
AActions class >> install [
	
	Menus := Menus ifNil: [Dictionary new].
	Shortcuts := Shortcuts ifNil: [Dictionary new].
	
	(AreDefaultShortcutsAlreadyActive isNil or: [AreDefaultShortcutsAlreadyActive not]) ifTrue: [
		self activateDefaultShortcuts.
		AreDefaultShortcutsAlreadyActive := true.
	].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/14/2020 22:15'
}
AActions class >> make: aCollection [

	aCollection do: [:each | | collection |
		collection := each.
		(each isKindOf: Association)
			ifTrue: [collection := each value].
		
		AAction from: collection.
	]
]

{
	#category : #'handle menus',
	#'squeak_changestamp' : 'WoC 10/14/2020 23:12'
}
AActions class >> menuFor: aClass [

	^ (Menus at: aClass ifAbsent: [ATreeNode new])
]

{
	#category : #'handle menus',
	#'squeak_changestamp' : 'WoC 9/30/2020 03:07'
}
AActions class >> menuStructureFor: aClass [

	^ Menus at: aClass ifAbsent: [ATreeNode new]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 5/10/2022 10:45'
}
AActions class >> pragmaKeywords [

	^ {#wantsActions . #wantsDefaultActions . #wantsActionsInCategory:}
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 10/26/2020 15:01'
}
AActions class >> recognizes: aMethod [

	^ aMethod pragmas 
		anySatisfy: [:each | self pragmaKeywords includes: each keyword]

	
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'WoC 9/30/2020 03:08'
}
AActions class >> removeShortcut: anEventKey in: aClass [

	(Shortcuts at: aClass) removeKey: anEventKey
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 5/14/2022 15:48'
}
AActions class >> removeShortcuts [
	Shortcuts := Dictionary new.
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 5/14/2022 16:36'
}
AActions class >> removeShortcutsFor: aClass [
	Shortcuts removeKey: aClass ifAbsent: [].
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'WoC 9/30/2020 21:44'
}
AActions class >> reset [

	Menus := Dictionary new.
	Shortcuts := Dictionary new
	
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 5/14/2022 15:50'
}
AActions class >> resetDefaultShortcuts [
	
	self removeShortcuts.
	self activateDefaultShortcuts.
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 5/14/2022 15:50'
}
AActions class >> resetDefaultShortcutsFor: aClass [
	
	self removeShortcutsFor: aClass.
	self activateDefaultShortcutsFor: aClass.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 5/24/2022 19:50'
}
AActions class >> selectorsWith: aAction DefinedFor: aClass [
	
	| releveantSelectors |
	
	releveantSelectors := OrderedCollection new.
	
	(self actionPragmasFor: aClass) do: [ :compiledMethod | 
		(self actionsFrom: compiledMethod For: aClass) do: [ :action |
			(action title = aAction title) 
				ifTrue: [ releveantSelectors addIfNotPresent: compiledMethod selector ].
		].
	].

	^ releveantSelectors
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 5/24/2022 19:07'
}
AActions class >> selectorsWithActionsDefinedFor: aClass [

	^(self actionPragmasFor: aClass) collect: [ :method | method selector]
]

{
	#category : #'handle menus',
	#'squeak_changestamp' : 'WoC 9/30/2020 03:07'
}
AActions class >> setMenuFor: aClass to: aTreeNode [

	Menus at: aClass put: aTreeNode
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'WoC 10/15/2020 01:53'
}
AActions class >> shortcutFor: anObject event: evt [

	| classes |
	evt isKeyboard
		ifFalse: [^ self].
	
	classes := anObject class withAllSuperclasses.
	classes do: [:each | 
		Shortcuts 
		at: each
		ifPresent: [:dict | dict 
							at: evt
							ifPresent: [:association | association value for: anObject. ^ self]]]
	
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'WoC 9/30/2020 03:09'
}
AActions class >> shortcutsFor: anAction in: aClass ifAbsent: aBlock [

	| shortcuts |
	shortcuts := OrderedCollection new.
	(Shortcuts at: aClass ifAbsent: [^ aBlock value]) 
		associationsDo: [:association | anAction = association value value
			ifTrue: [shortcuts add: association key]].
	
	shortcuts isEmpty ifTrue: [^ aBlock value].
	^ shortcuts
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 9/29/2020 22:25'
}
AActions class >> testIfIsAction: anObject [

	^ anObject isKindOf: AActionDescription
]

{
	#category : #pragmas,
	#'squeak_changestamp' : 'WoC 10/15/2020 15:00'
}
AActions >> wantsActions [

	"Actions get added to the default category"
]

{
	#category : #pragmas,
	#'squeak_changestamp' : 'WoC 10/15/2020 15:01'
}
AActions >> wantsActionsInCategory: aSymbol [

	"Actions get added to the category aSymbol"
]
