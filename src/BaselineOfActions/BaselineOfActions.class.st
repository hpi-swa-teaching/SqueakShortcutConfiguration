Class {
	#name : #BaselineOfActions,
	#superclass : #BaselineOf,
	#category : #BaselineOfActions
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MaCl 5/21/2022 12:37'
}
BaselineOfActions >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec 
			package: 'Actions';
			group: 'default' with: #('Actions')
		].

]
