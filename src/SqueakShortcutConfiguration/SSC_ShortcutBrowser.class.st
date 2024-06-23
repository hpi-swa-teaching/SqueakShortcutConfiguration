Class {
	#name : #'SSC_ShortcutBrowser',
	#superclass : #Model,
	#instVars : [
		'classIndex',
		'actionIndex',
		'lastSelectedAction'
	],
	#category : #SqueakShortcutConfiguration
}

{ #category : #creation }
SSC_ShortcutBrowser class >> open [
	^ ToolBuilder open: self new
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:01'
}
SSC_ShortcutBrowser class >> windowLabel [
	^ 'Shortcut Browser'
]

{
	#category : #'UI-callbacks',
	#'squeak_changestamp' : 'yl 6/20/2024 20:19'
}
SSC_ShortcutBrowser >> actionDoubleClicked [
	| actionName dialog |
	actionName := lastSelectedAction title.
	dialog := self createShortcut: actionName.
	dialog openInWorld.
	Transcript show: 'clicked on action '; show: (lastSelectedAction) ; cr.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:59'
}
SSC_ShortcutBrowser >> actionIndex [
	^ actionIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/19/2024 20:26'
}
SSC_ShortcutBrowser >> actionIndex: anObject [
	|action|
	actionIndex := anObject.
	action := self actionsListRepresentation at: anObject ifAbsent: [nil].
	action ifNotNil: [lastSelectedAction := action].
	self changed: #actionIndex.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:06'
}
SSC_ShortcutBrowser >> actions [
	self hasClassSelected
		ifFalse: [^ {}].
	
	^ SSC_API actionsForClassNamed: (self classNames at: self classIndex)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'TJS 6/23/2024 16:03'
}
SSC_ShortcutBrowser >> actionsListRepresentation [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a title <= b title].
	self actions do: [:each | each ifNotNil: [collection add: each]].
	
	^ collection
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:31'
}
SSC_ShortcutBrowser >> actionsListTransform [
	^ 0@self buttonPanelHeight corner: 1@1
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:25'
}
SSC_ShortcutBrowser >> buildWith: aToolBuilder [
	| windowSpec |
	windowSpec := aToolBuilder pluggableWindowSpec new
		model: self;
		label: #windowLabel;
		children: OrderedCollection new.
	
	windowSpec children
		add: (self createClassListSpecWith: aToolBuilder);
		add: (self createRightPanelSpecWith: aToolBuilder).
	
	^ aToolBuilder buildPluggableWindow: windowSpec.
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:44'
}
SSC_ShortcutBrowser >> buttonPanelHeight [
	^ 0.05
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:31'
}
SSC_ShortcutBrowser >> buttonPanelTransform [
	^ 0@0 corner: 1@self buttonPanelHeight
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:49'
}
SSC_ShortcutBrowser >> classIndex [
	^ classIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:10'
}
SSC_ShortcutBrowser >> classIndex: anObject [
	classIndex := anObject.
	self changed: #classIndex.
	self changed: #actionsListRepresentation.
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:32'
}
SSC_ShortcutBrowser >> classListTransform [
	^ 0@0 corner: 0.25@1
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:46'
}
SSC_ShortcutBrowser >> classNames [
	^ SSC_API classNames
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'MZ 6/19/2024 20:21'
}
SSC_ShortcutBrowser >> createActionsListSpecWith: aToolBuilder [
	^ aToolBuilder pluggableListSpec new
		model: self;
		list: #actionsListRepresentation;
		getIndex: #actionIndex;
		setIndex: #actionIndex:;
		doubleClick: #actionDoubleClicked;
		frame: self actionsListTransform;
		yourself
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:31'
}
SSC_ShortcutBrowser >> createButtonPanelSpecWith: aToolBuilder [ 
	^ aToolBuilder pluggablePanelSpec new
		model: self;
		children: (self createButtonSpecsWith: aToolBuilder);
		frame: self buttonPanelTransform;
		layout: #horizontal;
		yourself
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'MZ 6/19/2024 19:42'
}
SSC_ShortcutBrowser >> createButtonSpecsWith: aToolBuilder [ 
	^ {
		{'Help' . #openHelpMenu . nil} .
		{'Reset locals' . #resetLocalShortcutsForSelectedClass . nil} .
		{'Reset globals' . #resetGlobalShortcutsForSelectedClass . nil} .
		{'Reset all' . #resetShortcuts . nil}
	} collect: [:each |
		aToolBuilder pluggableButtonSpec new
		model: self;
		label: each first;
		action: each second;
		enabled: each third;
		yourself
	]
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'MZ 6/19/2024 19:36'
}
SSC_ShortcutBrowser >> createClassListSpecWith: aToolBuilder [
	^ aToolBuilder pluggableListSpec new
		model: self;
		list: #classNames;
		name: #classList;
		getIndex: #classIndex; 
		setIndex: #classIndex:;
		frame: self classListTransform.
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:31'
}
SSC_ShortcutBrowser >> createRightPanelSpecWith: aToolBuilder [
	| mainPanel |
	mainPanel := aToolBuilder pluggablePanelSpec new
		model: self;
		children: OrderedCollection new;
		frame: self rightPanelTransform;
		yourself.
	
	mainPanel children
		add: (self createButtonPanelSpecWith: aToolBuilder);
		add: (self createActionsListSpecWith: aToolBuilder).
	
	^ mainPanel
]

{
	#category : #default,
	#'squeak_changestamp' : 'yl 6/20/2024 20:27'
}
SSC_ShortcutBrowser >> createShortcut: actionName [ 
    | window msg body inputField scrollPane saveButton |
    window := DialogWindow new openInHand title: 'Create a Shortcut for ', actionName;
                     createButton: 'Cancel' value: false;
                     exclusive: false;
                     message: 'A simple input field to create your very own Shortcut';
                     yourself.
    "scroll pane creation and sizing"
    body := window submorphNamed: 'Body'.
    msg := body submorphNamed: 'Message'.
    scrollPane := msg inAScrollPane.
    scrollPane width: msg width + ScrollPane scrollBarThickness.
    scrollPane color: body color.
    body addMorph: scrollPane.

    "Create and add the input field"
    inputField := SSC_ShortcutInputMorph new.
    inputField width: 500.
    inputField height: 250.
    inputField borderWidth: 1.
    inputField balloonText: 'Your Shortcut here...'.
    inputField borderColor: Color black.

    "Position the input field below the message"
    body addMorph: inputField.
    inputField position: scrollPane bottomLeft + (0 @ 10).

    "Create the Save button and define its action"
    saveButton := PluggableButtonMorph new.
    saveButton label: 'Save!'.
    saveButton position: inputField bottomLeft + (0 @ 10).
    saveButton target: [
        | existingAction newAction api |
        api := SSC_API uniqueInstance.
        existingAction := (api actionsForClassNamed: actionName) detect: [:each | each title = actionName].
        newAction := SSC_Action new.
        newAction title: actionName.
        newAction method: existingAction method.
        newAction key: inputField shortcutText.
        api replaceAction: existingAction with: newAction for: (Smalltalk classNamed: actionName).
        window delete. "Close the window after saving"
    ].
    saveButton actionSelector: #value.
    body addMorph: saveButton.

    ^ window openInWorld.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:57'
}
SSC_ShortcutBrowser >> hasClassSelected [
	^ self classIndex ~= 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:00'
}
SSC_ShortcutBrowser >> initialize [
	super initialize.
	self classIndex: 0.
	self actionIndex: 1.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/19/2024 20:27'
}
SSC_ShortcutBrowser >> lastSelectedAction [
	^ lastSelectedAction
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:32'
}
SSC_ShortcutBrowser >> rightPanelTransform [
	^ self classListTransform width@0 corner: 1@1
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:04'
}
SSC_ShortcutBrowser >> update: aSymbol [
	self halt.
	self notYetImplemented.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:06'
}
SSC_ShortcutBrowser >> windowLabel [
	^ self class windowLabel
]
