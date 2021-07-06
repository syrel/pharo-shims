Extension { #name : #ToolRegistry }

{ #category : #'*Pharo8To9' }
ToolRegistry >> debuggerDispatcherFor: aContext matching: aBlock [
	| debuggers |
	debuggers := self debuggersWithRanksMatching: [ :aDebugger | 
		(aBlock value: aDebugger) and: [ 
			aDebugger handlesContext: aContext ] ].
	(debuggers size > 0) ifTrue: [ ^ (debuggers at: 1) key ].
	^ nil
]

{ #category : #'*Pharo8To9' }
ToolRegistry >> debuggersForContext: aContext [

	^ self debuggersMatching: [ :aDebugger | aDebugger handlesContext: aContext ]
]

{ #category : #'*Pharo8To9' }
ToolRegistry >> debuggersMatching: aBlock [

	^ (self debuggersWithRanksMatching: aBlock) 
			inject: OrderedCollection new
			into: [ :aCollection :aPair | aCollection add: aPair key; yourself ]
]

{ #category : #'*Pharo8To9' }
ToolRegistry >> debuggersWithRanksMatching: aBlock [

	^ ((self registeredDebuggersWithRanks) 
			select: [ :aPair | aBlock value: aPair key ])
			sort: [ :pair1 :pair2 | pair1 value > pair2 value ].
]

{ #category : #'*Pharo8To9' }
ToolRegistry >> registerDebugger: anObject withRank: anInteger [
	|debuggers|
	
	debuggers  := tools at: #debuggers ifAbsent: [
		tools at: #debuggers put: OrderedCollection new ]. 
	(debuggers anySatisfy: [:each| each key == anObject] ) ifFalse: [ 
		debuggers add: anObject -> anInteger ].
	self announcer announce: (ToolRegistryToolRegistered tool: anObject name: #debuggers)
]

{ #category : #'*Pharo8To9' }
ToolRegistry >> registeredDebuggersWithRanks [
	
	^ tools at: #debuggers ifAbsent: [
		tools at: #debuggers put: OrderedCollection new ]
]
