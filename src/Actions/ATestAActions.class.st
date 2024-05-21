Class {
	#name : #ATestAActions,
	#superclass : #AActions,
	#classVars : [
		'PragmaKeywords'
	],
	#category : #'Actions-Test'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/6/2022 23:56'
}
ATestAActions class >> pragmaKeywords [
	^ PragmaKeywords
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/6/2022 23:56'
}
ATestAActions class >> pragmaKeywords: anObject [
	PragmaKeywords := anObject
]
