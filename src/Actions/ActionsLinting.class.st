Class {
	#name : #ActionsLinting,
	#superclass : #TestCase,
	#category : #'Actions-Test'
}

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
	#category : #private,
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
	#'squeak_changestamp' : 'KK 6/14/2022 21:45'
}
ActionsLinting >> testForNoUnnecessaryCode [
	
	"SwaLint TestSuite Unnecessary code"
	self assertArbitraryCodeRules: {
		#smallLintAssignmentWithoutEffect .
		#smallLintExtraBlock .
		#smallLintEndTrueFalse .
		#smallLintOnlyReadOrWrittenVariable .
		#smallLintJustSendsSuper .
		#smallLintEquivalentSuperclassMethods .
		#smallLintImplementedNotSent .
		#smallLintOnlyReadOrWrittenTemporary .
		#smallLintEqualsTrue .
		#unnecessaryAssignmentRule: .
		#unreferencedVariable: .
		#smallLintVariableReferencedOnce .
		#smallLintUnreferencedVariables
	}
]
