Class {
	#name : #ATestAGlobalActions,
	#superclass : #AGlobalActions,
	#category : #'Actions-Test'
}

{
	#category : #'global actions',
	#'squeak_changestamp' : 'KK 8/4/2022 19:47'
}
ATestAGlobalActions class >> globalActions [

	^{  
		{'Remove' . #removeDefault . 'Removes the currently selected item'. $r . #cmdPressed}.
	}collect: [:each | ATestAGlobalAction createActions: each]
	
]
