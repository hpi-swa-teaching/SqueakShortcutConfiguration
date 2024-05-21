Class {
	#name : #MockActionsC,
	#superclass : #MockActions,
	#category : 'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/6/2022 16:08'
}
MockActionsC class >> actions [ 

	<wantsDuplicateTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction from: each]
]
