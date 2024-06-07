Class {
	#name : #'SSC_API',
	#superclass : #Object,
	#instVars : [
		'actionProviderDict'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:37'
}
SSC_API class >> actionsForClass: aSymbol [
	^ self uniqueInstance actionsForClass: aSymbol
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:37'
}
SSC_API class >> classNames [
	^ self uniqueInstance configurableClasses collect: [:aClass | aClass name]
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:37'
}
SSC_API class >> reset [
	SystemChangeNotifier release.
	UniqueInstance := self new.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:36'
}
SSC_API class >> uniqueInstance [
	UniqueInstance ifNil: [self reset].
	^ UniqueInstance
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:35'
}
SSC_API >> actionsForClass: aSymbol [
	| class actions |
	class := Smalltalk classNamed: aSymbol.
	actions := {} asBag.
	(actionProviderDict at: (Smalltalk classNamed: aSymbol)) do: [:methodName |
		actions addAll: (class perform: methodName).
	].
	^ actions
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:35'
}
SSC_API >> addActionProvider: aCompiledMethod [
	| class |
	class := aCompiledMethod methodClass instanceSide.
	(actionProviderDict includesKey: class) ifFalse: [actionProviderDict at: class put: {} asSet].
	(actionProviderDict at: class) add: aCompiledMethod selector.
]

{
	#category : #events,
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:36'
}
SSC_API >> addSystemChangeListener: method for: change [
	SystemChangeNotifier uniqueInstance
		notify: self
		ofSystemChangesOfItem: #method
		change: change
		using: method.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:35'
}
SSC_API >> configurableClasses [
	^ actionProviderDict keys
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:36'
}
SSC_API >> initialize [
	super initialize.
	actionProviderDict := {} asDictionary.
	
	self addSystemChangeListener: #onSystemChangeAdded: for: #Added.
	self addSystemChangeListener: #onSystemChangeRemoved: for: #Removed.
	self addSystemChangeListener: #onSystemChangeRenamed: for: #Renamed.
	
	self scan.
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:36'
}
SSC_API >> isActionProvider: aCompiledMethod [
	^ (aCompiledMethod pragmas anySatisfy: [:each | each keyword = #ActionProvider]) and: (aCompiledMethod methodClass isKindOf: Metaclass)
]

{
	#category : #events,
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:36'
}
SSC_API >> onSystemChangeAdded: anEvent [
	(self isActionProvider: anEvent item) ifTrue: [
		self addActionProvider: anEvent item.
	].
]

{
	#category : #events,
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:36'
}
SSC_API >> onSystemChangeRemoved: anEvent [
	(self isActionProvider: anEvent item) ifTrue: [
		self removeActionProvider: anEvent item.
	].
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:36'
}
SSC_API >> release [
	SystemChangeNotifier uniqueInstance noMoreNotificationsFor: self.
	super release.
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:36'
}
SSC_API >> removeActionProvider: aCompiledMethod [
	| class |
	class := aCompiledMethod methodClass instanceSide.
	(actionProviderDict includesKey: class) ifTrue: [
		(actionProviderDict at: class) remove: aCompiledMethod selector.
		((actionProviderDict at: class) size = 0) ifTrue: [actionProviderDict removeKey: class].
	].
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:36'
}
SSC_API >> scan [
	actionProviderDict := {} asDictionary.
	Smalltalk allClassesDo: [:aClass |
		aClass class methodsDo: [:aMethod |
			(self isActionProvider: aMethod) ifTrue: [self addActionProvider: aMethod].
		]
	].
]
