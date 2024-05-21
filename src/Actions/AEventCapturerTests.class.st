Class {
	#name : #AEventCapturerTests,
	#superclass : #ActionsTest,
	#category : #'Actions-Test'
}

{
	#category : #testing,
	#'squeak_changestamp' : 'KK 8/4/2022 19:09'
}
AEventCapturerTests >> testHandlesKeyboard [

	self assert: (AEventCaptureMorph new handlesKeyboard: KeyboardEvent new)
]

{
	#category : #testing,
	#'squeak_changestamp' : 'KK 8/4/2022 19:06'
}
AEventCapturerTests >> testWantsKeyboardFocus [

	self assert: AEventCaptureMorph new wantsKeyboardFocus
]
