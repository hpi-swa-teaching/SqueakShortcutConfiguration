Class {
	#name : #ShortcutBrowserTests,
	#superclass : #ActionsTest,
	#instVars : [
		'shortcutBrowser'
	],
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 6/7/2022 00:04'
}
ShortcutBrowserTests >> removeAShortcutBrowserWindows [

	(self systemWindowsFor: 'Shortcut Browser') do: [:each |
		each model canDiscardEdits ifTrue: [each delete]].
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/6/2022 23:59'
}
ShortcutBrowserTests >> setUp [
	
	super setUp.
	
	self shortcutBrowser: ATestMenuBrowser new.
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
	#'squeak_changestamp' : 'KK 6/6/2022 23:59'
}
ShortcutBrowserTests >> testClassInitialization [

	ATestShortcutBrowser initialize.
	self assert: true equals: (TheWorldMenu registry includes: 
	{'Shortcut Browser'. {ATestShortcutBrowser . #open}})
]

{
	#category : #buttons,
	#'squeak_changestamp' : 'KK 5/31/2022 11:25'
}
ShortcutBrowserTests >> testHelpWindow [

	"| world helpWindow |
	helpWindow := self shortcutBrowser helpMenu.
	world := (PasteUpMorph newWorldForProject: nil).
	helpWindow openInWorld: world.
	world submorphOfClass: DialogWindow.
	self assert: (helpWindow) equals: (world submorphOfClass: DialogWindow)"
	
]

{
	#category : #opening,
	#'squeak_changestamp' : 'KK 6/7/2022 00:05'
}
ShortcutBrowserTests >> testWindowCreation [

	self removeAShortcutBrowserWindows	.
	ATestShortcutBrowser open.
	self assert: (self systemWindowsInclude: 'Shortcut Browser').
	self removeAShortcutBrowserWindows	
	
	
]
