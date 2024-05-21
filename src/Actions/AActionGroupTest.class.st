Class {
	#name : #AActionGroupTest,
	#superclass : #ActionsTest,
	#category : #'Actions-Test'
}

{
	#category : #representation,
	#'squeak_changestamp' : 'wb 8/5/2022 18:06'
}
AActionGroupTest >> testAsTreeNode [

	| treeNode actions actionGroup|
	
	actions:= AMockActionsMoveUpDuplicate actions.
	actionGroup:= AActionGroup new.
	actionGroup actions: actions.
	treeNode:= actionGroup asTreeNode.
	
	self assert: treeNode value equals: actionGroup.
	self assert: (treeNode children first) value equals: actions first.
	self assert: (treeNode children second) value equals: actions second
	
]

{
	#category : #representation,
	#'squeak_changestamp' : 'wb 8/5/2022 17:55'
}
AActionGroupTest >> testNameGroup [

	| actionsRepresentation group |
	
	actionsRepresentation:= OrderedCollection new.
	actionsRepresentation add: (AMockActions mockActionMoveUpAsList).
	group:= AActionGroup named: #test from: actionsRepresentation.
	
	self assert: group title equals: #test.
	self assert: group actions first equals: AMockActions moveUpAction
]
