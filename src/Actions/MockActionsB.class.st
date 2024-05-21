Class {
	#name : #MockActionsB,
	#superclass : #MockActions,
	#category : 'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'wb 7/14/2022 10:38'
}
MockActionsB class >> actions [ 

	<wantsDuplicateTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction createActions: each]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'wb 7/14/2022 10:38'
}
MockActionsB class >> actionsDuplicate [

	<wantsDuplicateTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction createActions: each]
]
