Class {
	#name : #AMockGlobalRemoveSpecialActions,
	#superclass : #AMockActions,
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 8/4/2022 20:01'
}
AMockGlobalRemoveSpecialActions class >> globalActions [

	<wantsTestGlobalActions>

	^{   
		{'Remove' . #removeSpecial}.
	}collect: [:each | AGlobalAction from: each in: self]
]

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 8/4/2022 19:53'
}
AMockGlobalRemoveSpecialActions class >> globalRemoveAction [

	^ self globalActions first
]
