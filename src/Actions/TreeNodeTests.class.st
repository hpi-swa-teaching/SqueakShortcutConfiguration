Class {
	#name : #TreeNodeTests,
	#superclass : #ActionsTest,
	#category : #'Actions-Test'
}

{
	#category : #representation,
	#'squeak_changestamp' : 'wb 8/5/2022 18:19'
}
TreeNodeTests >> testActionTreeNodeAsString [

	| treeNode action|
	
	action:= AMockActionsMethodWithoutPragma actionOne.
	treeNode:= ATreeNode value: action.
	self assert: (treeNode asString) equals: action title

	
]

{
	#category : #operations,
	#'squeak_changestamp' : 'TA 8/4/2022 14:56'
}
TreeNodeTests >> testAddRemoveNodes [

	|root child1 child2 child3|
	
	root := ATreeNode seperator.
	self assert: root isSeperator.
	self assert:  root description isNil.
	
	child1 := ATreeNode value: 1.
	child2 := ATreeNode value: 2.
	child3 := ATreeNode value: 3.
	
	root addChild: child1.
	self assert: root hasChildren.
	self assert: (root children includes: child1).
	root addChild: child2.
	root addChild: child3 after: child1.
	self assert: ((root children at: 2) == child3).
	
	root removeChild: child1.
	self assert: (root children includes: child1) not.
	self assert: ((root followPath: root children) == child2).
	


]

{
	#category : #structure,
	#'squeak_changestamp' : 'wb 8/5/2022 17:56'
}
TreeNodeTests >> testMenuTree [
	|tree menu actionNode actionGroupNode|
	
	tree := ATreeNode seperator.
	actionNode := ATreeNode value: (AAction from: AMockActions mockActionMoveUpAsList).
	actionGroupNode := ATreeNode value: ((AActionGroup named: #TestGroup) addAction: (AAction from: AMockActions mockActionMoveDownAsList)).
	menu := MenuMorph new.
	tree addChild: actionNode.
	tree addChild: actionGroupNode.
	
	tree fill: menu for: AMenuBrowser new.
	self assert: menu submorphs first contents = 'Move Up Test'.
	self assert: menu submorphs second contents = #TestGroup.
	
	

	
	
	
	
	



]

{
	#category : #representation,
	#'squeak_changestamp' : 'TA 8/4/2022 14:44'
}
TreeNodeTests >> testNilValueTreeNodeAsString [

	| treeNode raiseException |
	
	raiseException:= false.
	treeNode:= ATreeNode value: nil.
	[treeNode asString]
		on: MessageNotUnderstood
		do: [:error | raiseException:= true].
	self assert: raiseException equals: true.
	
]

{
	#category : #representation,
	#'squeak_changestamp' : 'TA 8/4/2022 14:55'
}
TreeNodeTests >> testSeperatorTreeNodeAsString [

	| treeNode |
	
	treeNode:= ATreeNode seperator.
	self assert: (treeNode asString) equals: #-------------

	
]
