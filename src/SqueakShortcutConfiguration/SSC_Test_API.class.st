Class {
	#name : #'SSC_Test_API',
	#superclass : #TestCase,
	#instVars : [
		'test_class'
	],
	#category : #'SqueakShortcutConfiguration-Tests'
}

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:05'
}
SSC_Test_API >> actionProviderFormat [
	^
'{1}
	{3}
	^ {2}'
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:05'
}
SSC_Test_API >> addActionProvider [
	self addActionProvider: self nameActionProvider actions: {'Action 1s Title'. 'Action 2s Title'}
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:29'
}
SSC_Test_API >> addActionProvider: name actions: stringCollection [
	test_class class compile: (self codeForActionProvider: name withActionTitles: stringCollection)
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:05'
}
SSC_Test_API >> addActionProviderWrong [
	self addActionProvider: self nameActionProviderWrong actions: {'Action 3s Title'. 'Action 4s Title'}
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/6/2024 14:52'
}
SSC_Test_API >> classCreationCategory [
	^ #'SqueakShortcutConfiguration-Tests'
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:42'
}
SSC_Test_API >> classCreationNameOriginal [
	^ 'SSC_Test_API_Test_Class_1' asSymbol
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:44'
}
SSC_Test_API >> classCreationNameOther [
	^ 'SSC_Test_API_Test_Class_2' asSymbol
]

{
	#category : #'code-generation',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:28'
}
SSC_Test_API >> codeForActionProvider: name withActionTitles: stringCollection [
	^ self actionProviderFormat
		format: {name. self codeForArray: (stringCollection collect: [:each | self codeForNewActionWithTitle: each]). ''}
]

{
	#category : #'code-generation',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:37'
}
SSC_Test_API >> codeForArray: stringCollection [
	^ '{', (stringCollection joinSeparatedBy: '. '), '}'
]

{
	#category : #'code-generation',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:25'
}
SSC_Test_API >> codeForNewActionWithTitle: aString [
	^ self newActionFormat format: {aString}
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:06'
}
SSC_Test_API >> executeActionProvider [
	^ test_class perform: self nameActionProvider asSymbol
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:06'
}
SSC_Test_API >> executeActionProviderWrong [
	^ test_class perform: self nameActionProviderWrong asSymbol
]

{
	#category : #default,
	#'squeak_changestamp' : 'MZ 6/19/2024 11:35'
}
SSC_Test_API >> nameActionProvider [
	^ SSC_API actionsGetterMethodName
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:05'
}
SSC_Test_API >> nameActionProviderWrong [
	^ 'actions2'
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:20'
}
SSC_Test_API >> newActionFormat [
	^ 'SSC_Action new title: ''{1}'''
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:06'
}
SSC_Test_API >> removeActionProvider [
	self removeMethod: self nameActionProvider
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:07'
}
SSC_Test_API >> removeActionProviderWrong [
	self removeMethod: self nameActionProviderWrong
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:32'
}
SSC_Test_API >> removeMethod: aString [
	test_class class removeSelector: aString asSymbol.
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:14'
}
SSC_Test_API >> renameActionProviderToWrong [
	(RBRenameMethodRefactoring
		renameMethod: self nameActionProvider
		in: test_class class
		to: self nameActionProviderWrong
		permutation: (1 to: self nameActionProvider numArgs)
	) execute.
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:37'
}
SSC_Test_API >> setClassNameOriginal: aBool [
	| newName |
	aBool ifTrue: [newName := self classCreationNameOriginal]; ifFalse: [newName := self classCreationNameOther].
	(RBRenameClassRefactoring rename: test_class to: newName asString) execute.
	
]

{
	#category : #'setup-teardown',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:46'
}
SSC_Test_API >> setUp [
	super setUp.
	SSC_API reset.
	
	self deny: (Smalltalk allClasses includes: (Smalltalk classNamed: self classCreationNameOriginal)).
	self deny: (Smalltalk allClasses includes: (Smalltalk classNamed: self classCreationNameOther)).
	
	test_class := Object 
		subclass: self classCreationNameOriginal
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: self classCreationCategory.
]

{
	#category : #'setup-teardown',
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:48'
}
SSC_Test_API >> tearDown [
	super tearDown.
	
	Smalltalk removeClassNamed: self classCreationNameOriginal.
	Smalltalk removeClassNamed: self classCreationNameOther.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:06'
}
SSC_Test_API >> testAddingActionProvider [
	self addActionProvider.
	self assert: (SSC_API actionsForClassNamed: self classCreationNameOriginal) asSet equals: self executeActionProvider asSet.
	self assert: (SSC_API uniqueInstance configurableClasses includes: test_class ).
	self removeActionProvider.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:11'
}
SSC_Test_API >> testAddingActionProviderWrong [
	self addActionProviderWrong.
	self deny: (SSC_API uniqueInstance configurableClasses includes: test_class ).
	self removeActionProviderWrong.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'JPVS 6/14/2024 12:10'
}
SSC_Test_API >> testRemovingActionProvider [
	self addActionProvider.
	self removeActionProvider.
	self deny: (SSC_API uniqueInstance configurableClasses includes: test_class ).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:06'
}
SSC_Test_API >> testRenamingClass [
	self addActionProvider.
	self setClassNameOriginal: false.
	self assert: (SSC_API actionsForClassNamed: self classCreationNameOriginal) asSet equals: {} asSet.
	self assert: (SSC_API actionsForClassNamed: self classCreationNameOther) asSet equals: self executeActionProvider asSet.
	self setClassNameOriginal: true.
	self removeActionProvider.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:11'
}
SSC_Test_API >> testRenamingMethod [
	self addActionProvider.
	self renameActionProviderToWrong.
	self assert: (SSC_API actionsForClassNamed: test_class name) asSet equals: {} asSet.
	self removeActionProviderWrong.
]
