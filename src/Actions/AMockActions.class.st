Class {
	#name : #AMockActions,
	#superclass : #Object,
	#category : #'Actions-Test'
}

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 8/4/2022 16:25'
}
AMockActions class >> addLineAction [

	^ (AAction createActions:  self mockActionAddLineAsList )
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MaCl 8/3/2022 18:16'
}
AMockActions class >> mockActionAddAsList [

	^ {'Add' .#add . 'Adds a line' }
	
]

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 8/4/2022 16:26'
}
AMockActions class >> mockActionAddLineAsList [

	^ {'Add line Test' .#addLine . 'Add a new line' .  $b . #cmdPressed }
	
]

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 6/7/2022 10:33'
}
AMockActions class >> mockActionMoveDownAsList [

	^ {'Move Down Test' .#moveDown . 'Moves the currently selected items under the items under it' }
	
]

{
	#category : #actions,
	#'squeak_changestamp' : 'TA 5/31/2022 10:29'
}
AMockActions class >> mockActionMoveUpAsList [

	^ {'Move Up Test' .#moveDown . 'Moves the currently selected items under the items under it' }
	
]

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 8/4/2022 14:45'
}
AMockActions class >> moveDownAction [

	^ AAction from: self mockActionMoveDownAsList
]

{
	#category : #actions,
	#'squeak_changestamp' : 'KK 8/4/2022 14:45'
}
AMockActions class >> moveUpAction [

	^ AAction from: self mockActionMoveUpAsList
]
