Class {
	#name : #'SSC_API',
	#superclass : #Object,
	#instVars : [
		'configurableClasses'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:17'
}
SSC_API class >> actionProviderMethodName [
	^ 'sscActions' asSymbol
]

{
	#category : #uniqueInstanceAccessing,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:06'
}
SSC_API class >> actionsForClassNamed: aSymbol [
	^ self uniqueInstance actionsForClassNamed: aSymbol
]

{
	#category : #uniqueInstanceAccessing,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:25'
}
SSC_API class >> classNames [
	^ self uniqueInstance configurableClasses asArray collect: [:aClass | aClass name]
]

{
	#category : #uniqueInstanceAccessing,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:10'
}
SSC_API class >> configurableClasses [
	^ self uniqueInstance configurableClasses
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
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:06'
}
SSC_API >> actionsForClassNamed: aSymbol [
	| class |
	class := Smalltalk classNamed: aSymbol.
	class ifNil: [^ {} asSet].
	(class class canUnderstand: self class actionProviderMethodName) ifFalse: [^ {} asSet].
	^ (class perform: self class actionProviderMethodName) asSet
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:20'
}
SSC_API >> addActionProvider: aCompiledMethod [
	configurableClasses add: (aCompiledMethod methodClass instanceSide).
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
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:23'
}
SSC_API >> configurableClasses [
	^ configurableClasses
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:20'
}
SSC_API >> initialize [
	super initialize.
	configurableClasses := {} asDictionary.
	
	self addSystemChangeListener: #onSystemChangeAdded: for: #Added.
	self addSystemChangeListener: #onSystemChangeRemoved: for: #Removed.
	
	self scan.
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:04'
}
SSC_API >> isActionProvider: aCompiledMethod [
	^ (aCompiledMethod selector = SSC_API actionProviderMethodName) and: (aCompiledMethod methodClass isKindOf: Metaclass)
]

{
	#category : #events,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:04'
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
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:22'
}
SSC_API >> removeActionProvider: aCompiledMethod [
	configurableClasses remove: aCompiledMethod methodClass instanceSide.
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'yl 6/16/2024 15:46'
}
SSC_API >> scan [
	configurableClasses := {} asSet.
	Smalltalk allClassesDo: [:aClass |
		aClass class methodsDo: [:aMethod |
			(self isActionProvider: aMethod) ifTrue: [self addActionProvider: aMethod].
		]
	].
]
