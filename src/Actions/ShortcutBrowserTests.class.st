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
	#category : #opening,
	#'squeak_changestamp' : 'KK 6/23/2022 17:39'
}
ShortcutBrowserTests >> removeAShortcutBrowserWindows [

	(self systemWindowsFor: ATestShortcutBrowser windowLabel) do: [:each |
		each model canDiscardEdits ifTrue: [each delete]].
]

{
	#category : #running,
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
	#category : #running,
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:24'
}
ShortcutBrowserTests >> tearDown [

	self shortcutBrowser: nil.
	ATestAActions reset
]

{
	#category : #helptext,
	#'squeak_changestamp' : 'TA 8/4/2022 16:26'
}
ShortcutBrowserTests >> testActionBallonText [

	| helpText |
	
	helpText:= self shortcutBrowser helpForItem: self shortcutBrowser actionIndex.
	self assert: helpText isString
	
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'TA 7/28/2022 15:48'
}
ShortcutBrowserTests >> testAddShortcut [

	(self shortcutBrowser) addShortcut: self shortcutCtrld.
	self assert: ((ATestAActions shortcutsFor: (self shortcutBrowser selectedAction) in: (self shortcutBrowser selectedClass) ifAbsent: [^false] ) first) equals: self shortcutCtrld
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
	#category : #opening,
	#'squeak_changestamp' : 'MaCl 7/28/2022 11:47'
}
ShortcutBrowserTests >> testCorrectBackend [
	
	|ShortcutBrowser|
	
	ShortcutBrowser := AShortcutBrowser new.
	self assert: (ShortcutBrowser aactionsApi) equals: AActions
]

{
	#category : #buttons,
	#'squeak_changestamp' : 'TA 7/28/2022 11:23'
}
ShortcutBrowserTests >> testHelpWindow [

	| world helpWindow |
	
	helpWindow := self shortcutBrowser helpMenu.
	world := (PasteUpMorph newWorldForProject: nil).
	helpWindow openInWorld: world.

	self assert: (helpWindow) equals: (world submorphOfClass: DialogWindow)
	
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'TA 8/4/2022 19:10'
}
ShortcutBrowserTests >> testListItemsForSelectionWithNoShortcuts [

	AActions reset.
	self assert: self shortcutBrowser listItemsForCurrentSelection equals: #()
]

{
	#category : #shortcuts,
	#'squeak_changestamp' : 'TA 8/4/2022 19:09'
}
ShortcutBrowserTests >> testListItemsForSelectionWithShortcuts [

	AActions reset.
	AActions addShortcut: (self shortcutCtrlb) for: (self shortcutBrowser selectedAction) in: (self shortcutBrowser selectedClass).
	self assert: self shortcutBrowser listItemsForCurrentSelection first equals: #-.
	"disregards the blockclosure part"
	self assert: (self shortcutBrowser listItemsForCurrentSelection second) first equals: 'Remove <Cmd-b>'
]

{
	#category : #helptext,
	#'squeak_changestamp' : 'TA 8/4/2022 16:35'
}
ShortcutBrowserTests >> testNotExistingBallonText [

	| raiseException |
	
	raiseException:= false.
	[self shortcutBrowser helpForItem: 10]
		on: Error
		do: [:error | raiseException:= true].
		
	self assert: raiseException equals: true.
	
	
]

{
	#category : #buttons,
	#'squeak_changestamp' : 'TA 8/4/2022 09:28'
}
ShortcutBrowserTests >> testRemoveShortcut [

	(self shortcutBrowser) addShortcut: self shortcutCtrld.
	(self shortcutBrowser) removeShortcut: self shortcutCtrld.
	self assert: ((ATestAActions shortcutsFor: (self shortcutBrowser selectedAction) in: (self shortcutBrowser selectedClass) ifAbsent: [^false] ) first) equals: false
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

{
	#category : #buttons,
	#'squeak_changestamp' : 'MaCl 7/28/2022 12:05'
}
ShortcutBrowserTests >> testWindowLabel [
	
	|ShortcutBrowser|
	
	ShortcutBrowser := AShortcutBrowser new.
	self assert: (ShortcutBrowser windowLabel) equals: 'Shortcut Browser'
]
