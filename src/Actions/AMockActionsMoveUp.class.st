Class {
	#name : #AMockActionsMoveUp,
	#superclass : #AMockActions,
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'wb 7/14/2022 10:38'
}
AMockActionsMoveUp class >> actions [ 

	<wantsDuplicateTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction createActions: each]
]

{
	#category : #actions,
	#'squeak_changestamp' : 'wb 7/14/2022 10:38'
}
AMockActionsMoveUp class >> actionsDuplicate [

	<wantsDuplicateTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction createActions: each]
]
