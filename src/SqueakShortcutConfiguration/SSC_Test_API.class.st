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
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:25'
}
SSC_Test_API >> actionProviderFormat [
	^
'{1}
	<ActionProvider>
	{3}
	^ {2}'
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:37'
}
SSC_Test_API >> addActionProvider1 [
	self addActionProvider: self nameActionProvider1 actions: {'Action 1s Title'. 'Action 2s Title'}
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:37'
}
SSC_Test_API >> addActionProvider2 [
	self addActionProvider: self nameActionProvider2 actions: {'Action 3s Title'. 'Action 4s Title'}
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:29'
}
SSC_Test_API >> addActionProvider: name actions: stringCollection [
	test_class class compile: (self codeForActionProvider: name withActionTitles: stringCollection)
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
	#'squeak_changestamp' : 'JPVS 6/6/2024 14:52'
}
SSC_Test_API >> classCreationName [
	^ #'SSC_Test_API_Test_Class'
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
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:35'
}
SSC_Test_API >> executeActionProvider1 [
	^ test_class perform: self nameActionProvider1 asSymbol
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:34'
}
SSC_Test_API >> executeActionProvider2 [
	^ test_class perform: self nameActionProvider2 asSymbol
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:33'
}
SSC_Test_API >> nameActionProvider1 [
	^ 'actions1'
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:33'
}
SSC_Test_API >> nameActionProvider2 [
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
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:33'
}
SSC_Test_API >> removeActionProvider1 [
	self removeMethod: self nameActionProvider1
]

{
	#category : #'test-class-interaction',
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:33'
}
SSC_Test_API >> removeActionProvider2 [
	self removeMethod: self nameActionProvider2
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
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:01'
}
SSC_Test_API >> renameActionProvider1to2 [
	| refactoring |
	refactoring := RBRenameMethodRefactoring renameMethod: self nameActionProvider1 asSymbol in: test_class class to: self nameActionProvider2 asSymbol permutation: (1 to: self nameActionProvider1 asSymbol numArgs).
	refactoring execute.
]

{
	#category : #'setup-teardown',
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:04'
}
SSC_Test_API >> setUp [
	super setUp.
	SSC_API reset.
	self assert: (Smalltalk allClasses includes: (Smalltalk classNamed: self classCreationName)) not.
	
	test_class := Object 
		subclass: self classCreationName
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: self classCreationCategory.
]

{
	#category : #'setup-teardown',
	#'squeak_changestamp' : 'JPVS 6/6/2024 14:53'
}
SSC_Test_API >> tearDown [
	super tearDown.
	
	Smalltalk removeClassNamed: self classCreationName.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:44'
}
SSC_Test_API >> testAdding [
	self addActionProvider1.
	self assert: (SSC_API actionsForClass: self classCreationName) asSet equals: self executeActionProvider1 asSet.
	self assert: (SSC_API uniqueInstance configurableClasses includes: test_class ).
	self addActionProvider2.
	self assert: (SSC_API actionsForClass: self classCreationName) asSet
		equals: (self executeActionProvider1 asSet addAll: self executeActionProvider2; yourself).
	self removeActionProvider1.
	self removeActionProvider2.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'JPVS 6/7/2024 13:45'
}
SSC_Test_API >> testRemoving [
	self addActionProvider2.
	self addActionProvider1.
	self removeActionProvider2.
	self assert: (SSC_API actionsForClass: self classCreationName) asSet equals: self executeActionProvider1 asSet.
	self removeActionProvider1.
	self deny: (SSC_API uniqueInstance configurableClasses includes: test_class ).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'JPVS 6/7/2024 14:05'
}
SSC_Test_API >> testRenaming [
	self addActionProvider1.
	self renameActionProvider1to2.
	self assert: (SSC_API actionsForClass: self classCreationName) asSet equals: self executeActionProvider2 asSet.
	self removeActionProvider2.
	self deny: (SSC_API uniqueInstance configurableClasses includes: test_class ).
]
