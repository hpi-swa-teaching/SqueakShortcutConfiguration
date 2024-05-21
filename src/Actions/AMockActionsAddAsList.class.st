Class {
	#name : #AMockActionsAddAsList,
	#superclass : #AMockActions,
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'MaCl 8/3/2022 18:20'
}
AMockActionsAddAsList class >> actions [ 

	<wantsDuplicateTestActions>
	^ { 
		self mockActionAddAsList.
	} collect: [:each | AAction createActions: each]
]
