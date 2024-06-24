Class {
	#name : #'SSC_Dialog',
	#superclass : #Model,
	#instVars : [
		'result'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:32'
}
SSC_Dialog >> accept [ 

	self setResult.
	self changed: #close
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'yl 6/22/2024 19:32'
}
SSC_Dialog >> buildWith: aToolBuilder [

	| dialogSpec panelSpec |
	
	dialogSpec := self createDialogSpecWith: aToolBuilder.
	panelSpec := self createPanelSpecWith: aToolBuilder.
	
	dialogSpec children add: panelSpec.
	dialogSpec buttons addAll: (self createButtonSpecsWith: aToolBuilder).
	
	^ aToolBuilder buildPluggableDialog: dialogSpec
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:33'
}
SSC_Dialog >> buttonColor [ 

	^ Color r: 1 g: 0.6 b: 0.588
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:33'
}
SSC_Dialog >> cancel [

	self changed: #close
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'yl 6/22/2024 19:33'
}
SSC_Dialog >> createButtonSpecsWith: aToolBuilder [ 
		
	^ {
		{'cancel' . #cancel}.
		{'ok' . #accept}
	} collect: [:each | aToolBuilder pluggableButtonSpec new
		model: self;
		label: each first;
		color: (self userInterfaceTheme cancelColor ifNil: [self buttonColor]);
		action: each second]

]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'MZ 6/23/2024 16:41'
}
SSC_Dialog >> createDialogSpecWith: aToolBuilder [

	^ aToolBuilder pluggableDialogSpec new
		model: self;
		name: #sscDialog;
		title: #title;
		wantsResizeHandles: false;
		children: OrderedCollection new;
		buttons: OrderedCollection new;
		yourself
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'yl 6/22/2024 19:34'
}
SSC_Dialog >> createPanelSpecWith: aToolBuilder [ 

	^ aToolBuilder pluggablePanelSpec new
		model: self;
		frame: (0@0 corner: 1@1);
		name: #content;
		children: OrderedCollection new;
		yourself
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:34'
}
SSC_Dialog >> result [ 

	^ result
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:34'
}
SSC_Dialog >> result: anObject [ 

	result := anObject.

]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:34'
}
SSC_Dialog >> setResult [ 

	self subclassResponsibility
]

{
	#category : #'user interface',
	#'squeak_changestamp' : 'yl 6/22/2024 19:34'
}
SSC_Dialog >> title [ 

	self subclassResponsibility
]
