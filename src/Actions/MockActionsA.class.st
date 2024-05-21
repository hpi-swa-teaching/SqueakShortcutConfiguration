Class {
	#name : #MockActionsA,
	#superclass : #MockActions,
	#category : #'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/6/2022 16:08'
}
MockActionsA class >> actions [ 

	<wantsDuplicateTestActions>
	^ { 
		(self mockActionMoveUpAsList) .
		(self mockActionMoveUpAsList) .
	} collect: [:each | AAction from: each]
]
