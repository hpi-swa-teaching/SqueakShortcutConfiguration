Class {
	#name : #'SSC_API',
	#superclass : #Object,
	#category : #SqueakShortcutConfiguration
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:03'
}
SSC_API class >> actionsForClass: aSymbol [
	Transcript showln: 'SSC_API actionsForClass: is currently a stub.'.
	^ {SSC_Action new title: aSymbol asString, '-Action'. SSC_Action new title: '123' }
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'JPVS 6/4/2024 12:00'
}
SSC_API class >> classNames [
	Transcript showln: 'SSC_API configurableClasses is currently a stub.'.
	^ {#Test123. #TomTom}
]
