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
	#'squeak_changestamp' : 'MaCl 6/23/2022 11:10'
}
AActions class >> actionsFrom: aCompiledMethod For: aClass [

| methodResult actions|

actions := OrderedCollection new.
methodResult := aCompiledMethod valueWithReceiver: aClass arguments: {}.
methodResult isDictionary
	ifTrue: [methodResult keys do: [:ea | self add: ea IfAnActionTo: actions]]
	ifFalse: [
	methodResult isCollection
		ifTrue: [(methodResult do: [:ea |self add: ea first IfAnActionTo: actions])] 
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
	#'squeak_changestamp' : 'wb 6/22/2022 14:01'
}
AActions class >> activateShortcutsFrom: methods For: aClass [
		|actions action shortcut|
		
			methods do: [ :method |
				actions := method valueWithReceiver: aClass arguments: {}.
				((actions isDictionary not) and: actions isCollection) ifTrue: [
					actions collect: [ :each |		
						action := each first.
						shortcut := each second.
						action clazz: aClass.			
						((self testIfIsAction: action) and: shortcut notNil) ifTrue: [self addShortcut: shortcut for: action in: aClass].
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
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 16:37'
}
AActions class >> addGlobalShortcut: aShortcut for: anAction [

	(self classesProviding: anAction) keysAndValuesDo: [:class :actions | actions do: [:action | self addLocalShortcut: aShortcut for: action in: class]]
	
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:56'
}
AActions class >> addLocalShortcut: aShortcut for: anAction in: aClass [
	|shortcutDict isResetConfirmed duplicateKey|
	
	shortcutDict := Shortcuts at: aClass ifAbsentPut: [Dictionary new].
	duplicateKey := (self duplicateOf: aShortcut in: shortcutDict).
	
	(duplicateKey notNil)
			ifTrue: [isResetConfirmed := (PopUpMenu confirm: 
				'The Key combination you are about to assign is already used. Do you want to override: ', 
				(shortcutDict at: duplicateKey), ' ?').
				isResetConfirmed 
					ifTrue:[^ shortcutDict at: duplicateKey put: anAction]
					ifFalse:[^shortcutDict ]].

	^ shortcutDict at: aShortcut put: anAction
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 16:16'
}
AActions class >> addShortcut: aShortcut for: anAction in: aClass [
	
	(anAction isGlobal)
		ifTrue:[self addGlobalShortcut: aShortcut for: anAction]
		ifFalse:[^self addLocalShortcut: aShortcut for: anAction in: aClass]
	
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
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 16:34'
}
AActions class >> classesProviding: anAction [

	|classActionDict|
	
	classActionDict := Dictionary new.
	self classesWithActions do: [:class | (self actionsFor: class) do: [:action | action title = anAction title ifTrue: [
				classActionDict at: class ifPresent: [:actionList | actionList add: action] ifAbsentPut: [{action}]]]].
	
	^classActionDict
	
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:54'
}
AActions class >> classesWith: anAction at: anEventKey [

	^ Shortcuts keys select: [:class | (Shortcuts at: class) at: anEventKey ifPresent: [:action | action title = anAction title]]

	

	
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
	#'squeak_changestamp' : 'wb 6/22/2022 14:04'
}
AActions class >> duplicateOf: aShortcut in: aDict [
	|hashdict keys|
	hashdict := Dictionary new.
	keys := aDict keys.
	
	"check if keystring already exisists in aDict"
	keys do: [:key | (key keyString = aShortcut keyString)

	ifTrue: [^key]].
	^nil
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
	#category : #accessing,
	#'squeak_changestamp' : 'wb 6/16/2022 10:15'
}
AActions class >> hasAnyPragmas: method [
	|hasPragmas pragmas|
	hasPragmas := false.
	pragmas := self pragmaKeywords.
	pragmas do: [:pragma | (method hasPragma: pragma) ifTrue:[hasPragmas := true.]].
	^hasPragmas
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
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:37'
}
AActions class >> removeGlobalShortcut: anEventKey of: anAction [

	(self classesWith: anAction at: anEventKey) do: [:class | self removeLocalShortcut: anEventKey in: class]

	

	
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:27'
}
AActions class >> removeLocalShortcut: anEventKey in: aClass [

	(Shortcuts at: aClass) removeKey: anEventKey
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:33'
}
AActions class >> removeShortcut: anEventKey in: aClass [

	|action|
	
	action := (Shortcuts at: aClass) at: anEventKey.
	
	(action isGlobal) 
		ifTrue: [self removeGlobalShortcut: anEventKey of: action] 
		ifFalse: [self removeLocalShortcut: anEventKey in: aClass]


	
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:24'
}
AActions class >> removeShortcuts [

	Shortcuts := Dictionary new.
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:24'
}
AActions class >> removeShortcutsFor: aClass [

	(Shortcuts at: aClass) keysDo: [:shortcut | self removeShortcut: shortcut in: aClass]
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
	#'squeak_changestamp' : 'KK 6/27/2022 16:29'
}
AActions class >> shortcutFor: anObject event: evt [

	| classes |
	evt isKeyboard
		ifFalse: [^ false].
	

	classes := anObject class withAllSuperclasses.
	classes do: [:class | 
		Shortcuts 
		at: class
		ifPresent: [:actionsDict | actionsDict 
							at: evt
							ifPresent: [:association | association value for: anObject at: evt position. ^ true]]].
					
	^ false
	
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 7/19/2022 17:48'
}
AActions class >> valueFrom: aCompiledMethod [

	^ aCompiledMethod valueWithReceiver: aCompiledMethod methodClass theNonMetaClass arguments: {}
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
