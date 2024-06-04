Class {
	#name : #'SSC_Action',
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:06'
}
SSC_Action >> printOn: aStream [
	aStream nextPutAll: self title
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:56'
}
SSC_Action >> title [
	^ name
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/4/2024 11:56'
}
SSC_Action >> title: aString [
	name := aString
]
