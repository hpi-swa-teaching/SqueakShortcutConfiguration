Extension { #name : #PasteUpMorph }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 18:18'
}
PasteUpMorph class >> SSCActions [

	SSCActions ifNil: [SSCActions := self defaultSSCActions].
	^ SSCActions
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 18:17'
}
PasteUpMorph class >> SSCActions: aCollection [

	SSCActions := aCollection
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 20:38'
}
PasteUpMorph class >> defaultSSCActions [

	^ 	{
			SSC_Action new method: #browseRecentSubmissions; key: $R.
			SSC_Action new method: #findAFileList; key: $L.
			SSC_Action new method: #findAMonticelloBrowser; key: $O.
			SSC_Action new method: #findAPreferencesPanel; key: $P.
			SSC_Action new method: #snapshotIfLegacyShortcutsEnabled; key: $].
	 	}	
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/23/2024 15:19'
}
PasteUpMorph >> tryInvokeKeyboardShortcut: aKeyboardEvent [

    aKeyboardEvent commandKeyPressed ifFalse: [^ self].
    
    self class SSCActions do: [:action | (action key = aKeyboardEvent key) ifTrue: [self perform: action method. aKeyboardEvent ignore]].
            
]
