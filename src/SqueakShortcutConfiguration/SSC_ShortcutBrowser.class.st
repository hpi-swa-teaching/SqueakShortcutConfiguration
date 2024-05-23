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
	#category : #todo,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:56'
}
SSC_ShortcutBrowser >> actions [
	self hasClassSelected
		ifFalse: [^ {}].
	
	self notYetImplemented.
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:13'
}
SSC_ShortcutBrowser >> buildWith: aToolBuilder [
	| windowSpec |
	windowSpec := aToolBuilder pluggableWindowSpec new
		model: self;
		label: #windowLabel;
		children: OrderedCollection new.
	
	windowSpec children
		add: (self createActionsListSpecWith: aToolBuilder);
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
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:49'
}
SSC_ShortcutBrowser >> classIndex [
	^ classIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:52'
}
SSC_ShortcutBrowser >> classIndex: anObject [
	classIndex := anObject.
	self changed: #classIndex.
	self changed: #mainView.
]

{
	#category : #todo,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:49'
}
SSC_ShortcutBrowser >> classNames [
	^ {}
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:12'
}
SSC_ShortcutBrowser >> createActionsListSpecWith: aToolBuilder [
	^ aToolBuilder pluggableListSpec new
		model: self;
		list: #classNames;
		keystrokePreview: #enumListKeyPress:list:;
		name: #leftSideClassList;
		getIndex: #classIndex;
		setIndex: #classIndex:;
		helpItem: #itemName:;
		frame: self positionClassList;
		yourself
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:36'
}
SSC_ShortcutBrowser >> createButtonPanelSpecWith: aToolBuilder [ 
	^ aToolBuilder pluggablePanelSpec new
		model: self;
		children: (self createButtonSpecsWith: aToolBuilder);
		frame: self positionButtonPanel;
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
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:41'
}
SSC_ShortcutBrowser >> createButtonSpecsWith: aToolBuilder [ 
	^ {
		{'Help' . #openHelpMenu . nil} .
		{'Reset locals' . #resetLocalShortcutsForSelectedClass . nil} .
		{'Reset globals' . #resetGlobalShortcutsForSelectedClass . nil} .
		{'Reset all' . #resetShortcuts . nil}
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
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:10'
}
SSC_ShortcutBrowser >> createRightPanelSpecWith: aToolBuilder [
	| mainPanel |
	mainPanel := aToolBuilder pluggablePanelSpec new
		model: self;
		children: OrderedCollection new;
		frame: self positionMainList;
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
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:54'
}
SSC_ShortcutBrowser >> mainView [
	| collection |
	collection := SortedCollection sortBlock: [:a :b | a title <= b title].
	self actions do: [:each | each writeListRepresentationOn: collection].
	
	^ collection
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:36'
}
SSC_ShortcutBrowser >> positionButtonPanel [
	^ 0@0 corner: 1@self buttonPanelHeight
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 5/23/2024 22:09'
}
SSC_ShortcutBrowser >> positionClassList [
	^ 0@0 corner: 0.25@1
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:32'
}
SSC_ShortcutBrowser >> positionMainList [
	^ 0.25@0 corner: 1@1
]

{
	#category : #default,
	#'squeak_changestamp' : 'JPVS 5/23/2024 21:48'
}
SSC_ShortcutBrowser >> positionRightSide [
	^ 0@0.06 corner: 1@1
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
