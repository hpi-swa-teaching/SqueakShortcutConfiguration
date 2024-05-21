"
Class to display infos to user
"
Class {
	#name : #ADialog,
	#superclass : #Model,
	#instVars : [
		'result'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:33'
}

{
	#category : #'button actions',
	#'squeak_changestamp' : 'WoC 10/15/2020 12:11'
}
ADialog >> accept [

	self setResult.
	self changed: #close
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'KK 6/14/2022 17:37'
}
ADialog >> buildWith: aToolBuilder [

	| dialogSpec panelSpec |
	dialogSpec := self createDialogSpecWith: aToolBuilder.
	panelSpec := self createPanelSpecWith: aToolBuilder.
	
	dialogSpec children add: panelSpec.
	dialogSpec buttons addAll: (self createButtonSpecsWith: aToolBuilder).
	
	^ aToolBuilder buildPluggableDialog: dialogSpec
]

{
	#category : #'button actions',
	#'squeak_changestamp' : 'WoC 10/9/2020 15:08'
}
ADialog >> cancel [

	self changed: #close
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 10/15/2020 00:45'
}
ADialog >> createButtonSpecsWith: aToolBuilder [
		
	^ {
		{'cancel' . #cancel}.
		{'ok' . #accept}
	} collect: [:each | aToolBuilder pluggableButtonSpec new
		model: self;
		label: each first;
		color: (self userInterfaceTheme cancelColor ifNil: [Color r: 1 g: 0.6 b: 0.588]);
		action: each second]
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 10/15/2020 01:36'
}
ADialog >> createDialogSpecWith: aToolBuilder [

	^ aToolBuilder pluggableDialogSpec new
		model: self;
		title: #title;
		wantsResizeHandles: false;
		children: OrderedCollection new;
		buttons: OrderedCollection new;
		yourself
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'KK 6/14/2022 17:10'
}
ADialog >> createPanelSpecWith: aToolBuilder [

	^ aToolBuilder pluggablePanelSpec new
		model: self;
		frame: (0@0 corner: 1@1);
		name: #content;
		children: OrderedCollection new;
		yourself

]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 12:11'
}
ADialog >> result [

	^ result
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 12:11'
}
ADialog >> result: anObject [

	result := anObject.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 12:11'
}
ADialog >> setResult [

	self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/9/2020 15:16'
}
ADialog >> title [

	self subclassResponsibility
]
