Class {
	#name : #TestClass,
	#superclass : #Object,
	#classVars : [
		'Action1',
		'Action2'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/14/2024 13:23'
}
TestClass class >> sscActions [
	Action1 ifNil: [Action1 := SSC_Action new title: 'Test Action 1'].
	Action2 ifNil: [Action2 := SSC_Action new title: 'Test Action 2'].
	^ {Action1. Action2}
]
