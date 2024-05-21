Class {
	#name : #MockActionsA,
	#superclass : #MockActions,
	#category : 'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'wb 7/14/2022 10:38'
}
MockActionsA class >> actions [ 

	<wantsDuplicateTestActions>
	^ { 
		(self mockActionMoveUpAsList) .
		(self mockActionMoveUpAsList) .
	} collect: [:each | AAction createActions: each]
]
