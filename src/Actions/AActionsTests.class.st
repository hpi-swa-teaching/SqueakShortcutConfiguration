Class {
	#name : #AActionsTests,
	#superclass : #ActionsTest,
	#instVars : [
		'wasShortcutTriggered'
	],
	#category : #'Actions-Test'
}

{
	#category : #history,
	#'squeak_changestamp' : 'wb 6/22/2022 16:45'
}
AActionsTests class >> lastStoredRun [
	^ ((Dictionary new) add: (#duration->23); add: (#errors->((Set new) add: #testCheckForExistingDuplicateActions; add: #testCheckForNonExistingDuplicateActions; add: #testSelectorsWithAnActionDefinedForAClass; add: #testAddAndResetShortcut; yourself)); add: (#passed->((Set new) add: #testAddAndRemoveShortcut; add: #testSelectorsWithActionsDefinedForAClass; yourself)); add: (#failures->((Set new))); add: (#timeStamp->'22 June 2022 4:16:35.86868 pm' asTimeStamp); add: (#durations->((Dictionary new) add: (#testCheckForNonExistingDuplicateActions->nil); add: (#testSelectorsWithActionsDefinedForAClass->21); add: (#testAddAndResetShortcut->nil); add: (#testSelectorsWithAnActionDefinedForAClass->nil); add: (#testAddAndRemoveShortcut->2); add: (#testCheckForExistingDuplicateActions->nil); yourself)); yourself)
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:06'
}
AActionsTests >> addShortcutCtrldForAction [
	| actionA |
	actionA := AMockActions moveUpAction
		clazz: AMockActionsMoveUpDuplicate;
		yourself.
	ATestAActions addShortcut: self shortcutCtrld for: actionA in: AMockActionsMoveUpDuplicate.
	self assert: actionA shortcuts first equals: self shortcutCtrld.
	^ actionA
]

{
	#category : #running,
	#'squeak_changestamp' : 'KK 6/7/2022 10:27'
}
AActionsTests >> setUp [
	
	super setUp.
	
	ATestAActions reset.
	ATestAActions pragmaKeywords: { #wantsDuplicateTestActions }.
]

{
	#category : #shunt,
	#'squeak_changestamp' : 'KK 8/4/2022 11:19'
}
AActionsTests >> shortcutTriggered [

	self wasShortcutTriggered: true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 8/4/2022 11:16'
}
AActionsTests >> shortcutTriggeringAction [

	^ AAction 
			title: 'Trigger test action'
			action: #shortcutTriggered
			description: 'Communicate with AActionsTests and check if action was triggered with shortcut'
]

{
	#category : #classification,
	#'squeak_changestamp' : 'TA 8/4/2022 18:03'
}
AActionsTests >> testActionIsGlobal [

	self assert: AGlobalAction new isGlobal
]

{
	#category : #classification,
	#'squeak_changestamp' : 'TA 8/4/2022 18:01'
}
AActionsTests >> testActionIsNoGlobal [

	self deny: AAction new isGlobal
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:06'
}
AActionsTests >> testAddAndRemoveShortcut [

	| shortcut1 shortcut2 action1 action2 |
	
	shortcut1 := self shortcutCtrlb.
	shortcut2 := self shortcutCtrld.
		
	action1 := AAction from: AMockActionsMoveUpDuplicate mockActionMoveUpAsList.
	action2 := AAction from: AMockActionsMoveUpDuplicate mockActionMoveDownAsList.
	
	ATestAActions addShortcut: shortcut1 for: action1 in: AMockActionsMoveUpDuplicate.
	ATestAActions addShortcut: shortcut2 for: action2 in: AMockActionsMoveUpDuplicate.
	
	self assert: (ATestAActions shortcutsFor: action1 in: AMockActionsMoveUpDuplicate ifAbsent: []) first equals: shortcut1.
	self assert: (ATestAActions shortcutsFor: action2 in: AMockActionsMoveUpDuplicate ifAbsent: []) first equals: shortcut2.
	
	ATestAActions removeShortcut: shortcut1 in: AMockActionsMoveUpDuplicate.
	self assert: (ATestAActions shortcutsFor: action1 in: AMockActionsMoveUpDuplicate ifAbsent: []) equals: nil.
	self assert: (ATestAActions shortcutsFor: action2 in: AMockActionsMoveUpDuplicate ifAbsent: []) first equals: shortcut2.

	ATestAActions removeShortcuts.
	self assert: (ATestAActions shortcutsFor: action1 in: AMockActionsMoveUpDuplicate ifAbsent: []) equals: nil.
	self assert: (ATestAActions shortcutsFor: action2 in: AMockActionsMoveUpDuplicate ifAbsent: []) equals: nil.
		
	

]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:07'
}
AActionsTests >> testAddAndResetShortcut [

	| shortcut1 action1 |
	
	shortcut1 := self shortcutCtrlb.
		
	action1 := AAction from: AMockActionsMoveUpDuplicate mockActionMoveUpAsList.
	
	ATestAActions addShortcut: shortcut1 for: action1 in: AMockActionsMoveUpDuplicate.
	self assert: (ATestAActions shortcutsFor: action1 in: AMockActionsMoveUpDuplicate ifAbsent: []) first equals: shortcut1.
	
	ATestAActions resetLocalDefaultShortcutsFor: AMockActionsMoveUpDuplicate.
	self assert: (ATestAActions shortcutsFor: action1 in: AMockActionsMoveUpDuplicate ifAbsent: []) equals: nil.
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:05'
}
AActionsTests >> testAddGlobalShortcut [

	| globalActionA globalActionB  |
	
	ATestAActions pragmaKeywords: { #wantsTestGlobalActions }.
	globalActionA := AMockGlobalRemoveSpecialActions globalRemoveAction.
	globalActionB := AMockGlobalRemoveActions globalRemoveAction.
	self assert: globalActionA isGlobal.
	self assert: globalActionB isGlobal.
	
	self deny: globalActionA hasShortcuts.
	self deny: globalActionB hasShortcuts.
	
	ATestAActions addShortcut: self shortcutCtrlb for: globalActionA in: AMockGlobalRemoveSpecialActions.
	self assert: globalActionA shortcuts first equals: self shortcutCtrlb.
	self assert: globalActionB shortcuts first equals: self shortcutCtrlb	
	
]

{
	#category : #'duplicate checks',
	#'squeak_changestamp' : 'wb 8/5/2022 18:15'
}
AActionsTests >> testCheckForExistingDuplicateActions [

	| actionTitleA actionTitleB |
	
	"Check for duplicates in same method and check for duplicates in different methods"
	actionTitleA := (AAction from: AMockActionsMoveUpDuplicate mockActionMoveUpAsList) title.
	self assert: (ATestAActions checkIfDuplicatesExistsFor: AMockActionsMoveUpDuplicate) title equals: actionTitleA.
	
	actionTitleB := (AAction from: AMockActionsMoveUp mockActionMoveUpAsList) title.
	self assert: (ATestAActions checkIfDuplicatesExistsFor: AMockActionsMoveUp) title equals: actionTitleB
	

]

{
	#category : #'duplicate checks',
	#'squeak_changestamp' : 'wb 8/5/2022 18:17'
}
AActionsTests >> testCheckForNonExistingDuplicateActions [

	self assert: (ATestAActions checkIfDuplicatesExistsFor: AMockActionsMoveUpToo) equals: nil
	

]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:14'
}
AActionsTests >> testClassesWithAnActionAtAnEventKey [
	
	| classes |
	ATestAActions 
		addShortcut: self shortcutCtrlb for: AMockActions moveUpAction in: AMockActionAddLineAsList  ;
		addShortcut: self shortcutCtrlb for: AMockActions moveUpAction in: AMockActionsMoveUpDuplicate.
	
	classes := ATestAActions classesWith: AMockActions moveUpAction at: self shortcutCtrlb.
	
	self 
		assert: classes size equals: 2;
		assert: classes first equals: AMockActionAddLineAsList;
		assert: classes second equals: AMockActionsMoveUpDuplicate.
	
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:15'
}
AActionsTests >> testClassesWithAnActionAtAnEventKeyForDifferentActions [
	
	| classesA classesB |
	ATestAActions 
		addShortcut: self shortcutCtrlb for: AMockActions moveUpAction in: AMockActionsMoveUpDuplicate;
		addShortcut: self shortcutCtrlb for: AMockActions moveDownAction in: AMockActionsMoveUp.
	
	classesA := ATestAActions classesWith: AMockActions moveUpAction at: self shortcutCtrlb.
	classesB := ATestAActions classesWith: AMockActions moveDownAction at: self shortcutCtrlb.
	
	self 
		assert: classesA size equals: 1;
		assert: classesA first equals: AMockActionsMoveUpDuplicate.
		
	self 
		assert: classesB size equals: 1;
		assert: classesB first equals: AMockActionsMoveUp.
	
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:15'
}
AActionsTests >> testClassesWithAnActionAtAnEventKeyForDifferentShortcuts [
	
	| classesA classesB |
	ATestAActions 
		addShortcut: self shortcutCtrlb for: AMockActions moveUpAction in: AMockActionsMoveUpDuplicate;
		addShortcut: self shortcutCtrld for: AMockActions moveUpAction in: AMockActionsMoveUp.
	
	classesA := ATestAActions classesWith: AMockActions moveUpAction at: self shortcutCtrlb.
	classesB := ATestAActions classesWith: AMockActions moveUpAction at: self shortcutCtrld.
	
	self 
		assert: classesA size equals: 1;
		assert: classesA first equals: AMockActionsMoveUpDuplicate.
		
	self 
		assert: classesB size equals: 1;
		assert: classesB first equals: AMockActionsMoveUp.
	
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'wb 8/5/2022 18:18'
}
AActionsTests >> testHasAnyActionPragmasDoesNotRecognizeFalsePragmas [

	| methodWithoutActionPragmas actionPragma |
	actionPragma := #wantsTestActions.
	
	ATestAActions pragmaKeywords: { actionPragma }.
	methodWithoutActionPragmas := AMockActionsMethodWithoutPragma class methodDict at: #methodWithoutActionPragmas.
	
	self deny: (ATestAActions hasAnyActionPragmas: methodWithoutActionPragmas)
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'wb 8/5/2022 18:18'
}
AActionsTests >> testHasAnyActionPragmasIgnoresMethodsWithoutPragmas [

	| methodWithoutPragmas actionPragma |
	actionPragma := #wantsTestActions.
	
	ATestAActions pragmaKeywords: { actionPragma }.
	methodWithoutPragmas := AMockActionsMethodWithoutPragma class methodDict at: #methodWithoutPragma.
	
	self deny: (ATestAActions hasAnyActionPragmas: methodWithoutPragmas)
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'wb 8/5/2022 18:18'
}
AActionsTests >> testHasAnyActionPragmasRecognizesCorrectPragmas [

	| methodWithActionPragmas actionPragma |
	actionPragma := #wantsTestActions.
	
	ATestAActions pragmaKeywords: { actionPragma }.
	methodWithActionPragmas := AMockActionsMethodWithoutPragma class methodDict at: #actions.
	
	self assert: (ATestAActions hasAnyActionPragmas: methodWithActionPragmas)
]

{
	#category : #classification,
	#'squeak_changestamp' : 'wb 8/5/2022 18:18'
}
AActionsTests >> testIsAction [

	| action |
	
	action:= AMockActionsMethodWithoutPragma actionOne.
	self assert: (ATestAActions testIfIsAction: action)
]

{
	#category : #classification,
	#'squeak_changestamp' : 'TA 8/4/2022 18:07'
}
AActionsTests >> testIsEmptyStringAction [

	self deny: (ATestAActions testIfIsAction: '')
]

{
	#category : #classification,
	#'squeak_changestamp' : 'TA 8/4/2022 18:08'
}
AActionsTests >> testIsNilAction [

	self deny: (ATestAActions testIfIsAction: nil)
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'MaCl 7/28/2022 17:01'
}
AActionsTests >> testNoClassProvidingAnAction [

	self assert: (ATestAActions classesProviding: ATestAAction new) equals: Dictionary new
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'wb 8/5/2022 18:19'
}
AActionsTests >> testOneClassProvidingAnAction [

	self assert: (ATestAActions classesProviding: AMockActionsAddAsList actions first) keys equals: {AMockActionsAddAsList}
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 17:57'
}
AActionsTests >> testRemoveGlobalDefaultShortcutsForDoesNotEffectLocalActions [

	| actionWithADefaultShortcut |
	
	actionWithADefaultShortcut := AMockActions addLineAction clazz: AMockActionAddLineAsList; yourself.
	self assert: actionWithADefaultShortcut hasDefaultShortcut.
	self deny: actionWithADefaultShortcut hasShortcuts.
	
	ATestAActions pragmaKeywords: { #wantsTestDefaultActions }.
	ATestAActions resetDefaultShortcuts.
	ATestAActions removeGlobalShortcutsFor: AMockActionAddLineAsList.
	
	self assert: actionWithADefaultShortcut hasShortcuts.
	self assert: actionWithADefaultShortcut shortcuts first equals: self shortcutCtrlb
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:05'
}
AActionsTests >> testRemoveGlobalShortcut [

	| globalActionA globalActionB  |
	
	ATestAActions pragmaKeywords: { #wantsTestGlobalActions }.
	globalActionA := AMockGlobalRemoveSpecialActions globalRemoveAction.
	globalActionB := AMockGlobalRemoveActions globalRemoveAction.
	
	ATestAActions addShortcut: self shortcutCtrlb for: globalActionA in: AMockGlobalRemoveSpecialActions.
	self assert: globalActionA shortcuts first equals: self shortcutCtrlb.
	self assert: globalActionB shortcuts first equals: self shortcutCtrlb.
	
	ATestAActions removeShortcut: self shortcutCtrlb in: AMockGlobalRemoveSpecialActions.
	self deny: globalActionA hasShortcuts.
	self deny: globalActionB hasShortcuts.
		
	
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:07'
}
AActionsTests >> testRemoveShortcutsForAClassWithShortcuts [

	| actionA |
	actionA := self addShortcutCtrldForAction.
	ATestAActions removeShortcutsFor: AMockActionsMoveUpDuplicate.
	self deny: actionA hasShortcuts
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 18:15'
}
AActionsTests >> testRemoveShortcutsForDifferentClass [

	| actionA |
	actionA := self addShortcutCtrldForAction.
	
	self assert: (actionA shortcuts first) equals: self shortcutCtrld.
	
	ATestAActions removeShortcutsFor: AMockActionsMoveUp.
	self assert: (actionA shortcuts first) equals: self shortcutCtrld
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 17:57'
}
AActionsTests >> testResetDefaultShortcuts [

	| actionWithADefaultShortcut |
	
	actionWithADefaultShortcut := AMockActions addLineAction clazz: AMockActionAddLineAsList; yourself.
	self assert: actionWithADefaultShortcut hasDefaultShortcut.
	self deny: actionWithADefaultShortcut hasShortcuts.
	
	ATestAActions pragmaKeywords: { #wantsTestDefaultActions }.
	ATestAActions resetDefaultShortcuts.
	
	self assert: actionWithADefaultShortcut hasShortcuts.
	self assert: actionWithADefaultShortcut shortcuts first equals: self shortcutCtrlb
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'wb 8/5/2022 17:57'
}
AActionsTests >> testResetGlobalDefaultShortcutsForDoesNotEffectLocalActions [

	| actionWithADefaultShortcut |
	
	actionWithADefaultShortcut := AMockActions addLineAction clazz: AMockActionAddLineAsList; yourself.
	self assert: actionWithADefaultShortcut hasDefaultShortcut.
	self deny: actionWithADefaultShortcut hasShortcuts.
	
	ATestAActions resetGlobalDefaultShortcutsFor: AMockActionAddLineAsList.
	self deny: actionWithADefaultShortcut hasShortcuts.
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'wb 8/5/2022 18:15'
}
AActionsTests >> testSelectorsWithActionsDefinedForAClass [
	
	| selectors correctSelectors |
	self assert: (ATestAActions selectorsWithActionsDefinedFor: AMockActionsMoveUpDuplicate) first equals: #actions.
	
	selectors := ATestAActions selectorsWithActionsDefinedFor: AMockActionsMoveUp.
	correctSelectors := #( #actionsDuplicate #actions).
	
	self assert: (self is: selectors equalTo: correctSelectors).
	
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'wb 8/5/2022 18:15'
}
AActionsTests >> testSelectorsWithAnActionDefinedForAClass [

	| action selectors | 
	
	action := AAction from: AMockActionsMoveUpDuplicate mockActionMoveUpAsList.
	self assert: (ATestAActions selectorsWith: action DefinedFor: AMockActionsMoveUpDuplicate) first equals: #actions.
	
	action := AAction from: AMockActionsMoveUp mockActionMoveUpAsList.
	selectors := ATestAActions selectorsWith: action DefinedFor: AMockActionsMoveUp.
	
	self assert: (self is: selectors equalTo: #(#actions #actionsDuplicate))
	
]

{
	#category : #'test shortcut triggering',
	#'squeak_changestamp' : 'KK 8/4/2022 11:22'
}
AActionsTests >> testShortcutNotTriggeringForFalseClass [
	
	self wasShortcutTriggered: false.
	
	ATestAActions addShortcut: self shortcutCtrld for: (self shortcutTriggeringAction) in: AShortcutTests.
	ATestAActions shortcutFor: self event: self shortcutCtrld.
	
	self assert: self wasShortcutTriggered equals: false

]

{
	#category : #'test shortcut triggering',
	#'squeak_changestamp' : 'KK 8/4/2022 11:22'
}
AActionsTests >> testShortcutNotTriggeringForFalseShortcut [
	
	self wasShortcutTriggered: false.
	
	ATestAActions addShortcut: self shortcutCtrld for: (self shortcutTriggeringAction) in: AActionsTests.
	ATestAActions shortcutFor: self event: self shortcutCtrlb.
	
	self assert: self wasShortcutTriggered equals: false

]

{
	#category : #'test shortcut triggering',
	#'squeak_changestamp' : 'KK 8/4/2022 11:22'
}
AActionsTests >> testShortcutTriggeringCorrectly [
	
	self wasShortcutTriggered: false.
	
	ATestAActions addShortcut: self shortcutCtrld for: (self shortcutTriggeringAction) in: AActionsTests.
	ATestAActions shortcutFor: self event: self shortcutCtrld.
	
	self assert: self wasShortcutTriggered

]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 8/4/2022 11:09'
}
AActionsTests >> wasShortcutTriggered [
	^ wasShortcutTriggered
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 8/4/2022 11:09'
}
AActionsTests >> wasShortcutTriggered: anObject [
	wasShortcutTriggered := anObject
]
