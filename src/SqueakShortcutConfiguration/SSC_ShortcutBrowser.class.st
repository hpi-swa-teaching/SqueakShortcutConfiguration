Class {
	#name : #'SSC_ShortcutBrowser',
	#superclass : #Model,
	#instVars : [
		'classIndex',
		'actionIndex'
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
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:59'
}
SSC_ShortcutBrowser >> actionIndex [
	^ actionIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:59'
}
SSC_ShortcutBrowser >> actionIndex: anObject [
	actionIndex := anObject.
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
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:10'
}
SSC_ShortcutBrowser >> actionsListRepresentation [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a title <= b title].
	self actions do: [:each | collection add: each].
	
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
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:19'
}
SSC_ShortcutBrowser >> createActionsListSpecWith: aToolBuilder [
	^ aToolBuilder pluggableListSpec new
		model: self;
		list: #actionsListRepresentation;
		keystrokePreview: #previewKeyStroke:forList:;
		name: #actionsList;
		getIndex: #actionIndex;
		setIndex: #actionIndex:;
		helpItem: #itemName:;
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
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:43'
}
SSC_ShortcutBrowser >> createButtonSpecWith: aToolBuilder named: aString action: actionSymbol enabled: aSymbol [ 
	^ aToolBuilder pluggableButtonSpec new
		model: self;
		label: aString;
		action: actionSymbol;
		enabled: aSymbol;
		yourself
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'yl 6/16/2024 16:21'
}
SSC_ShortcutBrowser >> createButtonSpecsWith: aToolBuilder [ 
	^ {
		{'Help' . #openHelpMenu . nil} .
		{'Reset locals' . #resetLocalShortcutsForSelectedClass . nil} .
		{'Reset globals' . #resetGlobalShortcutsForSelectedClass . nil} .
		{'Reset all' . #resetShortcuts . nil} .
		{'Create Shortcut' . #openShortcutMenu . nil}
	} collect: [:each |
		self
			createButtonSpecWith: aToolBuilder
			named: each first
			action: each second
			enabled: each third
	]
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:20'
}
SSC_ShortcutBrowser >> createClassListSpecWith: aToolBuilder [
	^ aToolBuilder pluggableListSpec new
		model: self;
		list: #classNames;
		keystrokePreview: #previewKeyStroke:forList:;
		name: #classList;
		getIndex: #classIndex; 
		setIndex: #classIndex:; 
		helpItem: #itemName:;
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/16/2024 16:21'
}
SSC_ShortcutBrowser >> createShortcut [
	| window msg body |
	window := DialogWindow new
		title: 'How to use';
		createButton: 'Thanks!' value: true;
		exclusive: false;
		message: 'Hello World';
		yourself.
	
	"scroll pane creation and sizing"
	body := window submorphNamed: 'Body'.
	msg := body submorphNamed: 'Message'.
	body addMorph: (msg inAScrollPane width: (msg width + ScrollPane scrollBarThickness); color: body color).
	
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
	#category : #todo,
	#'squeak_changestamp' : 'yl 6/16/2024 16:22'
}
SSC_ShortcutBrowser >> openShortcutMenu [
	self createShortcut openInWorld
]

{
	#category : #todo,
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:24'
}
SSC_ShortcutBrowser >> previewKeyStroke: aKeyboardEvent forList: aMorph [
	"no idea what this is for, but returning false makes the preview work"
	^ false
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
