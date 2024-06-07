Class {
	#name : #'SSC_Action',
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'TODO!!!',
	#'squeak_changestamp' : 'JPVS 6/7/2024 12:56'
}
SSC_Action >> = anAction [
	^ (self species == anAction species) 
		and: [self title = anAction title] "this has to be changed at some point"
]

{
	#category : #'TODO!!!',
	#'squeak_changestamp' : 'JPVS 6/7/2024 12:59'
}
SSC_Action >> hash [
	^ self title hash"this has to be changed at some point"
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:06'
}
SSC_Action >> printOn: aStream [
	aStream nextPutAll: self title
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:56'
}
SSC_Action >> title [
	^ name
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:56'
}
SSC_Action >> title: aString [
	name := aString
]
