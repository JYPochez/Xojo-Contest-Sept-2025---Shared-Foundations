#tag Module
Protected Module Router
	#tag Method, Flags = &h0
		Function CanGoBack() As Boolean
		  // Check if there's a previous scene to return to
		  Return gSceneHistory.LastIndex >= 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearHistory()
		  // Clear scene navigation history
		  ReDim gSceneHistory(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawCurrentScene(g As Graphics)
		  // Render active scene and transition effects
		  If gCurrentScene = Nil Then Return

		  // Apply transition alpha if scene is transitioning
		  // Note: GlobalAlpha not available in Xojo Graphics API
		  // Transition effects will be handled within individual scenes

		  // Draw the current scene
		  gCurrentScene.Draw(g)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCurrentScene() As GameScene
		  // Return currently active scene
		  Return gCurrentScene
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCurrentSceneID() As String
		  // Return identifier of active scene
		  If gCurrentScene = Nil Then
		    Return ""
		  Else
		    Return gCurrentScene.GetSceneID()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPreviousScene() As GameScene
		  // Return previous scene reference
		  Return gPreviousScene
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRegisteredScene(sceneType As eGameScene) As GameScene
		  // Get registered scene instance by type
		  If gRegisteredScenes.HasKey(sceneType) Then
		    Return gRegisteredScenes.Value(sceneType)
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GoBack()
		  // Return to previous scene in history
		  If Not CanGoBack() Then Return

		  Var previousSceneType As eGameScene = gSceneHistory(gSceneHistory.LastIndex)
		  ReDim gSceneHistory(gSceneHistory.LastIndex - 1) // Remove last item
		  SwitchToScene(previousSceneType, False) // Don't add to history
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleInputForCurrentScene(inputData As Dictionary)
		  // Route input to active scene
		  If gCurrentScene <> Nil And gCurrentScene.IsActive() Then
		    gCurrentScene.HandleInput(inputData)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Initialize()
		  // Setup router system and initialize collections
		  gRegisteredScenes = New Dictionary
		  ReDim gSceneHistory(-1) // Initialize empty array
		  gCurrentScene = Nil
		  gPreviousScene = Nil
		  gIsTransitioning = False

		  // Note: Individual games will register their specific scenes
		  // after Router.Initialize() is called
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTransitioning() As Boolean
		  // Check if any scene transition is in progress
		  Return gIsTransitioning Or (gCurrentScene <> Nil And gCurrentScene.IsTransitioning())
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopScene()
		  // Remove current scene and return to previous in stack
		  If gCurrentScene <> Nil Then
		    // Start fade out transition
		    gCurrentScene.StartTransition(GameScene.eTransitionState.FadingOut)
		    gIsTransitioning = True
		  End If

		  // Return to previous scene after transition
		  GoBack()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PushScene(newSceneType As eGameScene)
		  // Add scene to stack (for modal overlays)
		  If gCurrentScene <> Nil Then
		    // Add current scene to history
		    ReDim gSceneHistory(gSceneHistory.LastIndex + 1)
		    gSceneHistory(gSceneHistory.LastIndex) = GetCurrentSceneType()
		  End If

		  SwitchToScene(newSceneType, False) // Don't add to history since we just did
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegisterScene(sceneType As eGameScene, scene As GameScene)
		  // Register a scene instance for later use
		  If scene = Nil Then
		    Raise New InvalidArgumentException("Cannot register Nil scene")
		  End If

		  gRegisteredScenes.Value(sceneType) = scene
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Shutdown()
		  // Clean shutdown of router system
		  If gCurrentScene <> Nil Then
		    gCurrentScene.Cleanup()
		  End If

		  // Cleanup all registered scenes
		  For Each entry As DictionaryEntry In gRegisteredScenes
		    Var scene As GameScene = entry.Value
		    If scene <> Nil Then
		      scene.Cleanup()
		    End If
		  Next

		  gRegisteredScenes.RemoveAll()
		  ReDim gSceneHistory(-1)
		  gCurrentScene = Nil
		  gPreviousScene = Nil
		  gIsTransitioning = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwitchToScene(newSceneType As eGameScene, Optional addToHistory As Boolean = True)
		  // Transition to specified scene with animation
		  Var newScene As GameScene = GetRegisteredScene(newSceneType)

		  If newScene = Nil Then
		    Raise New InvalidArgumentException("Scene type " + Str(newSceneType) + " is not registered")
		  End If

		  // Don't switch to the same scene
		  If gCurrentScene = newScene Then Return

		  // Add current scene to history before switching
		  If addToHistory And gCurrentScene <> Nil Then
		    ReDim gSceneHistory(gSceneHistory.LastIndex + 1)
		    gSceneHistory(gSceneHistory.LastIndex) = GetCurrentSceneType()
		  End If

		  // Store previous scene reference
		  gPreviousScene = gCurrentScene

		  // Start fade out on current scene
		  If gCurrentScene <> Nil Then
		    gCurrentScene.StartTransition(GameScene.eTransitionState.FadingOut)
		  End If

		  // Set new scene as current
		  gCurrentScene = newScene

		  // Initialize scene if needed
		  If Not gCurrentScene.IsInitialized() Then
		    gCurrentScene.Init()
		    gCurrentScene.SetInitialized(True)
		  End If

		  // Start fade in on new scene
		  gCurrentScene.StartTransition(GameScene.eTransitionState.FadingIn)
		  gIsTransitioning = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateCurrentScene(deltaTime As Double)
		  // Update active scene and handle transitions
		  If gCurrentScene = Nil Then Return

		  // Update scene transition
		  gCurrentScene.UpdateTransition(deltaTime)

		  // Update scene logic if active and not transitioning out
		  If gCurrentScene.IsActive() And Not gCurrentScene.IsTransitioning() Then
		    gCurrentScene.Update(deltaTime)
		  End If

		  // Check if transition completed
		  If gIsTransitioning And Not gCurrentScene.IsTransitioning() Then
		    gIsTransitioning = False
		  End If

		  // Update previous scene transition if needed
		  If gPreviousScene <> Nil And gPreviousScene.IsTransitioning() Then
		    gPreviousScene.UpdateTransition(deltaTime)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Private Function GetCurrentSceneType() As eGameScene
		  // Convert current scene to its enum type
		  // This is a helper method to determine the scene type
		  // Individual games will need to implement scene type detection
		  // based on their scene ID or class type

		  If gCurrentScene = Nil Then
		    Return Router.eGameScene.MainMenu // Default fallback
		  End If

		  Var sceneID As String = gCurrentScene.GetSceneID()

		  // Map scene IDs to enum values
		  Select Case sceneID
		  Case "MainMenu", "HelloScene"
		    Return Router.eGameScene.MainMenu
		  Case "HowToPlay"
		    Return Router.eGameScene.HowToPlay
		  Case "GamePlay"
		    Return Router.eGameScene.GamePlay
		  Case "Results"
		    Return Router.eGameScene.Results
		  Case "Settings"
		    Return Router.eGameScene.Settings
		  Case "Credits"
		    Return Router.eGameScene.Credits
		  Else
		    Return Router.eGameScene.MainMenu
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Private gCurrentScene As GameScene
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gIsTransitioning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gPreviousScene As GameScene
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gRegisteredScenes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gSceneHistory() As eGameScene
	#tag EndProperty


	#tag Enum, Name = eGameScene, Flags = &h0
		MainMenu
		  HowToPlay
		  GamePlay
		  Results
		  Settings
		Credits
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
			Visible="true"
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule