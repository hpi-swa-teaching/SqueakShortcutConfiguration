Extension { #name : #SystemWindow }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 21:04'
}
SystemWindow class >> SSCActions [

	SSCActions ifNil: [SSCActions := self defaultSSCActions].
	^ SSCActions
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 21:05'
}
SystemWindow class >> SSCActions: aCollection [

	SSCActions := aCollection
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 21:14'
}
SystemWindow class >> defaultSSCActions [

	^ 	{
			SSC_Action new method: #sendTopWindowToBack; key: $\.
			SSC_Action new method: #deleteTopWindow; key: $w.
			SSC_Action new method: #bringWindowUnderHandToFront; key: $/.
		}	
]
