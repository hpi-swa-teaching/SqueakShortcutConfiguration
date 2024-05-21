"
Actions that behave the same in different classes
"
Class {
	#name : #AGlobalAction,
	#superclass : #AAction,
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:41'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 7/11/2022 16:36'
}
AGlobalAction class >> from: aCollection in: aClass [
|aGlobalActionShortcutPair aGlobalAction aShortcut|

	aGlobalActionShortcutPair := AGlobalActions globalActionFrom: aCollection first.
	aGlobalAction := aGlobalActionShortcutPair first.
	aShortcut := aGlobalActionShortcutPair second.
	
	aGlobalAction clazz: aClass.
	(aCollection size = 2)
		ifTrue:[ aGlobalAction action: aCollection second].
		
	^aGlobalActionShortcutPair
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:31'
}
AGlobalAction >> isGlobal [

	^true
]
