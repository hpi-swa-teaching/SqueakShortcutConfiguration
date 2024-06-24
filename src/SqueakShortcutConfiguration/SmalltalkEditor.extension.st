Extension { #name : #SmalltalkEditor }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/24/2024 09:46'
}
SmalltalkEditor class >> SSCActions [
	^ self cmdMapToActionsList: cmdActions
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/24/2024 10:16'
}
SmalltalkEditor class >> SSCActions: newActions [
	|actionsByMethod|
	actionsByMethod := Dictionary new.
	
	self SSCActions do: [:action | actionsByMethod at: action method put: action ].
	newActions do: [:action | actionsByMethod at: action method put: action ].
	
	cmdActions := self actionsListToCmdMap: actionsByMethod values
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/24/2024 09:34'
}
SmalltalkEditor class >> defaultSSCActions [
	|cmds actions|
	
	actions := super defaultSSCActions asSet.
	cmds := #($b #browseIt: $d #doIt: $i #inspectIt: $l #cancel: $m #implementorsOfIt: $n #sendersOfIt: $o #spawnIt: $p #printIt: $q #querySymbol: $s #save: ).
		
	1 to: cmds size
		by: 2
		do: [:i | actions add: (SSC_Action new key: (cmds at: i); method: (cmds at: (i+1)))].
	
	^ actions
]
