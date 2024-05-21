Class {
	#name : #AMockActionAddLineAsList,
	#superclass : #AMockActions,
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 8/4/2022 18:37'
}
AMockActionAddLineAsList class >> actions [ 

	<wantsTestDefaultActions>
	^ { 
		self mockActionAddLineAsList.
	} collect: [:each | AAction createActions: each]
]
