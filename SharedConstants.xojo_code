#tag Module
Protected Module SharedConstants
	#tag Constant, Name = kApplicationName, Type = String, Dynamic = False, Default = \"Xojo Contest Games 2025", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kApplicationVersion, Type = String, Dynamic = False, Default = \"1.0.0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kAssetDirectory, Type = String, Dynamic = False, Default = \"Assets", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDefaultBorderWidth, Type = Integer, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDefaultButtonHeight, Type = Integer, Dynamic = False, Default = \"40", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDefaultButtonWidth, Type = Integer, Dynamic = False, Default = \"120", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDefaultPadding, Type = Integer, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDefaultUpdateInterval, Type = Integer, Dynamic = False, Default = \"16", Scope = Public
		#tag Note
			~60 FPS in milliseconds
		#tag EndNote
	#tag EndConstant

	#tag Constant, Name = kHighScoresFileName, Type = String, Dynamic = False, Default = \"highscores.json", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMaxFrameSkip, Type = Integer, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMaxParticles, Type = Integer, Dynamic = False, Default = \"1000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMaxSoundInstances, Type = Integer, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSaveGameFileName, Type = String, Dynamic = False, Default = \"savegame.json", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSettingsFileName, Type = String, Dynamic = False, Default = \"settings.json", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSoundDirectory, Type = String, Dynamic = False, Default = \"Sounds", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kTargetFPS, Type = Integer, Dynamic = False, Default = \"60", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowHeight, Type = Integer, Dynamic = False, Default = \"720", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowWidth, Type = Integer, Dynamic = False, Default = \"1280", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule