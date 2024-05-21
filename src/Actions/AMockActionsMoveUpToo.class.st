Class {
	#name : #AMockActionsMoveUpToo,
	#superclass : #AMockActions,
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'wb 7/14/2022 10:38'
}
AMockActionsMoveUpToo class >> actions [ 

	<wantsDuplicateTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction createActions: each]
]
