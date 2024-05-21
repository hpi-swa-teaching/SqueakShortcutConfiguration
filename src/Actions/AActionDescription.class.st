"
Abstract class for Actions
"
Class {
	#name : #AActionDescription,
	#superclass : #Object,
	#instVars : [
		'title',
		'clazz'
	],
	#category : #'Actions-Core',
	#'squeak_changestamp' : 'MaCl 8/4/2022 09:43'
}

{
	#category : #comparing,
	#'squeak_changestamp' : 'WoC 10/2/2020 14:54'
}
AActionDescription >> = anActionDescription [

	self class = anActionDescription class
		ifFalse: [^ false].
	^ self title = anActionDescription title and: [self clazz = anActionDescription clazz]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/14/2020 23:59'
}
AActionDescription >> asTreeNode [

	self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/28/2020 11:53'
}
AActionDescription >> clazz [

	^ clazz
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/28/2020 11:53'
}
AActionDescription >> clazz: anObject [

	clazz := anObject.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'WoC 10/15/2020 00:25'
}
AActionDescription >> description [

	^ nil
]

{
	#category : #comparing,
	#'squeak_changestamp' : 'WoC 9/25/2020 14:36'
}
AActionDescription >> hash [

	^ self title hash
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 10/14/2020 23:10'
}
AActionDescription >> isAction [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'WoC 10/14/2020 23:10'
}
AActionDescription >> isActionGroup [

	^ false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/20/2020 14:15'
}
AActionDescription >> title [

	^ title
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'WoC 9/20/2020 14:15'
}
AActionDescription >> title: anObject [

	title := anObject.
]

{
	#category : #'write representation',
	#'squeak_changestamp' : 'WoC 10/8/2020 14:08'
}
AActionDescription >> writeListRepresentationOn: aCollection [

	self subclassResponsibility
]

{
	#category : #'write representation',
	#'squeak_changestamp' : 'WoC 9/26/2020 19:23'
}
AActionDescription >> writeTreeRepresentationInto: aDictionary [

	self subclassResponsibility
]
