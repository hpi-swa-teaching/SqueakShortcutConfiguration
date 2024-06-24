Extension { #name : #PasteUpMorph }

{
	#category : #'*SqueakShortcutConfiguration-API',
	#'squeak_changestamp' : 'MZ 6/23/2024 22:35'
}
PasteUpMorph class >> SSCActions [
	|sscActions|
	sscActions := {} asSet.
	ActiveWorld commandKeySelectors keysAndValuesDo: [:key :value | sscActions add: (SSC_Action new key: key; title: (self cmdSelectorTitleFromMessageSend: value))].
	^ sscActions
]

{
	#category : #'*SqueakShortcutConfiguration-API',
	#'squeak_changestamp' : 'MZ 6/24/2024 09:08'
}
PasteUpMorph class >> SSCActions: newActions [
	|defaultKeysByTitle keysByTitle newCmdSelectors|
	keysByTitle := Dictionary new.
	defaultKeysByTitle := Dictionary new.
	newCmdSelectors := Dictionary new.
	
	"(newActions anySatisfy: [:action | action title = 'Save the image.']) ifTrue: [self halt]."
	
	self defaultSSCActions do: [:action | keysByTitle at: action title put: action key. defaultKeysByTitle at: action title put: action key ].
	newActions do: [:action | keysByTitle at: action title put: action key ].
	
	keysByTitle keysAndValuesDo: [:title :key | |messageSend|
		messageSend := self defaultCommandKeySelectors at: (defaultKeysByTitle at: title).
		newCmdSelectors at: key put: messageSend.
	].
	
	PasteUpMorph allInstances do: [:instance | instance setProperty: #commandKeySelectors toValue: newCmdSelectors ]
]

{
	#category : #'*SqueakShortcutConfiguration-API',
	#'squeak_changestamp' : 'MZ 6/23/2024 22:35'
}
PasteUpMorph class >> cmdSelectorTitleFromMessageSend: aMessageSend [
	"PasteUpMorph>>initializeDesktopCommandKeySelectors only saves a key and a MessageSend object. We need the action title from defaultDesktopCommandKeyTriplets though."
	
	ActiveWorld defaultDesktopCommandKeyTriplets do: [:trip | 
		((trip second = aMessageSend receiver) and: (trip third = aMessageSend selector)) ifTrue: [ ^ trip fourth ]].
	
	^ aMessageSend receiver asString, ' ', aMessageSend selector asString
]

{
	#category : #'*SqueakShortcutConfiguration-API',
	#'squeak_changestamp' : 'MZ 6/23/2024 23:43'
}
PasteUpMorph class >> defaultCommandKeySelectors [
	| dict |
	dict := IdentityDictionary new.
	ActiveWorld defaultDesktopCommandKeyTriplets do: [:trip |
		| messageSend |
		messageSend := MessageSend receiver: trip second selector: trip third.
		dict at: trip first put: messageSend].
	^ dict
]

{
	#category : #'*SqueakShortcutConfiguration-API',
	#'squeak_changestamp' : 'MZ 6/23/2024 22:55'
}
PasteUpMorph class >> defaultSSCActions [
	^ ActiveWorld defaultDesktopCommandKeyTriplets collect: [:trip | SSC_Action new key: trip first; title: trip fourth ]
]
