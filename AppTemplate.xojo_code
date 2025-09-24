#tag Module
Protected Module AppTemplate
	#tag Method, Flags = &h0
		Function CalculateDeltaTime() As Double
		  // Calculate time elapsed since last frame
		  Var currentTime As Double = System.Microseconds / 1000000.0

		  If gLastFrameTime = 0.0 Then
		    gLastFrameTime = currentTime
		    Return 0.016 // Default to 16ms for first frame
		  End If

		  Var deltaTime As Double = currentTime - gLastFrameTime
		  gLastFrameTime = currentTime

		  // Cap delta time to prevent large jumps (e.g., during debugging)
		  If deltaTime > kMaxDeltaTime Then
		    deltaTime = kMaxDeltaTime
		  End If

		  Return deltaTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMainWindow() As DesktopWindow
		  // Return reference to main game window
		  Return gGameWindow
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTargetFPS() As Integer
		  // Return desired frames per second
		  Return gTargetFPS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInitialized() As Boolean
		  // Check if application has been properly initialized
		  Return gIsInitialized
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitializeApplication(mainWindow As DesktopWindow)
		  // Setup all shared systems and components
		  If gIsInitialized Then Return

		  Try
		    // Store main window reference
		    gGameWindow = mainWindow
		    gTargetFPS = SharedConstants.kTargetFPS
		    gLastFrameTime = 0.0
		    gFrameCount = 0
		    gFPSCounter = 0.0
		    gFPSUpdateTime = 0.0

		    // Initialize Router system
		    Router.Initialize()

		    // Initialize other shared systems
		    // Note: Individual systems will be initialized as needed
		    // AudioHelper.Initialize() - called by games that need audio
		    // SettingsManager.LoadSettings() - called by games that need settings

		    gIsInitialized = True

		  Catch e As RuntimeException
		    // Log initialization error
		    System.DebugLog("AppTemplate.InitializeApplication failed: " + e.Message)
		    Raise e
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RenderFrame(g As Graphics)
		  // Render current scene and debug overlays
		  If Not gIsInitialized Then Return

		  Try
		    // Clear background
		    g.DrawingColor = Color.Black
		    g.FillRectangle(0, 0, SharedConstants.kWindowWidth, SharedConstants.kWindowHeight)

		    // Render current scene through Router
		    Router.DrawCurrentScene(g)

		    // Update FPS counter
		    UpdateFPSCounter()

		  Catch e As RuntimeException
		    // Log rendering error
		    System.DebugLog("AppTemplate.RenderFrame failed: " + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTargetFPS(fps As Integer)
		  // Change desired frame rate
		  If fps > 0 And fps <= 120 Then
		    gTargetFPS = fps
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShutdownApplication()
		  // Clean shutdown of all systems
		  If Not gIsInitialized Then Return

		  Try
		    // Shutdown Router system
		    Router.Shutdown()

		    // Reset application state
		    gGameWindow = Nil
		    gIsInitialized = False
		    gLastFrameTime = 0.0
		    gFrameCount = 0

		  Catch e As RuntimeException
		    // Log shutdown error
		    System.DebugLog("AppTemplate.ShutdownApplication failed: " + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartGameLoop()
		  // Begin main update/render loop
		  // Note: This is typically called from the main window's Timer.Action event
		  // The actual timer setup should be done in the game's main window

		  If Not gIsInitialized Then
		    Raise New RuntimeException("Application not initialized. Call InitializeApplication() first.")
		  End If

		  // This method serves as documentation for the game loop structure
		  // Individual games should implement this pattern in their main window:
		  //
		  // Sub MainTimer_Action()
		  //   Var deltaTime As Double = AppTemplate.CalculateDeltaTime()
		  //   AppTemplate.UpdateFrame(deltaTime)
		  //   Canvas1.Invalidate(False) // Triggers Paint event for rendering
		  // End Sub
		  //
		  // Sub Canvas1_Paint(g As Graphics)
		  //   AppTemplate.RenderFrame(g)
		  // End Sub
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateFrame(deltaTime As Double)
		  // Update all active systems and current scene
		  If Not gIsInitialized Then Return

		  Try
		    // Update Router and current scene
		    Router.UpdateCurrentScene(deltaTime)

		    // Update frame counter
		    gFrameCount = gFrameCount + 1

		  Catch e As RuntimeException
		    // Log update error
		    System.DebugLog("AppTemplate.UpdateFrame failed: " + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Private Sub UpdateFPSCounter()
		  // Update FPS measurement for debug purposes
		  gFPSUpdateTime = gFPSUpdateTime + CalculateDeltaTime()

		  If gFPSUpdateTime >= 1.0 Then // Update every second
		    gFPSCounter = gFrameCount / gFPSUpdateTime
		    gFrameCount = 0
		    gFPSUpdateTime = 0.0
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Private gFPSCounter As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gFPSUpdateTime As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gFrameCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gGameWindow As DesktopWindow
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gIsInitialized As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gLastFrameTime As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Private gTargetFPS As Integer
	#tag EndProperty


	#tag Constant, Name = kMaxDeltaTime, Type = Double, Dynamic = False, Default = \"0.05", Scope = Private
		#tag Note
			Maximum delta time to prevent large jumps (50ms)
		#tag EndNote
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