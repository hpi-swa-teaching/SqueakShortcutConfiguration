Extension { #name : #SmalltalkEditor }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 19:18'
}
SmalltalkEditor class >> SSCActions [

	SSCActions ifNil: [SSCActions := self defaultSSCActions].
	^ SSCActions
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 19:19'
}
SmalltalkEditor class >> SSCActions: aCollection [

	SSCActions := aCollection
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 20:52'
}
SmalltalkEditor class >> defaultSSCActions [

	^ 	{
			SSC_Action new method: #browseIt; key: $b.
	 		SSC_Action new method: #doIt; key: $d.
			SSC_Action new method: #inspectIt; key: $i.
			SSC_Action new method: #cancel; key: $l.
			SSC_Action new method: #implementorsOfIt; key: $m.
			SSC_Action new method: #sendersOfIt; key: $n.
			SSC_Action new method: #spawnIt; key: $o.
			SSC_Action new method: #printIt; key: $p.
			SSC_Action new method: #querySymbol; key: $q.
			SSC_Action new method: #save; key: $s.
			
			SSC_Action new method: #argAdvance; key: $A.
			SSC_Action new method: #browseItHere; key: $B.
			SSC_Action new method: #debugIt; key: $D.
			SSC_Action new method: #methodStringsContainingIt; key: $E.
			SSC_Action new method: #displayIfFalse; key: $F.
			SSC_Action new method: #fileItIn; key: $G.
			SSC_Action new method: #exploreIt; key: $I.
			SSC_Action new method: #referencesToIt; key: $N.
			SSC_Action new method: #invokePrettyPrint; key: $S.
			SSC_Action new method: #displayIfTrue; key: $T.
			SSC_Action new method: #pasteInitials; key: $V.
			SSC_Action new method: #methodNamesContainingIt; key: $W.
		}	
]
