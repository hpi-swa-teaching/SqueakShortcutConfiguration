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
	#category : #uniqueInstanceAccessing,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:06'
}
SSC_API class >> actionsForClassNamed: aSymbol [
	^ self uniqueInstance actionsForClassNamed: aSymbol
]

{
	#category : #default,
	#'squeak_changestamp' : 'MZ 6/19/2024 11:35'
}
SSC_API class >> actionsGetterMethodName [
	"The name of the class method that the scan method will look for"
	
	^ #SSCActions
]

{
	#category : #default,
	#'squeak_changestamp' : 'MZ 6/19/2024 12:15'
}
SSC_API class >> actionsSetterMethodName [
	^ #SSCActions:
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
	#category : #default,
	#'squeak_changestamp' : 'MZ 6/19/2024 11:35'
}
SSC_API class >> defaultActionsGetterMethodName [
	"The name of the class method that returns the default actions"
	
	^ #defaultSSCActions
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
	#'squeak_changestamp' : 'MZ 6/19/2024 11:35'
}
SSC_API >> actionsForClassNamed: aSymbol [
	| class |
	class := Smalltalk classNamed: aSymbol.
	class ifNil: [^ {} asSet].
	(class class canUnderstand: self class actionsGetterMethodName) ifFalse: [^ {} asSet].
	^ (class perform: self class actionsGetterMethodName) asSet
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/24/2024 09:10'
}
SSC_API >> addAction: anAction forClass: aClass [
	|newActions|
	newActions := (self sscActionsOfClass: aClass).
	newActions add: anAction.
	self setSSCActionsOfClass: aClass to: newActions.
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
	#category : #helpers,
	#'squeak_changestamp' : 'MZ 6/19/2024 11:44'
}
SSC_API >> defaultSSCActionsOfClass: aClass [
	^ aClass perform: (SSC_API defaultActionsGetterMethodName)
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'MZ 6/19/2024 12:12'
}
SSC_API >> initialize [
	super initialize.
	configurableClasses := {} asDictionary.
	
	self addSystemChangeListener: #onSystemChangeAdded: for: #Added.
	self addSystemChangeListener: #onSystemChangeRemoved: for: #Removed.
	self addSystemChangeListener: #onSystemChangeModified: for: #Modified.
		
	self scan.
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'MZ 6/19/2024 11:36'
}
SSC_API >> isActionGetterMethod: aCompiledMethod [
	^ (aCompiledMethod selector = SSC_API actionsGetterMethodName) and: (aCompiledMethod methodClass isKindOf: Metaclass)
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'MZ 6/19/2024 11:37'
}
SSC_API >> isActionSetterMethod: aCompiledMethod [
	^ (aCompiledMethod selector = SSC_API actionsSetterMethodName) and: (aCompiledMethod methodClass isKindOf: Metaclass)
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'MZ 6/19/2024 11:37'
}
SSC_API >> isDefaultActionGetterMethod: aCompiledMethod [
	^ (aCompiledMethod selector = SSC_API defaultActionsGetterMethodName) and: (aCompiledMethod methodClass isKindOf: Metaclass)
]

{
	#category : #events,
	#'squeak_changestamp' : 'MZ 6/19/2024 11:36'
}
SSC_API >> onSystemChangeAdded: anEvent [
	(self isActionGetterMethod: anEvent item) ifTrue: [
		self addActionProvider: anEvent item.
	].
]

{
	#category : #events,
	#'squeak_changestamp' : 'MZ 6/19/2024 12:26'
}
SSC_API >> onSystemChangeModified: anEvent [
	(self isDefaultActionGetterMethod: anEvent item) ifTrue: [ | methodClass|
		methodClass := anEvent item methodClass instanceSide.
		self setSSCActionsOfClass: methodClass to: (self defaultSSCActionsOfClass: methodClass)].
]

{
	#category : #events,
	#'squeak_changestamp' : 'MZ 6/19/2024 11:36'
}
SSC_API >> onSystemChangeRemoved: anEvent [
	(self isActionGetterMethod: anEvent item) ifTrue: [
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
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/19/2024 19:16'
}
SSC_API >> removeAction: anAction fromClass: aClass [
	|actions|
	actions := (self sscActionsOfClass: aClass) reject: [:a | a = anAction].
	self setSSCActionsOfClass: aClass to: actions
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:22'
}
SSC_API >> removeActionProvider: aCompiledMethod [
	configurableClasses remove: aCompiledMethod methodClass instanceSide.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/24/2024 09:07'
}
SSC_API >> replaceAction: anAction with: newAction for: aClass [
	|newActions|
	newActions := (self sscActionsOfClass: aClass) reject: [:a | a = anAction].
	newActions add: newAction.
	self setSSCActionsOfClass: aClass to: newActions
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 7/2/2024 19:39'
}
SSC_API >> resetClass: aClass [
	(aClass respondsTo: SSC_API defaultActionsGetterMethodName) ifTrue: [ self setSSCActionsOfClass: aClass to: (self defaultSSCActionsOfClass: aClass) ]
]

{
	#category : #'action-providers',
	#'squeak_changestamp' : 'MZ 6/19/2024 11:36'
}
SSC_API >> scan [
	configurableClasses := {} asSet.
	Smalltalk allClassesDo: [:aClass |
		aClass class methodsDo: [:aMethod |
			(self isActionGetterMethod: aMethod) ifTrue: [self addActionProvider: aMethod].
		]
	].
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MZ 6/23/2024 23:10'
}
SSC_API >> setSSCActionsOfClass: aClass to: aCollection [
	aClass perform: (SSC_API actionsSetterMethodName) with: aCollection
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MZ 6/24/2024 09:10'
}
SSC_API >> sscActionsOfClass: aClass [
	^ (aClass perform: (SSC_API actionsGetterMethodName)) asSet
]
