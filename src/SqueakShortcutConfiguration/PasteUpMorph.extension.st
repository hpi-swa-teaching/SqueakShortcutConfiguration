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
	#category : #'*SqueakShortcutConfiguration-extensions',
	#'squeak_changestamp' : 'TJS 6/23/2024 15:28'
}
PasteUpMorph >> browseRecentSubmissions [

	Utilities browseRecentSubmissions
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/23/2024 15:44'
}
PasteUpMorph class >> defaultSSCActions [

	^ 	{
			SSC_Action new method: #browseRecentSubmissions; key: $R.
			SSC_Action new method: #findAFileList:; key: $L.
			SSC_Action new method: #findAMonticelloBrowser; key: $O.
			SSC_Action new method: #findAPreferencesPanel:; key: $P.
			
			LegacyShortcutsFilter legacyShortcutsEnabled
			ifTrue:  [SSC_Action new method: #snapshotIfLegacyShortcutsEnabled; key: $M.]
	 	}	
]

{
	#category : #'*SqueakShortcutConfiguration-extensions',
	#'squeak_changestamp' : 'TJS 6/23/2024 15:50'
}
PasteUpMorph >> snapshotIfLegacyShortcutsEnabled [

	Smalltalk snapshot: true andQuit: false
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/23/2024 15:51'
}
PasteUpMorph >> tryInvokeKeyboardShortcut: aKeyboardEvent [

    aKeyboardEvent commandKeyPressed ifFalse: [^ self].
    
    self class SSCActions do: [:action | action ifNotNil: [(action matches: aKeyboardEvent) ifTrue: [action performOn: self withEvent: aKeyboardEvent. aKeyboardEvent ignore]]]
]
