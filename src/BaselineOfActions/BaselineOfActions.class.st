Class {
	#name : #BaselineOfActions,
	#superclass : #BaselineOf,
	#category : #BaselineOfActions
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/9/2022 16:41'
}
BaselineOfActions >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec
			"requirements for SwaLint"
			project: 'RefactoringBrowser' with: [
				spec
					className: 'ConfigurationOfRefactoringBrowser';
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
				
			"SwaLint setup"
			package: 'SwaLint-Preferences' with: [
				spec
					file: 'SwaLint-Preferences-cypress.1';
					repository: 'github://hpi-swa-teaching/SwaLint:main/packages'];
			package: 'SwaLint-Core' with: [
				spec
					file: 'SwaLint-Core-cypress.1';
					repository: 'github://hpi-swa-teaching/SwaLint:main/packages';
					requires: #('RefactoringBrowser' 'SwaLint-Preferences')];
				
			postLoadDoIt: #installSwaLint;
			
			package: 'SwaLint-PlugIns' with: [
				spec
					file: 'SwaLint-PlugIns-cypress.1';
					repository: 'github://hpi-swa-teaching/SwaLint:main/packages';
					requires: 'SwaLint-Core'];
				
				package: 'Actions';
				group: 'default' with: #('Actions' 'SwaLint-Core' 'SwaLint-PlugIns');
				group: 'Core' with: #('SwaLint-Core')

		].

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'KK 6/9/2022 16:41'
}
BaselineOfActions >> installSwaLint [

	Smalltalk globals at: #SwaLint
		ifPresent: [:swalint | swalint perform: #install ]

]
