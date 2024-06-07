Class {
	#name : #TestClass,
	#superclass : #Object,
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/5/2024 22:56'
}
TestClass class >> actions [
	<ActionProvider>
	
	^ {SSC_Action new title: 'Test Action'}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/5/2024 23:17'
}
TestClass class >> actions2 [
	<ActionProvider>
	
	^ {SSC_Action new title: 'Test Action2'}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/5/2024 23:32'
}
TestClass class >> actions3 [
	<ActionProvider>
	
	^ {SSC_Action new title: 'Test Action3'}
]
