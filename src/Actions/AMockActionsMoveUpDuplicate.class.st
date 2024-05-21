Class {
	#name : #AMockActionsMoveUpDuplicate,
	#superclass : #AMockActions,
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'wb 7/14/2022 10:38'
}
AMockActionsMoveUpDuplicate class >> actions [ 

	<wantsDuplicateTestActions>
	^ { 
		(self mockActionMoveUpAsList) .
		(self mockActionMoveUpAsList) .
	} collect: [:each | AAction createActions: each]
]
