Class {
	#name : #MockActions,
	#superclass : #Object,
	#category : #'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/7/2022 10:33'
}
MockActions class >> mockActionMoveDownAsList [

	^ {'Move Down Test' .#moveDown . 'Moves the currently selected items under the items under it' }
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'TA 5/31/2022 10:29'
}
MockActions class >> mockActionMoveUpAsList [

	^ {'Move Up Test' .#moveDown . 'Moves the currently selected items under the items under it' }
	
]
