Extension { #name : #PasteUpMorph }

{
	#category : #'*SqueakShortcutConfiguration-API',
	#'squeak_changestamp' : 'MZ 7/2/2024 19:24'
}
PasteUpMorph class >> SSCActions [
	^ ActiveWorld valueOfProperty: #SSCActions ifAbsentPut: [PasteUpMorph defaultSSCActions]
]

{
	#category : #'*SqueakShortcutConfiguration-API',
	#'squeak_changestamp' : 'MZ 7/2/2024 19:40'
}
PasteUpMorph class >> SSCActions: newActions [
	|sscActions newCmdSelectors messageSendsById|
	sscActions := self SSCActions.
	
	newActions do: [:newAction |
		sscActions := sscActions reject: [:oldAction | oldAction id = newAction id].
		sscActions add: newAction.
	].
	
	messageSendsById := PasteUpMorph messageSendsById.
	newCmdSelectors := Dictionary new.
	sscActions do: [:action | newCmdSelectors at: action key put: (messageSendsById at: action id) ].
	
	ActiveWorld setProperty: #SSCActions toValue: sscActions.
	PasteUpMorph allInstances do: [:instance | instance setProperty: #commandKeySelectors toValue: newCmdSelectors ]
]

{
	#category : #'*SqueakShortcutConfiguration-API',
	#'squeak_changestamp' : 'MZ 7/2/2024 19:25'
}
PasteUpMorph class >> defaultSSCActions [
	|actions triplets|
	actions := {} asSet.
	triplets := ActiveWorld defaultDesktopCommandKeyTriplets.
	1 to: triplets size do: [:i | |trip|
		trip := triplets at: i.
		actions add: (SSC_Action new id: i; key: trip first; title: trip fourth)].
	^ actions
]

{
	#category : #'*SqueakShortcutConfiguration-API',
	#'squeak_changestamp' : 'MZ 7/2/2024 19:19'
}
PasteUpMorph class >> messageSendsById [
	|dict triplets|
	dict := Dictionary new.
	triplets := ActiveWorld defaultDesktopCommandKeyTriplets.
	1 to: triplets size do: [:i | |trip|
		trip := triplets at: i.
		dict at: i put: (MessageSend receiver: trip second selector: trip third)].
	^ dict
]
