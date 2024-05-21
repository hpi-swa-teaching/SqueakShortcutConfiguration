Class {
	#name : #ATestShortcutBrowser,
	#superclass : #AShortcutBrowser,
	#category : #'Actions-Test'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/27/2022 16:16'
}
ATestShortcutBrowser class >> initialize [
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/23/2022 17:38'
}
ATestShortcutBrowser class >> windowLabel [
	
	^ 'Test Shortcut Browser'
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/6/2022 23:56'
}
ATestShortcutBrowser >> aactionsApi [

	^ ATestAActions
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'KK 6/23/2022 17:38'
}
ATestShortcutBrowser >> windowLabel [

	^ self class windowLabel
]
