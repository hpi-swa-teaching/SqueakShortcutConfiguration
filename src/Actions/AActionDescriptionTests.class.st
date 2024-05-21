Class {
	#name : #AActionDescriptionTests,
	#superclass : #ActionsTest,
	#category : #'Actions-Test'
}

{
	#category : #comparing,
	#'squeak_changestamp' : 'KK 8/4/2022 20:17'
}
AActionDescriptionTests >> testHash [

	| title actionDescription | 
	
	title := 'Hello :)'.
	actionDescription := AActionDescription new title: title; yourself.
	
	self assert: actionDescription hash equals: title hash
	
	
]
