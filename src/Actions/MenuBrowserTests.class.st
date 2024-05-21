Class {
	#name : #MenuBrowserTests,
	#superclass : #ActionsTest,
	#category : 'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:03'
}
MenuBrowserTests >> removeAMenuBrowserWindows [

	(SystemWindow windowsIn: World satisfying: [:w | w label = 'Menu Browser']) do: [:each |
		each model canDiscardEdits ifTrue: [each delete]].
]

{
	#category : #opening,
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:06'
}
MenuBrowserTests >> testWindowCreation [

	self removeAMenuBrowserWindows	.
	AMenuBrowser open.
	self assert: (SystemWindow windowsIn: World satisfying: [:w | w label = 'Menu Browser']) size
		equals: 1.
	self removeAMenuBrowserWindows	
]
