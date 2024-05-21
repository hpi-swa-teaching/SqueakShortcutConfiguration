"
Class to build Menus
"
Class {
	#name : #AMenuBrowser,
	#superclass : #ABrowser,
	#instVars : [
		'tree',
		'selectedPath',
		'selectedItem'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:34'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'ft 8/5/2022 16:21'
}
AMenuBrowser class >> actions [

	<wantsActions>

	^{   
		{'Move Down' . #moveDown . 'Moves the currently selected items under the item under it'}.
		{'Add line' . #addSeparator . 'Adds a seperator/line'. $a . #cmdPressed}.
		{'Move up' . #moveUp . 'Moves the currently selected items over the item over it'}.
		{'Add...' . #addAction . 'Opens a dialog to select actions to be added to the list'}
	}collect: [:each | AAction createActions: each]
	
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MaCl 8/4/2022 17:11'
}
AMenuBrowser class >> alternativeActionsClassName [

	^'Menu-Browser'
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MaCl 8/4/2022 16:57'
}
AMenuBrowser class >> globalActions [

	<wantsActions>

	^{   
		{'Remove' . #removeItem}.
	}collect: [:each | AGlobalAction from: each in: self]
	
]

{
	#category : #'manipulate menu',
	#'squeak_changestamp' : 'WoC 10/15/2020 00:02'
}
AMenuBrowser >> addAction [

	| action |
	action := AActionChooser getUserChoiceFor: self selectedClass.
	action ifNotNil: [self addNode: action asTreeNode]
]

{
	#category : #'manipulate menu',
	#'squeak_changestamp' : 'WoC 10/15/2020 14:04'
}
AMenuBrowser >> addNode: anObject [

	self withMenuDo: [:menu | | node |
		node := anObject.
		self selectedItem
			ifNil: [menu addChild: node]
			ifNotNil: [menu addChild: node after: self selectedItem].
		self selectedItem: node]
]

{
	#category : #'manipulate menu',
	#'squeak_changestamp' : 'WoC 9/29/2020 12:08'
}
AMenuBrowser >> addSeparator [

	self addNode: ATreeNode seperator
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 20:10'
}
AMenuBrowser >> buttonPanelHeight [

	^ 0.05
]

{
	#category : #testing,
	#'squeak_changestamp' : 'TA 8/4/2022 09:49'
}
AMenuBrowser >> canMoveDown [

	| items |
	
	self selectedPath 
		ifNil: [^ false];
		ifEmpty: [^ false].
	items := self currentLevelItems.		
	^ (items indexOf: self selectedItem) < items size
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 10/15/2020 02:53'
}
AMenuBrowser >> canMoveUp [
	
	self selectedPath 
		ifNil: [^ false];
		ifEmpty: [^ false].
	^ (self currentLevelItems indexOf: self selectedItem) > 1
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 9/26/2020 22:28'
}
AMenuBrowser >> canRemove [

	^ self selectedItem notNil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 14:08'
}
AMenuBrowser >> classIndex: anObject [

	super classIndex: anObject.
	self selectedItem: nil
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 10/15/2020 02:44'
}
AMenuBrowser >> createButtonSpecsWith: aToolBuilder [

	^ {
		{'add' . #openAddMenu . nil} . 
		{'remove' . #removeItem . #canRemove} . 
		{'moveUp' . #moveUp . #canMoveUp} . 
		{'moveDown' . #moveDown . #canMoveDown}} 
		collect: [:each | 
			self 
				createButtonSpecWith: aToolBuilder 
				named: each first
				action: each second
				enabled: each third]
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'ft 8/5/2022 16:17'
}
AMenuBrowser >> createMainListSpecWith: aToolBuilder [

	| mainPanel |
	mainPanel := aToolBuilder pluggablePanelSpec new
		model: self;
		children: OrderedCollection new;
		frame: self positionMainList;
		yourself.
		
	mainPanel children
		add: (self createButtonPanelSpecWith: aToolBuilder);
		add: (self createTreeSpecWith: aToolBuilder).
	
	^ mainPanel

]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 10/15/2020 03:03'
}
AMenuBrowser >> createTreeSpecWith: aToolBuilder [

	^ aToolBuilder pluggableTreeSpec new
		model: self;
		roots: #mainView;
		hasChildren: #hasChildren:;
		getChildren: #getChildren:;
		getSelected: #selectedItem;
		setSelected: #selectedItem:;
		getSelectedPath: #selectedPath;
		setSelectedPath: #selectedPath:;
		help: #helpFor:;
		keyPress: #keyPress:tree:event:;
		frame: (0@self buttonPanelHeight corner: 1@1);
		yourself
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'WoC 10/15/2020 02:53'
}
AMenuBrowser >> currentLevelItems [

	| index items |
	index := self selectedPath size.
	items := self mainView.
	[index > 1]
		whileTrue: [items := self getChildren: (self selectedPath at: index). index := index - 1].
		
	^ items
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/6/2022 23:49'
}
AMenuBrowser >> currentMenu [

	^ self aactionsApi menuStructureFor: self selectedClass
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 00:10'
}
AMenuBrowser >> getChildren: aTreeNode [

	^ aTreeNode children
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 10/15/2020 00:10'
}
AMenuBrowser >> hasChildren: aTreeNode [

	^ aTreeNode hasChildren 
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'WoC 10/15/2020 00:23'
}
AMenuBrowser >> helpFor: aTreeNode [

	^ aTreeNode description
]

{
	#category : #'manipulate menu',
	#'squeak_changestamp' : 'TA 8/4/2022 10:15'
}
AMenuBrowser >> keyPress: key tree: aTreeMorph event: evt [

	self aactionsApi shortcutFor: self event: evt
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 00:07'
}
AMenuBrowser >> mainView [

	self tree: Dictionary new.
	^ self currentMenu children
]

{
	#category : #'manipulate menu',
	#'squeak_changestamp' : 'WoC 10/15/2020 03:54'
}
AMenuBrowser >> moveDown [

	| index items itemIndex |
	self selectedPath 
		ifNil: [^ self];
		ifEmpty: [^ self].
	self selectedItem ifNil: [^ self].
	self canMoveDown ifFalse: [^ self].
	index := self selectedPath size.
	items := self mainView.
	[index > 1]
		whileTrue: [items := self getChildren: (self selectedPath at: index). index := index - 1].
		
	itemIndex := (items indexOf: self selectedItem).
	items 
		add: (items remove: self selectedItem)
		afterIndex: itemIndex.
	self 
		changed: #mainView;
		changed: #canMoveUp;
		changed: #canMoveDown
	
]

{
	#category : #'manipulate menu',
	#'squeak_changestamp' : 'WoC 10/15/2020 03:54'
}
AMenuBrowser >> moveUp [

	| index items itemIndex |
	self selectedPath 
		ifNil: [^ self];
		ifEmpty: [^ self].
	self selectedItem ifNil: [^ self].
	self canMoveUp ifFalse: [^ self].
	index := self selectedPath size.
	items := self mainView.
	[index > 1]
		whileTrue: [items := self getChildren: (self selectedPath at: index). index := index - 1].
		
	itemIndex := (items indexOf: self selectedItem).
	items 
		add: (items remove: self selectedItem)
		beforeIndex: itemIndex - 1.
	self 
		changed: #mainView;
		changed: #canMoveUp;
		changed: #canMoveDown
	
]

{
	#category : #toolbuilder,
	#'squeak_changestamp' : 'WoC 9/26/2020 22:51'
}
AMenuBrowser >> openAddMenu [

	| builder spec |
	builder := ToolBuilder default.
	spec := builder pluggableMenuSpec new.
	
	spec add: 'Add Action...' target: self selector: #addAction argumentList: #().
	spec add: 'Add Separator' target: self selector: #addSeparator argumentList: #().
	
	builder runModal: (builder open: spec)
]

{
	#category : #default,
	#'squeak_changestamp' : 'ft 8/5/2022 16:17'
}
AMenuBrowser >> positionMainList [

	^ 0.25@0 corner: 1@1
]

{
	#category : #'manipulate menu',
	#'squeak_changestamp' : 'MaCl 6/13/2022 14:14'
}
AMenuBrowser >> removeItem [

	self withMenuDo: [:menu | self canRemove ifTrue:
		[menu removeChild: self selectedItem].
		self selectedItem: nil]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 19:47'
}
AMenuBrowser >> selectedItem [

	^ selectedItem
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 02:07'
}
AMenuBrowser >> selectedItem: anObject [

	selectedItem := anObject.
	self 
		changed: #selectedItem;
		changed: #canRemove;
		changed: #canMoveUp;
		changed: #canMoveDown
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 19:43'
}
AMenuBrowser >> selectedPath [

	^ selectedPath
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 10/15/2020 02:33'
}
AMenuBrowser >> selectedPath: anObject [

	selectedPath := anObject.
	self 
		changed: #canMoveUp;
		changed: #canMoveDown
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 19:24'
}
AMenuBrowser >> tree [

	^ tree
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 19:24'
}
AMenuBrowser >> tree: anObject [

	tree := anObject.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 13:48'
}
AMenuBrowser >> windowLabel [

	^ 'Menu Browser'
]

{
	#category : #'manipulate menu',
	#'squeak_changestamp' : 'WoC 10/15/2020 14:03'
}
AMenuBrowser >> withMenuDo: aBlock [

	| menu |
	menu := self currentMenu.
	aBlock value: (menu followPath: (self selectedPath ifNil: [{}])).
	AActions setMenuFor: self selectedClass to: menu.
	self changed: #mainView
]
