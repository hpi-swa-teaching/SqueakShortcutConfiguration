Class {
	#name : #AMockActionsMethodWithoutPragma,
	#superclass : #AMockActions,
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'TA 8/4/2022 10:39'
}
AMockActionsMethodWithoutPragma class >> actionOne [

	^self actions first
]

{
	#category : #actions,
	#'squeak_changestamp' : 'wb 7/14/2022 10:38'
}
AMockActionsMethodWithoutPragma class >> actions [ 

	<wantsTestActions>
	^ { 
		self mockActionMoveUpAsList.
	} collect: [:each | AAction createActions: each]
]

{
	#category : #pragma,
	#'squeak_changestamp' : 'KK 8/4/2022 10:32'
}
AMockActionsMethodWithoutPragma class >> methodWithoutActionPragmas [

	<RandomNumberTile>
]

{
	#category : #pragma,
	#'squeak_changestamp' : 'KK 8/4/2022 10:32'
}
AMockActionsMethodWithoutPragma class >> methodWithoutPragma [
]
