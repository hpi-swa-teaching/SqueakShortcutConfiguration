Extension { #name : #TextEditor }

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 19:10'
}
TextEditor class >> SSCActions [

	SSCActions ifNil: [SSCActions := self defaultSSCActions].
	^ SSCActions
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/22/2024 19:09'
}
TextEditor class >> SSCActions: aCollection [

	SSCActions := aCollection
]

{
	#category : #'*SqueakShortcutConfiguration-overrides',
	#'squeak_changestamp' : 'TJS 6/23/2024 22:38'
}
TextEditor class >> defaultSSCActions [

	^	{
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
