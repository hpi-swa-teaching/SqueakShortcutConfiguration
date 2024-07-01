Extension { #name : #Editor }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/24/2024 09:57'
}
Editor class >> actionsListToCmdMap: actionsList [
	|cmdMap|
	cmdMap := Dictionary new.
	actionsList do: [:action | cmdMap at: (action key asciiValue +1) put: action method ].
	1 to: 255 do: [:i | cmdMap at: i ifAbsentPut: #noop: ].
	^ cmdMap
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 7/1/2024 21:24'
}
Editor class >> cmdMapToActionsList: cmdMap shift: aBoolean [
	|actions|
	actions := {} asSet.
	cmdMap keysAndValuesDo: [:asciiValue :method | (method = #noop:) ifFalse: [actions add: (SSC_Action new key: (asciiValue -1) asCharacter; method: method; shift: aBoolean)]].
	^ actions
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/29/2024 22:17'
}
Editor class >> defaultSSCActions [
	^ {} asSet
]
