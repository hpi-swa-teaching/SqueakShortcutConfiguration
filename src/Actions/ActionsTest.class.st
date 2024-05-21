Class {
	#name : #ActionsTest,
	#superclass : #TestCase,
	#category : #'Actions-Test'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/13/2022 13:58'
}
ActionsTest >> is: aCollectionA equalTo: aCollectionB [
	
	^ (self is: aCollectionA subsetOf: aCollectionB)
				and: (self is: aCollectionB subsetOf: aCollectionA)
				and: (aCollectionA size = aCollectionB size)

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/13/2022 13:53'
}
ActionsTest >> is: aCollectionA subsetOf: aCollectionB [

	^ (aCollectionA collect: [ :each | aCollectionB anySatisfy: [ :eachB | eachB = each ]])
				allSatisfy: [ :each | each ]
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'KK 6/6/2022 23:57'
}
ActionsTest >> setUp [

	ATestAActions pragmaKeywords: { }.
]

{
	#category : #'system windows',
	#'squeak_changestamp' : 'KK 6/7/2022 00:01'
}
ActionsTest >> systemWindowsFor: aWindowLabel [

	^ SystemWindow windowsIn: World satisfying: [:w | w label = aWindowLabel]
]

{
	#category : #'system windows',
	#'squeak_changestamp' : 'KK 6/7/2022 00:08'
}
ActionsTest >> systemWindowsInclude: aLabel [
	
	^ (self systemWindowsFor: aLabel) size >= 1
]

{
	#category : #initilization,
	#'squeak_changestamp' : 'MaCl 5/23/2022 10:06'
}
ActionsTest >> tearDown [

	
]
