Class {
	#name : #MockActionsD,
	#superclass : #MockActions,
	#category : #'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/6/2022 17:04'
}
MockActionsD class >> actions [ 

	<wantsTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction from: each]
]
