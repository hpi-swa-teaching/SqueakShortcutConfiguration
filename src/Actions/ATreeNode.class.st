Class {
	#name : #ATreeNode,
	#superclass : #Object,
	#instVars : [
		'value',
		'children'
	],
	#category : #'Actions-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/29/2020 12:08'
}
ATreeNode class >> seperator [

	^ self value: #-------------
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 9/26/2020 23:14'
}
ATreeNode class >> value: anObject [

	^ self new
		value: anObject;
		yourself
]

{
	#category : #'handle children',
	#'squeak_changestamp' : 'WoC 9/26/2020 22:58'
}
ATreeNode >> addChild: aTreeNode [

	self children add: aTreeNode
]

{
	#category : #'handle children',
	#'squeak_changestamp' : 'WoC 10/15/2020 03:50'
}
ATreeNode >> addChild: aTreeNode after: aChildNode [

	self children add: aTreeNode after: aChildNode
]

{
	#category : #converting,
	#'squeak_changestamp' : 'WoC 10/15/2020 00:06'
}
ATreeNode >> asString [

	^ self isSeperator
		ifTrue: [self value]
		ifFalse: [self value title]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 22:57'
}
ATreeNode >> children [

	^ children
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 22:57'
}
ATreeNode >> children: anObject [

	children := anObject.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/15/2020 00:24'
}
ATreeNode >> description [

	^ self isSeperator
		ifTrue: [nil]
		ifFalse: [self value description]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/14/2020 23:34'
}
ATreeNode >> fill: aMenu for: anObject [

	self children do: [:each | each putOnMenu: aMenu for: anObject]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/15/2020 03:48'
}
ATreeNode >> followPath: aCollection [

	| index node |
	index := aCollection size.
	node := self.
	[index > 1]
		whileTrue: [node := node children detect: [:child | child = (aCollection at: index)]. 
			index := index - 1].
		
	^ node


]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 9/26/2020 22:59'
}
ATreeNode >> hasChildren [ 

	^ self children notEmpty
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'WoC 9/26/2020 22:58'
}
ATreeNode >> initialize [

	self children: OrderedCollection new
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 9/26/2020 23:34'
}
ATreeNode >> isSeperator [

	^ self value isSymbol
]

{
	#category : #printing,
	#'squeak_changestamp' : 'WoC 9/26/2020 23:32'
}
ATreeNode >> printOn: aStream [

	aStream nextPutAll: self asString
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/15/2020 00:34'
}
ATreeNode >> putOnMenu: aMenu for: anObject [

	self isSeperator
		ifTrue: [aMenu addLine. ^ self].
		
	self value isAction
		ifTrue: [aMenu 
					add: self value title , self value shortcutRepresentation
					action: [self value for: anObject].
				"adds help to menu item; add:help:action: is not able to take a block as parameter for action"
				aMenu balloonTextForLastItem: self value description].
		
	self value isActionGroup
		ifTrue: [ | subMenu |
			subMenu := MenuMorph new.
			self fill: subMenu for: anObject.
			aMenu 
				add: self value title 
				subMenu: subMenu]
]

{
	#category : #'handle children',
	#'squeak_changestamp' : 'WoC 9/26/2020 23:40'
}
ATreeNode >> removeChild: anObject [

	self children remove: anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 22:58'
}
ATreeNode >> value [

	^ value
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/26/2020 22:57'
}
ATreeNode >> value: anObject [

	value := anObject.
]
