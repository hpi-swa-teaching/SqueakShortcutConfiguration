Class {
	#name : #'SSC_Example3',
	#superclass : #Morph,
	#classInstVars : [
		'SSCActions'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/23/2024 17:19'
}
SSC_Example3 class >> SSCActions [ 
	"Define this method to signal the SSC_ShortcutBrowser that this class has configurable shortcuts.
	Return a set of SSC_Actions specifying the configurable actions and their currently configured shortcuts"
	
	SSCActions ifNil: [SSCActions := self defaultSSCActions].
	^ SSCActions
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MZ 6/18/2024 23:27'
}
SSC_Example3 class >> SSCActions: aCollection [
	"Define this method to allow the SSC_ShortcutBrowser to update the configured shortcuts"
	
	SSCActions := aCollection
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/23/2024 17:15'
}
SSC_Example3 class >> defaultSSCActions [
	"Return a set of SSC_Actions specifying the configurable actions and their default configured shortcuts"
	
	^ {	SSC_Action new method: #action3; key: $b. 
		SSC_Action new method: #action4WithEventAsParameter:; key: $B}
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MZ 6/18/2024 11:59'
}
SSC_Example3 >> action1 [
	Transcript show: 'action1 called'; cr.
]

{
	#category : #actions,
	#'squeak_changestamp' : 'MZ 6/18/2024 22:31'
}
SSC_Example3 >> action2WithEventAsParameter: anEvent [
	Transcript show: 'action2 called with event '; show: anEvent; cr.
]

{
	#category : #'event-handling',
	#'squeak_changestamp' : 'MZ 6/18/2024 22:19'
}
SSC_Example3 >> handlesKeyboard: anEvent [
	^ true
]

{
	#category : #'event-handling',
	#'squeak_changestamp' : 'MZ 6/18/2024 23:30'
}
SSC_Example3 >> keyStroke: anEvent [
	self class SSCActions do: [:action | 
		(action matches: anEvent) ifTrue: [action performOn: self withEvent: anEvent]]
]
