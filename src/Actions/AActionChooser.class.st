"
Class for selecting actions in MenuBrowser drop-down menu
"
Class {
	#name : #AActionChooser,
	#superclass : #ADialog,
	#instVars : [
		'actionHolder',
		'selectedItem',
		'selectedPath'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:32'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/14/2020 22:27'
}
AActionChooser class >> getUserChoiceFor: anObject [

	| dialog |
	dialog := self new
		actionHolder: anObject;
		yourself.
	ToolBuilder open: dialog.
	^ dialog result
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/14/2020 22:26'
}
AActionChooser >> actionHolder [

	^ actionHolder
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/14/2020 22:26'
}
AActionChooser >> actionHolder: anObject [

	actionHolder := anObject.
]

{
	#category : #navigating,
	#'squeak_changestamp' : 'WoC 10/14/2020 22:28'
}
AActionChooser >> actionRoots [

	^ AActions actionsFor: self actionHolder
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 10/15/2020 02:02'
}
AActionChooser >> createPanelSpecWith: aToolBuilder [

	| panelSpec |
	panelSpec := super createPanelSpecWith: aToolBuilder.
	panelSpec children add: (self createTreeSpecWith: aToolBuilder).
	^ panelSpec
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 10/15/2020 02:02'
}
AActionChooser >> createTreeSpecWith: aToolBuilder [

	^ aToolBuilder pluggableTreeSpec new
		model: self;
		roots: #actionRoots;
		hasChildren: #hasChildren:;
		getChildren: #getChildren:;
		getSelected: #selectedItem;
		setSelected: #selectedItem:;
		getSelectedPath: #selectedPath;
		setSelectedPath: #selectedPath:;
		help: #helpFor:;
		frame: (0@0 corner: 1@1)
		yourself
]

{
	#category : #navigating,
	#'squeak_changestamp' : 'WoC 10/14/2020 22:47'
}
AActionChooser >> getChildren: anObject [

	^ anObject actions
]

{
	#category : #navigating,
	#'squeak_changestamp' : 'WoC 10/14/2020 22:46'
}
AActionChooser >> hasChildren: anObject [

	^ anObject isKindOf: AActionGroup
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'WoC 10/15/2020 00:27'
}
AActionChooser >> helpFor: anAction [

	^ anAction description

	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/14/2020 22:33'
}
AActionChooser >> selectedItem [

	^ selectedItem
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/14/2020 22:44'
}
AActionChooser >> selectedItem: anObject [

	selectedItem := anObject.
	self changed: #selectedItem
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/14/2020 22:33'
}
AActionChooser >> selectedPath [

	^ selectedPath
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/14/2020 22:44'
}
AActionChooser >> selectedPath: anObject [

	selectedPath := anObject.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 12:12'
}
AActionChooser >> setResult [

	self result: self selectedItem
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/9/2020 15:16'
}
AActionChooser >> title [

	^ 'Action chooser'
]
