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
	#'squeak_changestamp' : 'TJS 6/24/2024 01:22'
}
SmalltalkEditor class >> defaultSSCActions [

	^ 	{
			SSC_Action new method: #browseIt:; key: $b.
	 		SSC_Action new method: #doIt:; key: $d.
			SSC_Action new method: #inspectIt:; key: $i.
			SSC_Action new method: #cancel:; key: $l.
			SSC_Action new method: #implementorsOfIt:; key: $m.
			SSC_Action new method: #sendersOfIt:; key: $n.
			SSC_Action new method: #spawnIt:; key: $o.
			SSC_Action new method: #printIt:; key: $p.
			SSC_Action new method: #querySymbol:; key: $q.
			SSC_Action new method: #save:; key: $s.
			
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
			
			SSC_Action new method: #selectAll:; key: $a.
			SSC_Action new method: #copySelection:; key: $c.
			SSC_Action new method: #exchange:; key: $e.
			SSC_Action new method: #find:; key: $f.
			SSC_Action new method: #findAgain:; key: $g.
			SSC_Action new method: #doAgain:; key: $j.
			SSC_Action new method: #offerFontMenu:; key: $k.
			SSC_Action new method: #align:; key: $u.
			SSC_Action new method: #paste:; key: $v.
			SSC_Action new method: #backWord:; key: $w.
			SSC_Action new method: #cut:; key: $x.
			SSC_Action new method: #swapChars:; key: $y.
			SSC_Action new method: #undo:; key: $z.
			
			SSC_Action new method: #compareToClipboard; key: $C.
			SSC_Action new method: #cursorTopHome; key: $H.
			SSC_Action new method: #doAgainUpToEnd; key: $J.
			SSC_Action new method: #changeStyle; key: $K.
			SSC_Action new method: #selectCurrentTypeIn; key: $M.
			SSC_Action new method: #findAgain; key: $S.
			SSC_Action new method: #changeLfToCr; key: $U.
			SSC_Action new method: #makeLowercase; key: $X.
			SSC_Action new method: #makeUppercase; key: $Y.
			SSC_Action new method: #redo; key: $Z.
		}	
]
