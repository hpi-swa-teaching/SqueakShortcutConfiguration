Extension { #name : #SystemWindow }

{
	#category : #'*SqueakShortcutConfiguration',
	#'squeak_changestamp' : 'TJS 6/22/2024 21:04'
}
SystemWindow class >> SSCActions [

	SSCActions ifNil: [SSCActions := self defaultSSCActions].
	^ SSCActions
]

{
	#category : #'*SqueakShortcutConfiguration',
	#'squeak_changestamp' : 'TJS 6/22/2024 21:05'
}
SystemWindow class >> SSCActions: aCollection [

	SSCActions := aCollection
]

{
	#category : #'*SqueakShortcutConfiguration',
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:02'
}
SystemWindow >> bringWindowUnderHandToFront [
	self class bringWindowUnderHandToFront
]

{
	#category : #'*SqueakShortcutConfiguration',
	#'squeak_changestamp' : 'TJS 6/22/2024 21:14'
}
SystemWindow class >> defaultSSCActions [

	^ 	{
			SSC_Action new method: #sendTopWindowToBack; key: $\.
			SSC_Action new method: #deleteTopWindow; key: $w.
			SSC_Action new method: #bringWindowUnderHandToFront; key: $/.
		}	
]

{
	#category : #'*SqueakShortcutConfiguration',
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:01'
}
SystemWindow >> deleteTopWindow [
	self class deleteTopWindow
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:07'
}
SystemWindow >> filterEvent: aKeyboardEvent for: anObject [
	"Provide keyboard shortcuts."

	aKeyboardEvent isKeystroke
		ifFalse: [^ aKeyboardEvent].
	aKeyboardEvent hand halo ifNotNil: [ : halo | halo target isSystemWindow ifTrue: [ aKeyboardEvent hand removeHalo ] ].
	
	self class SSCActions do: [:action |
		(action matches: aKeyboardEvent) ifTrue: [
			action performOn: self withEvent: aKeyboardEvent.
			^ aKeyboardEvent ignore "hit!"
		].
	].

	^ aKeyboardEvent "no hit"
]

{
	#category : #'*SqueakShortcutConfiguration',
	#'squeak_changestamp' : 'JPVS 7/3/2024 11:01'
}
SystemWindow >> sendTopWindowToBack [
	self class sendTopWindowToBack
]
