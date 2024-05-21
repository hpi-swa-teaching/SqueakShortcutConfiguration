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
	#'squeak_changestamp' : 'MaCl 5/23/2022 09:59'
}
ShortcutBrowserTests >> removeAShortcutBrowserWindows [

	(SystemWindow windowsIn: World satisfying: [:w | w label = 'Shortcut Browser']) do: [:each |
		each model canDiscardEdits ifTrue: [each delete]].
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:16'
}
ShortcutBrowserTests >> setUp [

	self shortcutBrowser: AShortcutBrowser new
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
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:16'
}
ShortcutBrowserTests >> tearDown [

	self shortcutBrowser: nil
]

{
	#category : #opening,
	#'squeak_changestamp' : 'MaCl 5/23/2022 09:32'
}
ShortcutBrowserTests >> testClassInitialization [

	AShortcutBrowser initialize.
	self assert: true equals: (TheWorldMenu registry includes: 
	{'Shortcut Browser'. {AShortcutBrowser . #open}})
]

{
	#category : #buttons,
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:49'
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
	#'squeak_changestamp' : 'MaCl 5/23/2022 09:58'
}
ShortcutBrowserTests >> testWindowCreation [

	self removeAShortcutBrowserWindows	.
	AShortcutBrowser open.
	self assert: (SystemWindow windowsIn: World satisfying: [:w | w label = 'Shortcut Browser']) size
		equals: 1.
	self removeAShortcutBrowserWindows	
	
	
]
