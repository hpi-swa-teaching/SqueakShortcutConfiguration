Extension { #name : #SmalltalkEditor }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/29/2024 22:40'
}
SmalltalkEditor class >> SSCActions [
	^ (self cmdMapToActionsList: cmdActions shift: false), (self cmdMapToActionsList: shiftCmdActions shift: true)
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 7/1/2024 21:23'
}
SmalltalkEditor class >> SSCActions: someActions [
	|newActions newShiftActions|
	newShiftActions := someActions select: [:action | action shift].
	newActions :=  someActions reject: [:action | action shift].
	
	cmdActions := self actionsListToCmdMap: newActions.
	
	shiftCmdActions := self actionsListToCmdMap: newShiftActions.
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'MZ 6/29/2024 22:42'
}
SmalltalkEditor class >> defaultSSCActions [
	|cmds shiftCmds actions|
	
	actions := super defaultSSCActions asSet.
	cmds := #($b #browseIt: $d #doIt: $i #inspectIt: $l #cancel: $m #implementorsOfIt: $n #sendersOfIt: $o #spawnIt: $p #printIt: $q #querySymbol: $s #save: ).
		
	1 to: cmds size
		by: 2
		do: [:i | actions add: (SSC_Action new key: (cmds at: i); method: (cmds at: (i+1)))].
	
	shiftCmds := #(
		$a	argAdvance:
		$b	browseItHere:
		$d	debugIt:
		$e	methodStringsContainingIt:
		$f	displayIfFalse:
		$g	fileItIn:
		$i	exploreIt:
		$n	referencesToIt:
		$s	invokePrettyPrint:
		$t	displayIfTrue:
		$v	pasteInitials:
		$w	methodNamesContainingIt:
	).
	
	1 to: shiftCmds size
		by: 2
		do: [:i | actions add: (SSC_Action new key: (shiftCmds at: i); method: (shiftCmds at: (i+1)); shift: true)].
	
	^ actions
]
