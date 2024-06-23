Extension { #name : #Editor }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 21:16'
}
Editor class >> SSCActions [

	SSCActions ifNil: [SSCActions := self defaultSSCActions].
	^ SSCActions
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 21:16'
}
Editor class >> SSCActions: aCollection [

	SSCActions := aCollection
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 21:18'
}
Editor class >> defaultSSCActions [

	^ 	{
			
		}	
]
