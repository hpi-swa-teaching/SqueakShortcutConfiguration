Class {
	#name : #MockActionsB,
	#superclass : #MockActions,
	#category : 'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/6/2022 16:08'
}
MockActionsB class >> actions [ 

	<wantsDuplicateTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction from: each]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/6/2022 16:08'
}
MockActionsB class >> actionsDuplicate [

	<wantsDuplicateTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction from: each]
]
