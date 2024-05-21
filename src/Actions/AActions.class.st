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
	#'squeak_changestamp' : 'KK 8/4/2022 18:44'
}
AActions class >> actionPragmasFor: aClass [

	^ self actionPragmas
			at: aClass
			ifAbsent: [OrderedCollection new]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 8/4/2022 18:44'
}
AActions class >> actionsFor: aClass [

	^ (((self actionPragmasFor: aClass) 
			collect: [:each | each method])
			collect: [:method | self actionsFrom: method For: aClass])
			flatten
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 7/28/2022 11:33'
}
AActions class >> actionsFrom: aCompiledMethod For: aClass [

	^ ((self valueFrom: aCompiledMethod)
			select: [:each | self testIfIsAction: each])
			do: [:action | action clazz: aClass]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 7/28/2022 11:41'
}
AActions class >> actionsWithDefaultShortcutFor: aClass [

	^ (self actionsFor: aClass)
			select: [:action | action hasDefaultShortcut]
			
	
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 7/28/2022 11:56'
}
AActions class >> activateDefaultShortcuts [

	self classesWithActions do: [:class | self activateDefaultShortcutsFor: class]
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 7/28/2022 11:44'
}
AActions class >> activateDefaultShortcutsFor: aClass [

	(self actionsWithDefaultShortcutFor: aClass) do: 
		[:action | self addShortcut: action defaultShortcut for: action in: aClass]	
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 7/28/2022 12:07'
}
AActions class >> activateGlobalDefaultShortcutsFor: aClass [

	((self actionsWithDefaultShortcutFor: aClass) 
		select: [:action | action isGlobal])
		do: [:globalAction | self addShortcut: globalAction defaultShortcut for: globalAction in: aClass]

	
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 7/28/2022 11:46'
}
AActions class >> activateLocalDefaultShortcutsFor: aClass [

	((self actionsWithDefaultShortcutFor: aClass) 
		select: [:action | action isGlobal not])
		do: [:action | self addShortcut: action defaultShortcut for: action in: aClass]
	
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:53'
}
AActions class >> addGlobalShortcut: aShortcut for: anAction [

	(self classesProviding: anAction) keysAndValuesDo: [:class :actions | actions do: 
		[:action | self addLocalShortcut: aShortcut for: action in: class]]
	
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'KK 8/4/2022 10:08'
}
AActions class >> addLocalShortcut: aShortcut for: anAction in: aClass [

	| shortcutDict |
	
	shortcutDict := Shortcuts at: aClass ifAbsentPut: [Dictionary new].
	
	(self overwritePotentialDuplicate: anAction at: aShortcut for: aClass)
		ifTrue: [^ shortcutDict at: aShortcut put: anAction]
		ifFalse: [^ shortcutDict]

	
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
	#'squeak_changestamp' : 'MaCl 8/4/2022 18:40'
}
AActions class >> allActionMethods [

	| methods |
	
	methods := OrderedCollection new.
	Smalltalk allClassesDo: [:aClass | aClass class methodsDo: [:method | (self recognizes: method)
				ifTrue: [methods add: method]]].
	^ methods
]

{
	#category : #'handle shortcuts',
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
	#'squeak_changestamp' : 'MaCl 8/4/2022 18:41'
}
AActions class >> classesProviding: anAction [

	|classActionDict|
	
	classActionDict := Dictionary new.
	self classesWithActions do: [:class | (self actionsFor: class) do: [:action | action title = anAction title 		ifTrue: [classActionDict at: class ifPresent: [:actionList | actionList add: action] ifAbsentPut: 			[OrderedCollection new add: action; yourself]]]].
	
	^classActionDict
	
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:54'
}
AActions class >> classesWith: anAction at: anEventKey [

	^ Shortcuts keys select: [:class | (Shortcuts at: class) at: anEventKey ifPresent: 
		[:action | action title = anAction title] ifAbsent: [false]]

	

	
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
	#category : #accessing,
	#'squeak_changestamp' : 'MaCl 8/4/2022 18:42'
}
AActions class >> duplicateOf: aShortcut in: aDict [

	| keys |
	
	keys := aDict keys.
	"check if keystring already exisists in aDict"
	keys do: [:key | (key keyString = aShortcut keyString) ifTrue: [^key]].
	^nil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 8/4/2022 10:29'
}
AActions class >> hasAnyActionPragmas: method [

	| hasPragmas |
	hasPragmas := false.
	self pragmaKeywords do: 
		[:pragma | (method hasPragma: pragma) ifTrue:[hasPragmas := true.]].
	
	^hasPragmas
]

{
	#category : #'initialize-release',
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
	#category : #'handle menus',
	#'squeak_changestamp' : 'WoC 9/30/2020 03:07'
}
AActions class >> menuStructureFor: aClass [

	^ Menus at: aClass ifAbsent: [ATreeNode new]
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MaCl 8/4/2022 14:41'
}
AActions class >> overwritePotentialDuplicate: anAction at: aKey for: aClass [
	
	| isResetConfirmed duplicateKey duplicateAction |
	
	duplicateKey := self duplicateOf: aKey in: (Shortcuts at: aClass).
	duplicateAction := (Shortcuts at: aClass) at: duplicateKey ifAbsent: [nil]. 
	isResetConfirmed := false.
	
	(duplicateKey notNil and: duplicateAction ~= anAction) 
			ifTrue: [isResetConfirmed := PopUpMenu confirm: 
				'The Key combination you are about to assign is already used. Do you want to override: ', 
					duplicateAction, ' ?']
			ifFalse: [^ true].

	isResetConfirmed 
		ifTrue: [self removeShortcut: duplicateKey in: aClass. ^ true]
		ifFalse: [^ false]
	
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
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'KK 8/4/2022 18:55'
}
AActions class >> removeGlobalShortcutsFor: aClass [

	(Shortcuts at: aClass ifAbsent: [Dictionary new]) keys do: [:shortcut |((Shortcuts at: aClass) at: shortcut) isGlobal ifTrue: 
		[self removeShortcut: shortcut in: aClass]]
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:27'
}
AActions class >> removeLocalShortcut: anEventKey in: aClass [

	(Shortcuts at: aClass) removeKey: anEventKey
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'MaCl 8/4/2022 16:54'
}
AActions class >> removeLocalShortcutsFor: aClass [

	(Shortcuts at: aClass) keys do: [:shortcut |((Shortcuts at: aClass) at: shortcut) isGlobal ifFalse: 		[self removeShortcut: shortcut in: aClass]]
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'MaCl 8/4/2022 18:43'
}
AActions class >> removeShortcut: anEventKey in: aClass [

	|action|
	
	action := (Shortcuts at: aClass) at: anEventKey.
	
	(action isGlobal) ifTrue: [self removeGlobalShortcut: anEventKey of: action] 
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
	#'squeak_changestamp' : 'KK 8/4/2022 18:08'
}
AActions class >> removeShortcutsFor: aClass [

	(Shortcuts at: aClass ifAbsent: [Dictionary new]) keysDo: [:shortcut | self removeShortcut: shortcut in: aClass]
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
	#'squeak_changestamp' : 'TA 8/4/2022 17:34'
}
AActions class >> resetGlobalDefaultShortcutsFor: aClass [
	
	self removeGlobalShortcutsFor: aClass.
	self activateGlobalDefaultShortcutsFor: aClass
]

{
	#category : #'default shortcuts',
	#'squeak_changestamp' : 'MaCl 7/14/2022 14:20'
}
AActions class >> resetLocalDefaultShortcutsFor: aClass [
	
	self removeLocalShortcutsFor: aClass.
	self activateLocalDefaultShortcutsFor: aClass.
]

{
	#category : #'handle selectors',
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
	#category : #'handle selectors',
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
	#'squeak_changestamp' : 'TA 8/4/2022 11:09'
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
	#'squeak_changestamp' : 'TA 8/4/2022 11:09'
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
	#category : #accessing,
	#'squeak_changestamp' : 'KK 7/19/2022 17:48'
}
AActions class >> valueFrom: aCompiledMethod [

	^ aCompiledMethod valueWithReceiver: aCompiledMethod methodClass theNonMetaClass arguments: {}
]
