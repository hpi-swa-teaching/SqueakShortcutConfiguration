"
Specifies the interface that classes configurable with ShortcutRegistry should implement
"
Class {
	#name : #ConfigurableExampleClass,
	#superclass : #Morph,
	#classVars : [
		'ConfiguredShortcuts'
	],
	#category : #SqueakShortcutConfiguration,
	#'squeak_changestamp' : 'MZ 6/4/2024 11:21'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 14:37'
}
ConfigurableExampleClass class >> ConfigurableShortcutMethods [
	^ #(exampleShortcutActions:)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 14:42'
}
ConfigurableExampleClass class >> ConfiguredShortcuts [
	ConfiguredShortcuts isNil ifTrue: [self setDefaultShortcuts].
	^ ConfiguredShortcuts
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 14:43'
}
ConfigurableExampleClass class >> setDefaultShortcuts [
	ConfiguredShortcuts := Dictionary new.
	ConfiguredShortcuts at: $ä put: #exampleShortcutAction:
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 14:59'
}
ConfigurableExampleClass class >> setShortcut: aKey for: aMethod [
	ConfiguredShortcuts keysAndValuesRemove: [:key :method | method == aMethod].
	ConfiguredShortcuts at: aKey put: aMethod
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 12:00'
}
ConfigurableExampleClass >> exampleShortcutAction: aKeyboardEvent [
	Transcript show: 'ConfigurableExampleClass#exampleShortcutAction called'; cr.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 11:41'
}
ConfigurableExampleClass >> handlesKeyboard: evt [
	^ true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 14:48'
}
ConfigurableExampleClass >> keyStroke: evt [
	(evt controlKeyPressed and: (self class ConfiguredShortcuts includesKey: evt keyCharacter))
		ifTrue: [self perform: (self class ConfiguredShortcuts at: evt keyCharacter) with: evt].
]
