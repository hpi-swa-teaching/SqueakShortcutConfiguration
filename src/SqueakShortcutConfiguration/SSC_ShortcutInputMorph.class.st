Class {
	#name : #'SSC_ShortcutInputMorph',
	#superclass : #PluggableTextMorphPlus,
	#instVars : [
		'shortcutText'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/20/2024 20:17'
}
SSC_ShortcutInputMorph >> initialize [
    super initialize.
    shortcutText := ''.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/20/2024 20:18'
}
SSC_ShortcutInputMorph >> keyStroke: anEvent [
    | keystroke |
    keystroke := ''.

    anEvent controlKeyPressed ifTrue: [ keystroke := keystroke , 'Ctrl+' ].
    anEvent commandKeyPressed ifTrue: [ keystroke := keystroke , 'Cmd+' ].
    anEvent shiftKeyPressed ifTrue: [ keystroke := keystroke , 'Shift+' ].
    anEvent altKeyPressed ifTrue: [ keystroke := keystroke , 'Alt+' ].

    keystroke := keystroke , anEvent keyCharacter asString.
    shortcutText := keystroke.
    self changed.
    ^ true.  "Indicates that the event has been handled"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'yl 6/20/2024 20:18'
}
SSC_ShortcutInputMorph >> shortcutText [
    ^ shortcutText.
]
