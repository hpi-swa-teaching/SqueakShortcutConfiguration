"
Class to manage Action-Shortcut-Pairs
"
Class {
	#name : #AShortcutBrowser,
	#superclass : #ABrowser,
	#instVars : [
		'actionIndex'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:34'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'MaCl 8/4/2022 17:04'
}
AShortcutBrowser class >> actions [

	<wantsActions>
	
	|browseActions|

	browseActions := Dictionary new
		at: #leftSideClassList put: #browseActionsForSelectedClass;
		at: #RightSide put: #browseSelectedAction;
		yourself.
	^{   
		{'Browse actions' . browseActions .'Open the methods where actions are defined'. 
		$b . #cmdPressed}.
	}collect: [:each | AAction createActions: each]

]

{
	#category : #actions,
	#'squeak_changestamp' : 'MaCl 8/4/2022 17:11'
}
AShortcutBrowser class >> alternativeActionsClassName [

	^'Shortcut-Browser'
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'KK 6/23/2022 17:41'
}
AShortcutBrowser class >> initialize [

	TheWorldMenu registerOpenCommand: {self windowLabel. {self. #open}}
]

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 6/23/2022 17:41'
}
AShortcutBrowser class >> windowLabel [

	^ 'Shortcut Browser'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'ft 8/5/2022 16:20'
}
AShortcutBrowser >> actionDuplicateWarning: aAction [

| window browseActionsButton| 

window := DialogWindow new.
window createButton: 'Ignore' value: true.

browseActionsButton := window createButton: 'Browse actions' value: false color: Color lightGreen.
browseActionsButton action: [self browse: aAction For: self selectedClass. window closeDialog].

window title: 'Warning'.
window message: 'You assigned the name "' , aAction title asString , '" to different actions
'.
window updateButtonExtent: self sizeButton.

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
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 00:08'
}
AShortcutBrowser >> actionMenu: aMenu [

	^ self menu: aMenu for: #(actionsMenu)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MaCl 8/4/2022 18:45'
}
AShortcutBrowser >> actionsMenu: aMenu [

	<actionsMenu>
	aMenu addTitle: 'Choose Action'.
	aMenu addStayUpItemSpecial.
	
	aMenu addList: #(
		('Add keyboard shortcut' addShortcut  'Adds a new keyboard shortcut')
	) , self listItemsForCurrentSelection.
	
	^ aMenu
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'TA 7/28/2022 15:14'
}
AShortcutBrowser >> addShortcut [

	| eventKey |
	
	eventKey := AEventCapturer getUserChoice.
	self addShortcut: eventKey
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'KK 6/6/2022 23:50'
}
AShortcutBrowser >> addShortcut: aShortcut [

	aShortcut ifNil: [^ self].
	self aactionsApi addShortcut: aShortcut for: self selectedAction in: self selectedClass.
	self changed: #mainView
]

{
	#category : #browsing,
	#'squeak_changestamp' : 'KK 6/6/2022 23:51'
}
AShortcutBrowser >> browse: aAction For: aClass [

	(self aactionsApi selectorsWith: aAction DefinedFor: aClass) do: [ :aSelector |
	 self browseClassSide: self selectedClass selector: aSelector.
	].
]

{
	#category : #browsing,
	#'squeak_changestamp' : 'KK 5/24/2022 18:55'
}
AShortcutBrowser >> browse: aClass selector: aSelector [

	^ Browser fullOnClass: aClass selector: aSelector
]

{
	#category : #browsing,
	#'squeak_changestamp' : 'MZ 5/23/2024 09:46'
}
AShortcutBrowser >> browseActionsForSelectedClass [

	| systemNavigator methodList navigatorTitle |
	
	navigatorTitle := '', self selectedClass, ' Class Actions Definitions'.
	systemNavigator := SystemNavigation new.
	
	(self selectedClass) ifNotNil: [
		methodList := (systemNavigator 
			allMethodsSelect: [:method | self aactionsApi hasAnyActionPragmas: method] 
				localTo: self selectedClass) asArray.
				
		systemNavigator 
			browseMessageList: methodList
			name: navigatorTitle 
			autoSelect: 	navigatorTitle]


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
	#category : #browsing,
	#'squeak_changestamp' : 'KK 6/14/2022 20:47'
}
AShortcutBrowser >> browseSelectedAction [
	
	self selectedClass ifNotNil: [self browse: self selectedAction For: self selectedClass]
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'TA 5/7/2022 15:27'
}
AShortcutBrowser >> buttonPanelHeight [

	^ 0.05
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'KK 6/6/2022 23:51'
}
AShortcutBrowser >> checkForDuplicatesFor: aClass [

	| duplicateAction |
	
	duplicateAction := self aactionsApi checkIfDuplicatesExistsFor: aClass.
	duplicateAction ifNotNil: [self actionDuplicateWarning: duplicateAction]
	
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/14/2022 20:44'
}
AShortcutBrowser >> classIndex: anInteger [

	super classIndex: anInteger.
	self actionIndex: 1.
	self selectedClass ifNotNil:  [self checkForDuplicatesFor: self selectedClass]
	
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'MaCl 7/19/2022 15:58'
}
AShortcutBrowser >> createButtonSpecsWith: aToolBuilder [

	^ {
		{'Help' . #openHelpMenu . nil} .
		{'Reset locals' . #resetLocalShortcutsForSelectedClass . nil} .
		{'Reset globals' . #resetGlobalShortcutsForSelectedClass . nil}.
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
	#'squeak_changestamp' : 'ft 8/5/2022 16:21'
}
AShortcutBrowser >> createMainListSpecWith: aToolBuilder [

	| mainPanel |
	mainPanel := aToolBuilder pluggablePanelSpec new
		model: self;
		children: OrderedCollection new;
		frame: self positionMainList;
		yourself.
		
	mainPanel children
		add: (self createButtonPanelSpecWith: aToolBuilder);
		add: (self createPluggableListSpecWith: aToolBuilder).
	
	^ mainPanel
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'ft 8/5/2022 16:23'
}
AShortcutBrowser >> createPluggableListSpecWith: aToolBuilder [

	^ aToolBuilder pluggableListSpec new
		model: self;
		list: #mainView;
		getIndex: #actionIndex; 
		keystrokePreview: #keyPress:list:;
		name: #RightSide;
		setIndex: #actionIndex:; 
		menu: #actionMenu:;
		autoDeselect: false;
		helpItem: #helpForItem:;
		frame: self positionRightSide;
		yourself
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'KK 6/14/2022 20:31'
}
AShortcutBrowser >> enumListkeyPress: evt list: aList [

	AActions shortcutFor: self event: evt.
	^true
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'WoC 9/28/2020 12:12'
}
AShortcutBrowser >> helpForItem: anInteger [

	^ (self mainView at: anInteger) description
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MaCl 8/4/2022 16:32'
}
AShortcutBrowser >> helpMenu [

	^ DialogWindow new
		title: 'How to use';
		createButton: 'Thanks!' value: true;
		exclusive: false;
		message: self helpText;
		yourself
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MaCl 8/4/2022 16:42'
}
AShortcutBrowser >> helpText [

^ 
' The shortcut browser is used to assign key combinations to different actions. Our shortcut browser is divided into two 
 sections. In the left section you can choose between the different classes where you can use your shortcuts. Perhaps 
 individual classes have been renamed. You can see the actual class name in the balloon text that appears by hovering your
 mouse over the name. After selecting a class you will see the available actions in the right section. By hovering your mouse
 over a specific action, a ballon text appears, with a short description of the specific action.
 
 Add Shortcut:

 To add a key combination to an action, you can right-click the action and select "Add keyboard shortcut". After that you
 can assign a key combination by hovering your mouse over the event capturer window and pressing the desired key
 combination. Press "ok" to add the shortcut. If you changed your mind you can press "cancel" to close the event capturer. 
 
 If you choose a key combination that is already assigned to another action, you will receive a warning message. Press 
 "Yes" if you still want to choose the selected key combination and want to delete the combination for the other action.
 Otherwise press "no".

 Remove Shortcut:

 To remove a shortcut, right-click an action where you assigned a shortcut. A list of your assigned shortcuts will open. 
 To remove a shortcut, simply left-click the shortcut you want to remove.

 Reset Shortcut:

 If you want to reset your shortcuts to the default implementation you have two different options:

 1. Reset local shortcuts of one class:
 Simply select your desired class with a left-click. Then left-click the "Reset locals"-Button next to the "Help"-Button.
 Press "yes" to reset your shortcuts of local actions of the class to default, press "no" if you want to cancel your action.

 2. Reset local shortcuts of one class
 Simply select your desired class with a left-click. Then left-click the "Reset globals"-Button next to the "Help"-Button.
 Press "yes" to reset your shortcuts of global actions of the class to default, press "no" if you want to cancel your action.

 3. Reset all shortcuts:
 Left-click the "Reset all"-Button next to the "Reset"-Button. Press "yes" to reset your shortcuts of all classes to default, 
 press "no" if you want to cancel your action.

 Browse Action:

 To browse an action implementation, you can right-click that action and press the default key combination "cmd-b". If you
 have already changed the browsing action shortcut, press your changed key combination. A browser window opens, 
 showing the implementation. It is also possible to browse all actions of an selected class. Therefor right-click the choosen
 class on the left side of the shortcut browser window and press the key combination assigned to the browsing action. A
 browser window opens, containing all methods with action implementations of the selected class'
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'MaCl 5/21/2022 10:49'
}
AShortcutBrowser >> initialize [

	super initialize.
	self actionIndex: 1
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'KK 6/14/2022 17:10'
}
AShortcutBrowser >> keyPress: evt list: list [

	self aactionsApi shortcutFor: self event: evt.
	^true
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'KK 6/6/2022 23:51'
}
AShortcutBrowser >> listItemsForCurrentSelection [

	| shortcuts items |
	
	shortcuts := self aactionsApi
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
	#'squeak_changestamp' : 'TA 8/4/2022 09:33'
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
	#category : #default,
	#'squeak_changestamp' : 'ft 8/5/2022 16:21'
}
AShortcutBrowser >> positionMainList [

	^ 0.25@0 corner: 1@1
]

{
	#category : #default,
	#'squeak_changestamp' : 'ft 8/5/2022 16:22'
}
AShortcutBrowser >> positionRightSide [

	^ 0@0.06 corner: 1@1
]

{
	#category : #'handle shortcuts',
	#'squeak_changestamp' : 'KK 6/6/2022 23:50'
}
AShortcutBrowser >> removeShortcut: anEventKey [

	self aactionsApi removeShortcut: anEventKey in: self selectedClass.
	self changed: #mainView
]

{
	#category : #'reset shortcuts',
	#'squeak_changestamp' : 'MaCl 7/14/2022 14:00'
}
AShortcutBrowser >> resetGlobalShortcutsForSelectedClass [
	
	| isResetConfirmed |

	isResetConfirmed := (PopUpMenu confirm: 'Do you want to reset ', self selectedClass, ' shortcuts for global Actions to default?').
	isResetConfirmed ifTrue: 
		[self aactionsApi resetGlobalDefaultShortcutsFor: self selectedClass.
			self changed: #mainView.]
]

{
	#category : #'reset shortcuts',
	#'squeak_changestamp' : 'MaCl 7/14/2022 14:01'
}
AShortcutBrowser >> resetLocalShortcutsForSelectedClass [
	
	| isResetConfirmed |

	isResetConfirmed := (PopUpMenu confirm: 'Do you want to reset ', self selectedClass, ' shortcuts for local Actions to default?').
	isResetConfirmed ifTrue: 
		[self aactionsApi resetLocalDefaultShortcutsFor: self selectedClass.
			self changed: #mainView.]
]

{
	#category : #'reset shortcuts',
	#'squeak_changestamp' : 'TA 8/4/2022 09:33'
}
AShortcutBrowser >> resetShortcuts [
	
	| isResetConfirmed |
	
	isResetConfirmed := (PopUpMenu confirm: 'Danger: Do you want to reset all shortcuts to default?').
	isResetConfirmed ifTrue: 
		[self aactionsApi resetDefaultShortcuts.
     self changed: #mainView. 
    ].

]

{
	#category : #'reset shortcuts',
	#'squeak_changestamp' : 'MaCl 6/4/2022 15:07'
}
AShortcutBrowser >> resetShortcutsForSelectedClass [
	
	| isResetConfirmed |

	isResetConfirmed := (PopUpMenu confirm: 'Do you want to reset ', self selectedClass, ' shortcuts to default?').
	isResetConfirmed ifTrue: 
		[self aactionsApi resetDefaultShortcutsFor: self selectedClass.
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
	#category : #default,
	#'squeak_changestamp' : 'ft 8/5/2022 16:19'
}
AShortcutBrowser >> sizeButton [

	^ 110@15
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/23/2022 17:41'
}
AShortcutBrowser >> windowLabel [

	^  self class windowLabel
]
