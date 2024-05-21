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
	#category : #create,
	#'squeak_changestamp' : 'KK 8/4/2022 19:41'
}
AGlobalAction class >> from: aCollection in: aClass [

	| aGlobalAction |

	aGlobalAction := self globalActionsSource globalActionFrom: aCollection first.
	aGlobalAction clazz: aClass.
	(aCollection size = 2) ifTrue:[ aGlobalAction action: aCollection second].
		
	^ aGlobalAction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 8/4/2022 19:41'
}
AGlobalAction class >> globalActionsSource [
	
	^ AGlobalActions
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MatthisCl 7/12/2022 15:31'
}
AGlobalAction >> isGlobal [

	^true
]
