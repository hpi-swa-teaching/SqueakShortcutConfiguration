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
	#'squeak_changestamp' : 'KK 7/19/2022 17:48'
}
AGlobalActions class >> allGlobalActionDict [
	
	| actionDict |
	actionDict := Dictionary new.
	
	((self allRelevantMethods collect: [:method | AActions valueFrom: method])
		select: [:value | self isCollectionOfActionShortcutPairs: value])
		do: [:actionPairList | actionPairList do: [: actionPair| actionDict at: actionPair first title put: actionPair first].].
		
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
	#'squeak_changestamp' : 'KK 7/19/2022 17:41'
}
AGlobalActions class >> globalActions [

	^{   
		{'Move up' . #moveUp . 'Moves the currently selected items above the items over it' . $p . #cmdPressed }.
		{'Move Down' . #moveDown . 'Moves the currently selected items under the items under it' }.
		{'Add line' . #addSeparator . 'Adds a seperator/line'. $a . #cmdPressed}.
		{'Remove' . #removeItem . 'Removes the currently selected item'. $r . #cmdPressed}.
		{'Add...' . #addAction . 'Opens a dialog to select actions to be added to the list'. $c . #cmdPressed}.
	}collect: [:each | AGlobalAction createActions: each]
	
]

{
	#category : #'handle actions',
	#'squeak_changestamp' : 'KK 7/19/2022 17:32'
}
AGlobalActions class >> isCollectionOfActionShortcutPairs: aValue [

	^ aValue isCollection 
			and: [aValue isString not] 
			and: [(aValue collect: [:each | each isCollection and: [each size = 2] 
					and: [AActions testIfIsAction: each first]]) allSatisfy: [:each | each]]
]

{
	#category : #'handle actions',
	#'squeak_changestamp' : 'KK 7/14/2022 14:21'
}
AGlobalActions class >> isMethodRelevant: aMethod [ 

	^ (aMethod selector = #allGlobalActionDict) not 
			and: ((aMethod selector includesSubString: #':') not)
]
