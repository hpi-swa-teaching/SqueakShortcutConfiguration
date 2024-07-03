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

{
	#category : #default,
	#'squeak_changestamp' : 'MZ 6/23/2024 15:33'
}
SSC_ShortcutBrowser class >> actionsListName [
	^ #actionsList
]

{
	#category : #default,
	#'squeak_changestamp' : 'MZ 6/23/2024 15:33'
}
SSC_ShortcutBrowser class >> classListName [
	^ #classList
]

{ #category : #creation }
SSC_ShortcutBrowser class >> open [
	^ ToolBuilder open: self new
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:01'
}
SSC_ShortcutBrowser class >> windowLabel [
	^ 'Shortcut Browser'
]

{
	#category : #'UI-callbacks',
	#'squeak_changestamp' : 'MZ 6/29/2024 21:56'
}
SSC_ShortcutBrowser >> actionDoubleClicked [
	| keyboardEvent |
	keyboardEvent := SSC_EventCapturer getUserChoice.
	keyboardEvent ifNotNil: [ |newAction| 
		newAction := SSC_Action new key: keyboardEvent keyCharacter; method: lastSelectedAction method; title: lastSelectedAction title; shift: keyboardEvent shiftPressed. 
		SSC_API uniqueInstance replaceAction: lastSelectedAction with: newAction for: self selectedClass].
	self changed: #actionsListRepresentation.
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
	#'squeak_changestamp' : 'MZ 6/23/2024 15:33'
}
SSC_ShortcutBrowser >> createActionsListSpecWith: aToolBuilder [
	^ aToolBuilder pluggableListSpec new
		model: self;
		name: SSC_ShortcutBrowser actionsListName;
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
	#'squeak_changestamp' : 'yl 6/23/2024 17:17'
}
SSC_ShortcutBrowser >> createButtonSpecsWith: aToolBuilder [ 
	^ {
		{'Help' . #openHelpMenu . nil} .
		{'Reset selected' . #resetLocalShortcutsForSelectedClass . nil} .
		{'Reset class' . #resetGlobalShortcutsForSelectedClass . nil} .
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
	#'squeak_changestamp' : 'MZ 6/23/2024 15:33'
}
SSC_ShortcutBrowser >> createClassListSpecWith: aToolBuilder [
	^ aToolBuilder pluggableListSpec new
		model: self;
		name: SSC_ShortcutBrowser classListName;
		list: #classNames;
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
	#category : #testing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:57'
}
SSC_ShortcutBrowser >> hasClassSelected [
	^ self classIndex ~= 0
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 7/3/2024 12:34'
}
SSC_ShortcutBrowser >> helpText [
	^ 'The Shortcut Browser is used to change key combinations assigned to different actions.
	
To change a certain Shortcut, you first have to select the class that you want to Change Shortcuts for in the list on the Left.
Once you have done that, the list on the right will now show all actions that this class provides.
Now you can double click an action to open a window where you can press the new key combination that you want to assign.
Once you have entered the key combination you can press ok to apply the changes or cancel to... well... cancel them.

If you want to reset shortcuts for some action(s) back to the default you have three options: you can either select the action you want to reset and press "Reset selected" to reset just that action, you can select a class and press "Reset class" to select all actions for that class or you can press "Reset all" to reset all actions for all classes.'
]

{
	#category : #initialization,
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
	#category : #'UI-callbacks',
	#'squeak_changestamp' : 'JPVS 7/3/2024 12:36'
}
SSC_ShortcutBrowser >> openHelpMenu [
	| window body msg |
	window := DialogWindow new
		title: 'ShortcutBrowser Help';
		createButton: 'Thanks!' value: true;
		message: self helpText;
		autoCancel: true;
		yourself.
	body := window submorphNamed: 'Body'.
	msg := body submorphNamed: 'Message'.
	body addMorph: (msg inAScrollPane width: (msg width + ScrollPane scrollBarThickness); color: body color).
	window openAsTool.
]

{
	#category : #reset,
	#'squeak_changestamp' : 'yl 6/23/2024 18:10'
}
SSC_ShortcutBrowser >> resetGlobalShortcutsForSelectedClass [

	| selectedClassName selectedClass defaultActions|
	
    self hasClassSelected ifFalse: [^ self inform: 'No class selected'].

    selectedClassName := self classNames at: self classIndex.
    selectedClass := Smalltalk classNamed: selectedClassName.

    "Prüfen, ob die ausgewählte Klasse die Methode defaultSSCActions implementiert"
    (selectedClass respondsTo: #defaultSSCActions) ifFalse: [
        ^ self inform: selectedClassName, ' does not support default shortcuts reset.'
    ].

    "Standardaktionen abrufen"
    defaultActions := selectedClass defaultSSCActions.
    selectedClass SSCActions: defaultActions.


    "Aktualisieren der Aktionsliste"
    self changed: #actionsListRepresentation.
]

{
	#category : #reset,
	#'squeak_changestamp' : 'yl 6/23/2024 17:51'
}
SSC_ShortcutBrowser >> resetLocalShortcutsForSelectedClass [
 "TODO"
	


]

{
	#category : #reset,
	#'squeak_changestamp' : 'yl 6/23/2024 18:10'
}
SSC_ShortcutBrowser >> resetShortcuts [

| classNamesToReset |

    "Klassen-Namen durch SSC_API abrufen"
    classNamesToReset := SSC_API classNames.

    classNamesToReset do: [ :className |
        | selectedClass defaultActions |

        "Klasse nach Namen abrufen"
        selectedClass := Smalltalk classNamed: className.

        "Prüfen, ob die Klasse die Methode defaultSSCActions implementiert"
        (selectedClass respondsTo: #defaultSSCActions) ifFalse: [
            self inform: className, ' does not support default shortcuts reset.'.
             ^ nil "Weiter zur nächsten Klasse"
        ].

        "Standardaktionen abrufen"
        defaultActions := selectedClass defaultSSCActions.
	  selectedClass SSCActions: defaultActions.
].

    "Aktualisieren der Aktionsliste"
    self changed: #actionsListRepresentation.
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:32'
}
SSC_ShortcutBrowser >> rightPanelTransform [
	^ self classListTransform width@0 corner: 1@1
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MZ 6/23/2024 23:05'
}
SSC_ShortcutBrowser >> selectedClass [
	^ Smalltalk classNamed: (self classNames at: self classIndex ifAbsent: [^ nil])
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:06'
}
SSC_ShortcutBrowser >> windowLabel [
	^ self class windowLabel
]
