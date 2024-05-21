Class {
	#name : #AMockGlobalRemoveActions,
	#superclass : #AMockActions,
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 8/4/2022 20:01'
}
AMockGlobalRemoveActions class >> globalActions [

	<wantsTestGlobalActions>

	^{   
		{'Remove'}.
	}collect: [:each | AGlobalAction from: each in: self]
]

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 8/4/2022 20:03'
}
AMockGlobalRemoveActions class >> globalRemoveAction [

	^ self globalActions first
]
