Class {
	#name : #MockActionsD,
	#superclass : #MockActions,
	#category : 'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'wb 7/14/2022 10:38'
}
MockActionsD class >> actions [ 

	<wantsTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction createActions: each]
]
