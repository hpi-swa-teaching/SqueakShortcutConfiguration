"
Collect Actions that belong to the same class
"
Class {
	#name : #AActionGroup,
	#superclass : #AActionDescription,
	#instVars : [
		'actions'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 10:08'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/20/2020 14:02'
}
AActionGroup class >> named: aSymbol [

	^ self new
		title: aSymbol;
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/21/2020 12:04'
}
AActionGroup class >> named: aSymbol from: anArray [
	| group |
	group := self new
		title: aSymbol;
		yourself.
		
	anArray do: [:each | group addAction: (AAction from: each)].
	^ group
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/20/2020 14:02'
}
AActionGroup >> actions [

	^ actions
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/20/2020 14:02'
}
AActionGroup >> actions: anObject [

	actions := anObject.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/20/2020 14:05'
}
AActionGroup >> addAction: anAction [

	self actions add: anAction
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/15/2020 00:02'
}
AActionGroup >> asTreeNode [

	| treeNode |
	treeNode := ATreeNode value: self.
	treeNode children: (self actions collect: [:each | each asTreeNode]).
	^ treeNode
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/28/2020 12:03'
}
AActionGroup >> clazz: aClass [

	super clazz: aClass.
	self actions do: [:each | each clazz: aClass]

	
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'WoC 9/20/2020 14:02'
}
AActionGroup >> initialize [

	self actions: OrderedCollection new
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 10/14/2020 23:10'
}
AActionGroup >> isActionGroup [

	^ true
]

{
	#category : #'write representation',
	#'squeak_changestamp' : 'WoC 10/8/2020 14:08'
}
AActionGroup >> writeListRepresentationOn: aCollection [

	self actions do: [:each | each writeListRepresentationOn: aCollection]
]

{
	#category : #'write representation',
	#'squeak_changestamp' : 'WoC 9/29/2020 12:12'
}
AActionGroup >> writeTreeRepresentationInto: aTreeNode [

	| node |
	node := ATreeNode value: self.
	aTreeNode addChild: node.
	self actions collect: [:each | each writeTreeRepresentationInto: node]
]
