"
Class that provides available GlobalActions
"
Class {
	#name : #AGlobalActions,
	#superclass : #Object,
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:41'
}

{
	#category : #'handle actions',
	#'squeak_changestamp' : 'KK 7/28/2022 11:20'
}
AGlobalActions class >> allGlobalActionDict [
	
	| actionDict |
	actionDict := Dictionary new.
	
	((self allRelevantMethods collect: [:method | AActions valueFrom: method])
		select: [:value | self isCollectionOfActionShortcutPairs: value])
		do: [:actionsList | actionsList do: [: action | actionDict at: action title put: action].].
		
	^ actionDict
]

{
	#category : #'handle actions',
	#'squeak_changestamp' : 'KK 7/19/2022 17:49'
}
AGlobalActions class >> allRelevantMethods [
	
	^ self class methodDict values select: [:method | self isMethodRelevant: method]
			
]

{
	#category : #'handle actions',
	#'squeak_changestamp' : 'KK 7/11/2022 16:37'
}
AGlobalActions class >> globalActionFrom: aTitle [

	^ self allGlobalActionDict at: aTitle
]

{
	#category : #'global actions',
	#'squeak_changestamp' : 'MaCl 8/4/2022 16:55'
}
AGlobalActions class >> globalActions [

	^{  
		{'Remove' . #remove . 'Removes the currently selected item'. $r . #cmdPressed}.
	}collect: [:each | AGlobalAction createActions: each]
	
]

{
	#category : #'handle actions',
	#'squeak_changestamp' : 'KK 7/28/2022 11:27'
}
AGlobalActions class >> isCollectionOfActionShortcutPairs: aValue [

	^ aValue isCollection 
			and: [aValue isString not] 
			and: [aValue allSatisfy: [:each | AActions testIfIsAction: each]]
]

{
	#category : #'handle actions',
	#'squeak_changestamp' : 'MZ 5/21/2024 19:53'
}
AGlobalActions class >> isMethodRelevant: aMethod [ 

	^ (aMethod selector = #allGlobalActionDict) not 
			and: ((aMethod selector includes: (':' at: 1)) not)
]
