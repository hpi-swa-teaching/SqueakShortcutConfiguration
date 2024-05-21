Class {
	#name : #AActionsTests,
	#superclass : #ActionsTest,
	#category : 'Actions-Test'
}

{
	#category : #history,
	#'squeak_changestamp' : 'wb 6/22/2022 16:45'
}
AActionsTests class >> lastStoredRun [
	^ ((Dictionary new) add: (#duration->23); add: (#errors->((Set new) add: #testCheckForExistingDuplicateActions; add: #testCheckForNonExistingDuplicateActions; add: #testSelectorsWithAnActionDefinedForAClass; add: #testAddAndResetShortcut; yourself)); add: (#passed->((Set new) add: #testAddAndRemoveShortcut; add: #testSelectorsWithActionsDefinedForAClass; yourself)); add: (#failures->((Set new))); add: (#timeStamp->'22 June 2022 4:16:35.86868 pm' asTimeStamp); add: (#durations->((Dictionary new) add: (#testCheckForNonExistingDuplicateActions->nil); add: (#testSelectorsWithActionsDefinedForAClass->21); add: (#testAddAndResetShortcut->nil); add: (#testSelectorsWithAnActionDefinedForAClass->nil); add: (#testAddAndRemoveShortcut->2); add: (#testCheckForExistingDuplicateActions->nil); yourself)); yourself)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/7/2022 10:27'
}
AActionsTests >> setUp [
	
	super setUp.
	
	ATestAActions reset.
	ATestAActions pragmaKeywords: { #wantsDuplicateTestActions }.
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/7/2022 10:38'
}
AActionsTests >> testAddAndRemoveShortcut [

	| shortcut1 shortcut2 action1 action2 |
	
	shortcut1 := KeyboardEvent new 
		setType: #keystroke buttons: 64 position: 0 @ 0 keyValue: 98 hand: nil stamp: nil;
		yourself.
	shortcut2 := KeyboardEvent new 
		setType: #keystroke buttons: 64 position: 0 @ 0 keyValue: 100 hand: nil stamp: nil;
		yourself.
		
	action1 := AAction from: MockActionsA mockActionMoveUpAsList.
	action2 := AAction from: MockActionsA mockActionMoveDownAsList.
	
	ATestAActions addShortcut: shortcut1 for: action1 in: MockActionsA.
	ATestAActions addShortcut: shortcut2 for: action2 in: MockActionsA.
	
	self assert: (ATestAActions shortcutsFor: action1 in: MockActionsA ifAbsent: []) first equals: shortcut1.
	self assert: (ATestAActions shortcutsFor: action2 in: MockActionsA ifAbsent: []) first equals: shortcut2.
	
"
	ATestAActions addShortcut: shortcut1 for: action1 in: MockActionsA.
	self assert: (ATestAActions shortcutsFor: action1 in: MockActionsA ifAbsent: []) first equals: shortcut1.
	"
	ATestAActions removeShortcut: shortcut1 in: MockActionsA.
	self assert: (ATestAActions shortcutsFor: action1 in: MockActionsA ifAbsent: []) equals: nil.
	self assert: (ATestAActions shortcutsFor: action2 in: MockActionsA ifAbsent: []) first equals: shortcut2.

	ATestAActions removeShortcuts.
	self assert: (ATestAActions shortcutsFor: action1 in: MockActionsA ifAbsent: []) equals: nil.
	self assert: (ATestAActions shortcutsFor: action2 in: MockActionsA ifAbsent: []) equals: nil.
		
	

]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/7/2022 10:32'
}
AActionsTests >> testAddAndResetShortcut [

	| shortcut1 action1 |
	
	shortcut1 := KeyboardEvent new 
		setType: #keystroke buttons: 64 position: 0 @ 0 keyValue: 98 hand: nil stamp: nil;
		yourself.
		
	action1 := AAction from: MockActionsA mockActionMoveUpAsList.
	
	ATestAActions addShortcut: shortcut1 for: action1 in: MockActionsA.
	self assert: (ATestAActions shortcutsFor: action1 in: MockActionsA ifAbsent: []) first equals: shortcut1.
	
	ATestAActions resetDefaultShortcutsFor: MockActionsA.
	self assert: (ATestAActions shortcutsFor: action1 in: MockActionsA ifAbsent: []) equals: nil.
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/6/2022 23:57'
}
AActionsTests >> testCheckForExistingDuplicateActions [

	| actionTitleA actionTitleB |
	
	"Check for duplicates in same method and check for duplicates in different methods"
	actionTitleA := (AAction from: MockActionsA mockActionMoveUpAsList) title.
	self assert: (ATestAActions checkIfDuplicatesExistsFor: MockActionsA) title equals: actionTitleA.
	
	actionTitleB := (AAction from: MockActionsB mockActionMoveUpAsList) title.
	self assert: (ATestAActions checkIfDuplicatesExistsFor: MockActionsB) title equals: actionTitleB
	

]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/6/2022 23:58'
}
AActionsTests >> testCheckForNonExistingDuplicateActions [

	self assert: (ATestAActions checkIfDuplicatesExistsFor: MockActionsC) equals: nil
	

]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/13/2022 13:58'
}
AActionsTests >> testSelectorsWithActionsDefinedForAClass [
	
	| selectors correctSelectors |
	self assert: (ATestAActions selectorsWithActionsDefinedFor: MockActionsA) first equals: #actions.
	
	selectors := ATestAActions selectorsWithActionsDefinedFor: MockActionsB.
	correctSelectors := #( #actionsDuplicate #actions).
	
	self assert: (self is: selectors equalTo: correctSelectors).
	
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/13/2022 13:53'
}
AActionsTests >> testSelectorsWithAnActionDefinedForAClass [

	| action selectors | 
	
	action := AAction from: MockActionsA mockActionMoveUpAsList.
	self assert: (ATestAActions selectorsWith: action DefinedFor: MockActionsA) first equals: #actions.
	
	action := AAction from: MockActionsB mockActionMoveUpAsList.
	selectors := ATestAActions selectorsWith: action DefinedFor: MockActionsB.
	
	self assert: (self is: selectors equalTo: #(#actions #actionsDuplicate))
	
]
