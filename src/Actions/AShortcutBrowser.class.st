"
Class to manage Action-Shortcut-Pairs
"
Class {
	#name : #AShortcutBrowser,
	#superclass : #ABrowser,
	#instVars : [
		'actionIndex'
	],
	#classVars : [
		'Shortcuts'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:34'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 5/24/2022 20:16'
}
AShortcutBrowser class >> actions [
	|action1 shortcut1  |
	
	<wantsActions>
	shortcut1 := KeyboardEvent new 
		setType: #keystroke buttons: 64 position: 0 @ 0 keyValue: 98 hand: nil stamp: nil;
		yourself.
	
	action1 := AAction title: 'Browse actions' action: #browseActionsForSelectedClass description: 'Open the methods where actions are defined'.

	
	^ Dictionary new
			at: action1 put: shortcut1;
			yourself.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MaCl 5/21/2022 11:44'
}
AShortcutBrowser class >> initialize [

	TheWorldMenu registerOpenCommand: {'Shortcut Browser'. {self. #open}}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 5/24/2022 19:59'
}
AShortcutBrowser >> actionDuplicateWarning: aAction [

| window browseActionsButton| 

window := DialogWindow new.
window createButton: 'OK' value: true color: (Color r: 0.4 g: 0.0 b: 0.051).

browseActionsButton := window createCancelButton: 'Browse action' value: false.
browseActionsButton action: [self browse: aAction For: self selectedClass. window closeDialog].

window title: 'Warning'.
window message: 'You assigned the name "' , aAction title asString , '" to different actions
'.

window openAsTool.

			
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/13/2020 00:42'
}
AShortcutBrowser >> actionIndex [

	^ actionIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/13/2020 00:43'
}
AShortcutBrowser >> actionIndex: anObject [

	actionIndex := anObject.
	self changed: #actionIndex
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/26/2020 00:08'
}
AShortcutBrowser >> actionMenu: aMenu [

	^ self menu: aMenu for: #(actionsMenu)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/26/2020 00:07'
}
AShortcutBrowser >> actionsMenu: aMenu [

	<actionsMenu>
	aMenu addTitle: 'foo'.
	aMenu addStayUpItemSpecial.
	
	aMenu addList: #(
		('Add keyboard shortcut' addShortcut  'Adds a new keyboard shortcut')
	) , self listItemsForCurrentSelection.
	
	^ aMenu
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'WoC 10/9/2020 15:13'
}
AShortcutBrowser >> addShortcut [

	| eventKey |
	eventKey := AEventCapturer getUserChoice.
	self addShortcut: eventKey
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'WoC 9/28/2020 13:13'
}
AShortcutBrowser >> addShortcut: aShortcut [

	aShortcut ifNil: [^ self].
	AActions addShortcut: aShortcut for: self selectedAction in: self selectedClass.
	self changed: #mainView
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 5/24/2022 19:57'
}
AShortcutBrowser >> browse: aAction For: aClass [
	(AActions selectorsWith: aAction DefinedFor: aClass) do: [ :aSelector |
	 self browseClassSide: self selectedClass selector: aSelector.
].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 5/24/2022 18:55'
}
AShortcutBrowser >> browse: aClass selector: aSelector [

	^ Browser fullOnClass: aClass selector: aSelector
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 5/24/2022 21:04'
}
AShortcutBrowser >> browseActionsForSelectedClass [
	(AActions selectorsWithActionsDefinedFor: self selectedClass) do: [ :aSelector |
	 self browseClassSide: self selectedClass selector: aSelector.
].
]

{
	#category : #nil,
	#'squeak_changestamp' : 'KK 5/24/2022 18:55'
}
AShortcutBrowser >> browseClassSide: aClass selector: aSelector [

	^ Browser new
			setClass: aClass;
			indicateClassMessages;
			setSelector: aSelector;
			buildAndOpenFullBrowser
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'TA 5/7/2022 15:27'
}
AShortcutBrowser >> buttonPanelHeight [

	^ 0.05
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 5/19/2022 11:54'
}
AShortcutBrowser >> checkForDuplicatesFor: aClass [

	| duplicateAction |
	
	duplicateAction := AActions checkIfDuplicatesExistsFor: aClass.
	duplicateAction ifNotNil: [self actionDuplicateWarning: duplicateAction]
	
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'TA 5/15/2022 21:20'
}
AShortcutBrowser >> classIndex: anInteger [

	super classIndex: anInteger.
	
	self selectedClass ifNotNil:  [self checkForDuplicatesFor: self selectedClass]
	
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'KK 5/14/2022 16:23'
}
AShortcutBrowser >> createButtonSpecsWith: aToolBuilder [

	^ {
		{'Help' . #openHelpMenu . nil} .
		{'Reset' . #resetShortcutsForSelectedClass . nil} .
		{'Reset all' . #resetShortcuts . nil}} 
		collect: [:each | 
			self 
				createButtonSpecWith: aToolBuilder 
				named: each first
				action: each second
				enabled: each third]
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'KK 5/24/2022 20:34'
}
AShortcutBrowser >> createMainListSpecWith: aToolBuilder [

	| mainPanel |
	mainPanel := aToolBuilder pluggablePanelSpec new
		model: self;
		children: OrderedCollection new;
		frame: (0.25@0 corner: 1@1);
		yourself.
		
	mainPanel children
		add: (self createButtonPanelSpecWith: aToolBuilder);
		add: (self createPluggableListSpecWith: aToolBuilder).
	
	^ mainPanel
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'KK 5/24/2022 21:01'
}
AShortcutBrowser >> createPluggableListSpecWith: aToolBuilder [

	^ aToolBuilder pluggableListSpec new
		model: self;
		list: #mainView;
		getIndex: #actionIndex; 
		keystrokePreview: #keyPress:list:;
		setIndex: #actionIndex:; 
		menu: #actionMenu:;
		autoDeselect: false;
		helpItem: #helpForItem:;
		frame: (0@0.06 corner: 1@1);
		yourself
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/28/2020 12:12'
}
AShortcutBrowser >> helpForItem: anInteger [

	^ (self mainView at: anInteger) description
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:34'
}
AShortcutBrowser >> helpMenu [

|a| 
	a := DialogWindow new.
	a title: 'How to use';
	createButton: 'Thanks!' value: true;
	exclusive: false;
	message:' The shortcut browser is used to assign key combinations to different actions. Our shortcut browser is divided
 into two sections. In the left section you can choose between the different classes where you can use your shortcuts.
 After selecting a class you will see the available actions in the right section.

 Add Shortcut:

 To add a key combination to an action, you can right-click the action and select "Add keyboard shortcut".
 After that you can assign a key combination by hovering your mouse over the event capturer window and
 pressing the desired key combination. Press "ok" to add the shortcut. If you changed your mind you can press
 "cancel" to close the event capturer. 

 Remove Shortcut:

 To remove a shortcut, right-click an action where you assigned a shortcut. A list of your assigned shortcuts will
 open. To remove a shortcut, simply left-click the shortcut you want to remove.

 Reset your shortcuts:

 If you want to reset your shortcuts to the default implementation you have two different options:

 1. Reset shortcuts of one class:
 Simply select your desired class with a left-click. Then left-click the "Reset"-Button next to the "Help"-Button. Press "yes"
 to reset your shortcuts of the class to default, press "no" if you want to cancel your action.

 2. Reset all shortcuts:
 Left-click the "Reset all"-Button next to the "Reset"-Button. Press "yes" to reset your shortcuts of all classes to default, 
 press "no" if you want to cancel your action.'.

^a
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MaCl 5/21/2022 10:49'
}
AShortcutBrowser >> initialize [

	super initialize.
	self actionIndex: 1
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'KK 5/24/2022 21:03'
}
AShortcutBrowser >> keyPress: evt list: list [

	AActions shortcutFor: self event: evt.
	^true.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'TA 5/15/2022 20:52'
}
AShortcutBrowser >> listItemsForCurrentSelection [

	| shortcuts items |
	
	shortcuts := AActions
						shortcutsFor: self selectedAction 
						in: self selectedClass 
						ifAbsent: [^ {}]. 
	items := OrderedCollection with: #-.
	shortcuts do: [:each | | stream |
		stream := WriteStream on: ''.
		each printKeyStringOn: stream.
		items add: {'Remove ', stream contents . 
			[self removeShortcut: each] . 
			'Removes the displayed shortcut from the system'}].
	
	^ items
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'TA 5/14/2022 13:11'
}
AShortcutBrowser >> mainView [

	| collection |
	collection := SortedCollection sortBlock: [:a :b |  a title <= b title].
	self actions do: [:each | each writeListRepresentationOn: collection].
	
	^ collection
			
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:34'
}
AShortcutBrowser >> openHelpMenu [

	self helpMenu openAsTool
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'WoC 9/26/2020 18:54'
}
AShortcutBrowser >> removeShortcut: anEventKey [

	AActions removeShortcut: anEventKey in: self selectedClass.
	self changed: #mainView
]

{
	#category : #'reset shortcuts',
	#'squeak_changestamp' : 'KK 6/2/2022 15:02'
}
AShortcutBrowser >> resetShortcuts [
	
	| isResetConfirmed |
	isResetConfirmed := (PopUpMenu confirm: 'Danger: Do you want to reset all shortcuts?').
	isResetConfirmed ifTrue: 
		[AActions resetDefaultShortcuts.
			self changed: #mainView.
		].
]

{
	#category : #'reset shortcuts',
	#'squeak_changestamp' : 'KK 6/2/2022 15:00'
}
AShortcutBrowser >> resetShortcutsForSelectedClass [
	
	| isResetConfirmed |
	Transcript show: self selectedClass.
	isResetConfirmed := (PopUpMenu confirm: 'Do you want to reset ', self selectedClass, ' shortcuts?').
	isResetConfirmed ifTrue: 
		[AActions resetDefaultShortcutsFor: self selectedClass.
			self changed: #mainView.
		].

]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/30/2020 23:27'
}
AShortcutBrowser >> selectedAction [

	^ self mainView at: self actionIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 13:48'
}
AShortcutBrowser >> windowLabel [

	^  'Shortcut Browser'
]
