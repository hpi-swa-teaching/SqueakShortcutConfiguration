Class {
	#name : #ShortcutRegistry,
	#superclass : #Object,
	#classVars : [
		'ConfigurableClasses'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 11:19'
}
ShortcutRegistry class >> ConfigurableClasses [
	^ ConfigurableClasses
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 12:17'
}
ShortcutRegistry class >> initialize [
	super initialize.
	
	ConfigurableClasses := #(ConfigurableExampleClass class)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 12:17'
}
ShortcutRegistry class >> open [
	"TODO: open ShortcutRegistryUI"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 14:33'
}
ShortcutRegistry class >> register: aClass [
	ConfigurableClasses add: aClass
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/4/2024 14:33'
}
ShortcutRegistry class >> unregister: aClass [
	ConfigurableClasses remove: aClass
]
