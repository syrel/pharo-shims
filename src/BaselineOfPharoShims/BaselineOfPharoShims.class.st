Class {
	#name : #BaselineOfPharoShims,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoShims
}

{ #category : #baseline }
BaselineOfPharoShims >> baseline: spec [
	<baseline>
	spec
		for: #('pharo9.x')
		do: [ spec package: #Pharo8To9 ]
]
