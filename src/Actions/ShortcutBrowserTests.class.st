Class {
	#name : #ShortcutBrowserTests,
	#superclass : #ActionsTest,
	#instVars : [
		'shortcutBrowser'
	],
	#category : #'Actions-Test'
}

{
	#category : #history,
	#'squeak_changestamp' : 'wb 6/22/2022 16:45'
}
ShortcutBrowserTests class >> lastStoredRun [
	^ ((Dictionary new) add: (#duration->0); add: (#errors->((Set new) add: #testWindowCreation; yourself)); add: (#passed->((Set new) add: #testClassInitialization; add: #testHelpWindow; yourself)); add: (#failures->((Set new))); add: (#timeStamp->'22 June 2022 4:16:35.86868 pm' asTimeStamp); add: (#durations->((Dictionary new) add: (#testWindowCreation->nil); add: (#testClassInitialization->0); add: (#testHelpWindow->0); yourself)); yourself)
]

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 6/23/2022 17:39'
}
ShortcutBrowserTests >> removeAShortcutBrowserWindows [

	(self systemWindowsFor: ATestShortcutBrowser windowLabel) do: [:each |
		each model canDiscardEdits ifTrue: [each delete]].
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/27/2022 16:13'
}
ShortcutBrowserTests >> setUp [
	
	super setUp.
	
	self shortcutBrowser: ATestShortcutBrowser new.
	ATestAActions pragmaKeywords: { #wantsTestActions }.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:15'
}
ShortcutBrowserTests >> shortcutBrowser [
	^ shortcutBrowser
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:15'
}
ShortcutBrowserTests >> shortcutBrowser: anObject [
	shortcutBrowser := anObject
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/6/2022 23:59'
}
ShortcutBrowserTests >> tearDown [

	self shortcutBrowser: nil.
]

{
	#category : #opening,
	#'squeak_changestamp' : 'KK 6/27/2022 16:17'
}
ShortcutBrowserTests >> testClassInitialization [

	AShortcutBrowser initialize.
	self assert: true equals: (TheWorldMenu registry includes: 
	{AShortcutBrowser windowLabel. {AShortcutBrowser . #open}})
]

{
	#category : #buttons,
	#'squeak_changestamp' : 'KK 6/27/2022 16:17'
}
ShortcutBrowserTests >> testHelpWindow [

	| world helpWindow |
	helpWindow := self shortcutBrowser helpMenu.
	world := (PasteUpMorph newWorldForProject: nil).
	helpWindow openInWorld: world.

	self assert: (helpWindow) equals: (world submorphOfClass: DialogWindow)
	
]

{
	#category : #opening,
	#'squeak_changestamp' : 'KK 6/23/2022 17:39'
}
ShortcutBrowserTests >> testWindowCreation [

	self removeAShortcutBrowserWindows	.
	ATestShortcutBrowser open.
	self assert: (self systemWindowsInclude: ATestShortcutBrowser windowLabel).
	self removeAShortcutBrowserWindows	
	
	
]
