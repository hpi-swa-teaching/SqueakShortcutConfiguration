Class {
	#name : #MenuBrowserTests,
	#superclass : #ActionsTest,
	#category : #'Actions-Test'
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
	#'squeak_changestamp' : 'KK 6/7/2022 00:03'
}
MenuBrowserTests >> testWindowCreation [

	self removeAMenuBrowserWindows	.
	ATestMenuBrowser open.
	self assert: (self systemWindowsInclude: 'Menu Browser').
	self removeAMenuBrowserWindows	
]
