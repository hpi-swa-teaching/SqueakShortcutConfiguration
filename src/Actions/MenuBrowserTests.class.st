Class {
	#name : #MenuBrowserTests,
	#superclass : #ActionsTest,
	#category : 'Actions-Test'
}

{
	#category : #history,
	#'squeak_changestamp' : 'wb 6/22/2022 16:45'
}
MenuBrowserTests class >> lastStoredRun [
	^ ((Dictionary new) add: (#duration->42); add: (#errors->((Set new))); add: (#passed->((Set new) add: #testWindowCreation; yourself)); add: (#failures->((Set new))); add: (#timeStamp->'22 June 2022 4:16:35.86868 pm' asTimeStamp); add: (#durations->((Dictionary new) add: (#testWindowCreation->42); yourself)); yourself)
]

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
