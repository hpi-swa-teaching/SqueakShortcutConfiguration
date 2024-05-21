Class {
	#name : #ActionsLinting,
	#superclass : #TestCase,
	#category : #'Actions-Test'
}

{
	#category : #history,
	#'squeak_changestamp' : 'wb 6/22/2022 16:45'
}
ActionsLinting class >> lastStoredRun [
	^ ((Dictionary new) add: (#duration->11248); add: (#errors->((Set new))); add: (#passed->((Set new) add: #testDotReturnConsistency; add: #testNoDefinesEqualNotHash; add: #testNoReturnsIfTrue; add: #testNoEqualNotUsed; add: #testNoEqualsTrue; add: #testNoExtraBlock; add: #testNoMethodModifierOverride; add: #testNoJustSendsSuper; add: #testNoWhileTrue; yourself)); add: (#failures->((Set new))); add: (#timeStamp->'22 June 2022 4:16:35.86868 pm' asTimeStamp); add: (#durations->((Dictionary new) add: (#testNoExtraBlock->1402); add: (#testNoEqualsTrue->1409); add: (#testNoEqualNotUsed->1380); add: (#testDotReturnConsistency->1521); add: (#testNoJustSendsSuper->1450); add: (#testNoMethodModifierOverride->1376); add: (#testNoDefinesEqualNotHash->1341); add: (#testNoWhileTrue->0); add: (#testNoReturnsIfTrue->1369); yourself)); yourself)
]

{
	#category : #private,
	#'squeak_changestamp' : 'KK 6/14/2022 17:38'
}
ActionsLinting >> assertArbitraryCodeRules: rules [
"Verifies an arbritrary code rule."
	| results |
	
	results := self runArbitraryCodeRules: rules on: self objectsToTest.
	
	results do: [ :ruleResult |
		self assert: 0 equals: ruleResult size 
	]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MaCl 6/4/2022 15:58'
}
ActionsLinting >> defaultTimeout [

	^ 60 "seconds" 
]

{
	#category : #private,
	#'squeak_changestamp' : 'KK 6/14/2022 11:07'
}
ActionsLinting >> objectsToTest [

	| testObjects|
	testObjects := SystemNavigation default allClasses .
	testObjects := testObjects select: [:x| x class category beginsWith: 'Actions-Core' ].
	
	^ testObjects := testObjects collect: [ :aObject |
		aObject as: SLTestObject]
]

{
	#category : #private,
	#'squeak_changestamp' : 'KK 6/14/2022 11:17'
}
ActionsLinting >> runArbitraryCodeRules: rules on: testObjects [

	| testRunner positiveResults |
	testRunner := (SLTestRunner new) environment: (SLDefaultEnvironment new).
	
	testRunner runOnTests: rules andTestObjects: testObjects.
	positiveResults := OrderedCollection new.
	rules do: [ :rule |
		positiveResults add: 
			(testObjects select: [:testObject | | result |
				result := testObject resultOf: rule.
				(result respondsTo: #>)
					ifTrue: [result result > 0]
					ifFalse: [result isNegative ] ])
	].
		
	^ positiveResults 
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'KK 6/14/2022 17:36'
}
ActionsLinting >> testDotReturnConsistency [
	
	| results |
	
	results := (self runArbitraryCodeRules: {#dotAfterReturn:} on: self objectsToTest).
	
	results do: [ :ruleResult | 
		ruleResult do: [ :each |
			self assert: each results values first result equals: 1 description: 'Dots after return found for: ' ,each. 
		]
	].
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'MaCl 7/25/2022 11:25'
}
ActionsLinting >> testMethodClassification [
	
	self assertArbitraryCodeRules: {#smallLintInconsistentMethodClassification . #smallLintUnclassifiedMethods}
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'KK 6/14/2022 11:13'
}
ActionsLinting >> testNoDefinesEqualNotHash [
	self assertArbitraryCodeRules: {#smallLintDefinesEqualNotHash}
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'KK 6/14/2022 17:44'
}
ActionsLinting >> testNoEqualNotUsed [
	self assertArbitraryCodeRules: {#smallLintEqualNotUsed}
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'KK 6/14/2022 17:44'
}
ActionsLinting >> testNoEqualsTrue [
	self assertArbitraryCodeRules: {#smallLintEqualsTrue}
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'KK 6/14/2022 17:44'
}
ActionsLinting >> testNoExtraBlock [
	self assertArbitraryCodeRules: {#smallLintExtraBlock}
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'KK 6/14/2022 17:44'
}
ActionsLinting >> testNoJustSendsSuper [
	self assertArbitraryCodeRules: {#smallLintJustSendsSuper}
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'KK 6/14/2022 17:44'
}
ActionsLinting >> testNoMethodModifierOverride [
	self assertArbitraryCodeRules: {#smallLintMethodModifierOverride}
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'KK 6/14/2022 11:14'
}
ActionsLinting >> testNoReturnsIfTrue [
	self assertArbitraryCodeRules: {#smallLintReturnsIfTrue}
]

{
	#category : #'code-style',
	#'squeak_changestamp' : 'MaCl 6/6/2022 14:38'
}
ActionsLinting >> testNoWhileTrue [
	"self ArbitraryCodeRule: #smallLintWhileTrue"
]
