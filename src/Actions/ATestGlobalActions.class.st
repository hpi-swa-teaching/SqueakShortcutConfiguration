Class {
	#name : #ATestGlobalActions,
	#superclass : #AGlobalActions,
	#category : 'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 7/26/2022 20:35'
}
ATestGlobalActions class >> action1 [ 

	^ {'Move up' . #moveUp . 'Moves the currently selected items above the items over it' . $p . #cmdPressed }
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 7/26/2022 20:35'
}
ATestGlobalActions class >> action2 [

	^ {'Move Down' . #moveDown . 'Moves the currently selected items under the items under it' }
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 7/26/2022 20:35'
}
ATestGlobalActions class >> globalActions [

	^{   
		self action1 .
		self action2 
	}collect: [:each | AGlobalAction createActions: each]
	
]
