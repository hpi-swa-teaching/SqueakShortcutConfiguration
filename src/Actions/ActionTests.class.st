Class {
	#name : #ActionTests,
	#superclass : #ActionsTest,
	#category : #'Actions-Test'
}

{
	#category : #running,
	#'squeak_changestamp' : 'TA 7/28/2022 12:31'
}
ActionTests >> tearDown [

	ATestAActions reset
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:07'
}
ActionTests >> testActionShortcuts [
	
	| action | 
	
	action := AMockActions moveUpAction clazz: AMockActionsMoveUpDuplicate; yourself.
	
	ATestAActions 
		addShortcut: self shortcutCtrlb for: action in: AMockActionsMoveUpDuplicate;
		addShortcut: self shortcutCtrld for: action in: AMockActionsMoveUpDuplicate.
	
	self assert: action shortcuts first equals: self shortcutCtrlb.
	self assert: action shortcuts second equals: self shortcutCtrld
	
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:18'
}
ActionTests >> testActionWithShortcutRepresentation [

	| action |
	
	action := (AMockActionsMethodWithoutPragma actions first).
	ATestAActions addShortcut: self shortcutCtrlb for: action in: AMockActionsMethodWithoutPragma.
	action clazz: AMockActionsMethodWithoutPragma.
	Transcript show: (action shortcutRepresentation).
	self assert: action shortcutRepresentation equals: '(<Cmd-b>)'.
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:08'
}
ActionTests >> testActionWithShortcuts [
	
	| action | 
	
	action := AMockActions moveUpAction clazz: AMockActionsMoveUpDuplicate; yourself.
	
	ATestAActions 
		addShortcut: self shortcutCtrlb for: action in: AMockActionsMoveUpDuplicate;
		addShortcut: self shortcutCtrld for: action in: AMockActionsMoveUpDuplicate.
	
	self assert: action shortcuts first equals: self shortcutCtrlb.
	self assert: action shortcuts second equals: self shortcutCtrld.
	self assert: action hasShortcuts
	
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:19'
}
ActionTests >> testActionWithoutShortcutRepresentation [

	| action |
	
	action := (AMockActionsMethodWithoutPragma actions first).
	self assert: action shortcutRepresentation equals: ''.
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:08'
}
ActionTests >> testActionWithoutShortcuts [
	
	| action | 
	
	action := AMockActions moveUpAction clazz: AMockActionsMoveUpDuplicate; yourself.
	
	self assert: action hasShortcuts equals: false
	
]

{
	#category : #'global actions',
	#'squeak_changestamp' : 'wb 8/5/2022 18:04'
}
ActionTests >> testDefaultActionSelectorForGlobalAction [

	self assert: AMockGlobalRemoveActions globalRemoveAction action equals: #remove
]

{
	#category : #'global actions',
	#'squeak_changestamp' : 'wb 8/5/2022 18:05'
}
ActionTests >> testOverwriteActionSelectorForGlobalAction [

	self assert: AMockGlobalRemoveSpecialActions globalRemoveAction action equals: #removeSpecial
]

{
	#category : #'tree node',
	#'squeak_changestamp' : 'wb 8/5/2022 18:19'
}
ActionTests >> testWriteTreeRepresentationIntoATreeNode [

	| action treenode |
	
	treenode := ATreeNode new.
	action := AMockActionsMethodWithoutPragma actions first.
	action writeTreeRepresentationInto: treenode.
	
	self assert: (treenode children contains: [:each | each value = action])
	

]
