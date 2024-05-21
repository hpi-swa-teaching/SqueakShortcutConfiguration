"
Abstract class for Menu- and ShortcutBrowser
"
Class {
	#name : #ABrowser,
	#superclass : #Model,
	#instVars : [
		'classIndex'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 10:09'
}

{
	#category : #creation,
	#'squeak_changestamp' : 'WoC 9/26/2020 13:46'
}
ABrowser class >> open [

	^ ToolBuilder open: self new
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/6/2022 23:49'
}
ABrowser >> aactionsApi [

	^ AActions
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/6/2022 23:49'
}
ABrowser >> actions [

	self hasClassSelected
		ifFalse: [^ {}].
	^ self aactionsApi actionsFor: self selectedClass
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'TA 7/14/2022 10:41'
}
ABrowser >> buildWith: aToolBuilder [

	| windowSpec enumListSpec mainListSpec |
	windowSpec := aToolBuilder pluggableWindowSpec new
		model: self;
		label: #windowLabel;
		children: OrderedCollection new.
	
	enumListSpec := aToolBuilder pluggableListSpec new
		model: self;
		list: #classNames;
		keystrokePreview: #enumListkeyPress:list:;
		name: #leftSideClassList;
		getIndex: #classIndex; 
		setIndex: #classIndex:; 
		helpItem: #itemName:;
		frame: (0@0 corner: 0.25@1).
		
	mainListSpec := self createMainListSpecWith: aToolBuilder.
		
	windowSpec children 
		add: enumListSpec;
		add: mainListSpec.
	
	^ aToolBuilder buildPluggableWindow: windowSpec
	


]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 13:49'
}
ABrowser >> classIndex [

	^ classIndex
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 18:53'
}
ABrowser >> classIndex: anObject [

	classIndex := anObject.
	self changed: #classIndex.
	self changed: #mainView
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'TA 7/14/2022 11:42'
}
ABrowser >> classNames [
	
	^ self classes collect: [:each | (each respondsTo: #alternativeActionsClassName) ifTrue: [each alternativeActionsClassName] ifFalse: [each name]]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/6/2022 23:49'
}
ABrowser >> classes [

	^ self aactionsApi classesWithActions
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'TA 5/7/2022 15:27'
}
ABrowser >> createButtonPanelSpecWith: aToolBuilder [

	^  aToolBuilder pluggablePanelSpec new
		model: self;
		children: (self createButtonSpecsWith: aToolBuilder);
		frame: (0@0 corner: 1@self buttonPanelHeight);
		layout: #horizontal;
		yourself
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'TA 5/7/2022 15:25'
}
ABrowser >> createButtonSpecWith: aToolBuilder named: aString action: actionSymbol enabled: aSymbol [

	^ aToolBuilder pluggableButtonSpec new
		model: self;
		label: aString;
		action: actionSymbol;
		enabled: aSymbol;
		yourself
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 9/26/2020 13:47'
}
ABrowser >> createMainListSpecWith: aToolBuilder [

	self subclassResponsibility
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/4/2022 15:37'
}
ABrowser >> enumListkeyPress: evt list: aList [
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 9/29/2020 22:19'
}
ABrowser >> hasClassSelected [

	^ self classIndex ~= 0
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MaCl 5/21/2022 10:49'
}
ABrowser >> initialize [

	super initialize.
	AActions initializeIfNeccessary.
	self classIndex: 1
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'TA 7/14/2022 11:44'
}
ABrowser >> itemName: anInteger [

	^ (self classes at: anInteger) name
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 18:55'
}
ABrowser >> mainView [

	self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/30/2020 02:04'
}
ABrowser >> selectedClass [

	^ self classes at: self classIndex ifAbsent: [nil]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'WoC 9/30/2020 11:32'
}
ABrowser >> update: aSymbol [

	aSymbol = #renamedClass
		ifTrue: [| index |
			index := self classIndex.
			self changed: #classes.
			self classIndex: index].
		
	aSymbol = #methods
		ifTrue: [self changed: #mainView]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 13:48'
}
ABrowser >> windowLabel [

	self subclassResponsibility
]
