#tag Class
Protected Class GameScene
	#tag Method, Flags = &h0
		Sub Cleanup()
		  // Abstract method - must be implemented by subclasses
		  // Release resources when scene is destroyed
		  Raise New UnsupportedOperationException("Cleanup() must be implemented by subclass")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(sceneID As String)
		  // Initialize base scene properties
		  If sceneID = "" Then
		    Raise New InvalidArgumentException("Scene ID cannot be empty")
		  End If

		  mSceneID = sceneID
		  mIsActive = False
		  mIsInitialized = False
		  mTransitionState = eTransitionState.None
		  mTransitionTime = 0.0
		  mTransitionDuration = kDefaultTransitionDuration
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g As Graphics)
		  // Abstract method - must be implemented by subclasses
		  // Render scene contents to graphics context
		  Raise New UnsupportedOperationException("Draw() must be implemented by subclass")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSceneID() As String
		  // Return the unique scene identifier
		  Return mSceneID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTransitionAlpha() As Double
		  // Calculate alpha value for fade transitions
		  Select Case mTransitionState
		  Case eTransitionState.FadingIn
		    Return mTransitionTime / mTransitionDuration
		  Case eTransitionState.FadingOut
		    Return 1.0 - (mTransitionTime / mTransitionDuration)
		  Case eTransitionState.Active
		    Return 1.0
		  Else
		    Return 0.0
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleInput(inputData As Dictionary)
		  // Abstract method - must be implemented by subclasses
		  // Process keyboard and mouse input for scene
		  Raise New UnsupportedOperationException("HandleInput() must be implemented by subclass")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init()
		  // Abstract method - must be implemented by subclasses
		  // Initialize scene resources and state
		  Raise New UnsupportedOperationException("Init() must be implemented by subclass")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsActive() As Boolean
		  // Return current activation status
		  Return mIsActive And mTransitionState <> eTransitionState.None
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInitialized() As Boolean
		  // Check if scene has been properly initialized
		  Return mIsInitialized
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTransitioning() As Boolean
		  // Check if scene is currently transitioning
		  Return mTransitionState = eTransitionState.FadingIn Or mTransitionState = eTransitionState.FadingOut
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetActive(active As Boolean)
		  // Change scene activation state
		  mIsActive = active

		  If active And Not mIsInitialized Then
		    // Auto-initialize when activated for first time
		    Init()
		    mIsInitialized = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetInitialized(initialized As Boolean)
		  // Mark scene as initialized (called by Router after Init())
		  mIsInitialized = initialized
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTransitionDuration(duration As Double)
		  // Configure transition animation duration
		  If duration > 0.0 Then
		    mTransitionDuration = duration
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartTransition(newState As eTransitionState)
		  // Begin scene transition animation
		  mTransitionState = newState
		  mTransitionTime = 0.0

		  // Activate scene if transitioning in
		  If newState = eTransitionState.FadingIn Then
		    SetActive(True)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update(deltaTime As Double)
		  // Abstract method - must be implemented by subclasses
		  // Update scene logic, animations, and state
		  Raise New UnsupportedOperationException("Update() must be implemented by subclass")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateTransition(deltaTime As Double)
		  // Update transition animation state
		  If Not IsTransitioning() Then Return

		  mTransitionTime = mTransitionTime + deltaTime

		  If mTransitionTime >= mTransitionDuration Then
		    // Transition complete
		    Select Case mTransitionState
		    Case eTransitionState.FadingIn
		      mTransitionState = eTransitionState.Active
		    Case eTransitionState.FadingOut
		      mTransitionState = eTransitionState.None
		      SetActive(False)
		    End Select

		    mTransitionTime = 0.0
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIsActive As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsInitialized As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSceneID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransitionDuration As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransitionState As eTransitionState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransitionTime As Double
	#tag EndProperty


	#tag Constant, Name = kDefaultTransitionDuration, Type = Double, Dynamic = False, Default = \"0.5", Scope = Private
	#tag EndConstant


	#tag Enum, Name = eTransitionState, Flags = &h0
		None
		  FadingIn
		  Active
		FadingOut
	#tag EndEnum


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
End Class
#tag EndClass