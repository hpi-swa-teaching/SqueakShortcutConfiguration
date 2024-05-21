Class {
	#name : #AGlobalActionsTests,
	#superclass : #ActionsTest,
	#category : 'Actions-Test'
}

{
	#category : #'global actions',
	#'squeak_changestamp' : 'KK 7/26/2022 20:42'
}
AGlobalActionsTests >> testGlobalActionDict [

	| globalActionsDict |
	globalActionsDict := ATestGlobalActions allGlobalActionDict.
	
	self 
		assert: globalActionsDict size equals: 2;
		assert: (globalActionsDict at: 'Move up') equals: (AGlobalAction from: ATestGlobalActions action1 in: nil);
		assert: (globalActionsDict at: 'Move Down') equals: (AGlobalAction from: ATestGlobalActions action2 in: nil).
	
]

{
	#category : #'method filtering',
	#'squeak_changestamp' : 'KK 7/26/2022 20:47'
}
AGlobalActionsTests >> testIfisMethodRelevantFiltersSelectorsWithArguments [

	self 
		assert: (ATestGlobalActions isMethodRelevant: #hello: ) equals: false;
		assert: (ATestGlobalActions isMethodRelevant: #hello:World: ) equals: false.
]
