#tag Class
Protected Class HelloScene
Inherits GameScene
	#tag Method, Flags = &h0
		Sub Cleanup()
		  // Release resources when scene is destroyed
		  // Nothing specific to cleanup for this simple scene
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Initialize HelloScene with unique ID
		  Super.Constructor("HelloScene")

		  // Initialize demo properties
		  mMessage = "Hello, Shared Foundations!"
		  mSubMessage = "Press SPACE to continue, F1 for debug info"
		  mMessageColor = Color.White
		  mBackgroundColor = Color.RGB(30, 30, 50) // Dark blue background
		  mAnimationTime = 0.0
		  mShowDebugInfo = False
		  mFrameCounter = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g As Graphics)
		  // Render scene contents to graphics context
		  Try
		    // Clear background
		    g.DrawingColor = mBackgroundColor
		    g.FillRectangle(0, 0, SharedConstants.kWindowWidth, SharedConstants.kWindowHeight)

		    // Calculate animated alpha for fade effect
		    Var alpha As Double = GetTransitionAlpha()
		    If alpha <= 0.0 Then Return

		    // Apply transition alpha to drawing operations
		    // Note: GlobalAlpha not available in Xojo Graphics API - alpha handled per color

		    // Draw animated title
		    DrawAnimatedTitle(g)

		    // Draw subtitle
		    DrawSubtitle(g)

		    // Draw framework info
		    DrawFrameworkInfo(g)

		    // Draw debug info if enabled
		    If mShowDebugInfo Then
		      DrawDebugInfo(g)
		    End If

		    // Graphics alpha reset not needed - handled per drawing operation
		    // Note: GlobalAlpha not available in Xojo Graphics API

		  Catch e As RuntimeException
		    System.DebugLog("HelloScene.Draw failed: " + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleInput(inputData As Dictionary)
		  // Process keyboard and mouse input for scene
		  If inputData = Nil Then Return

		  Try
		    // Handle keyboard input
		    If inputData.HasKey("keyPressed") Then
		      Var key As String = inputData.Value("keyPressed")

		      Select Case key
		      Case " " // Space key
		        // Demonstrate scene switching
		        System.DebugLog("HelloScene: Space pressed - would switch to next scene")

		      Case "F1", "f1"
		        // Toggle debug info
		        mShowDebugInfo = Not mShowDebugInfo

		      Case "Escape", "escape"
		        // Exit demo
		        System.DebugLog("HelloScene: Escape pressed - would exit to menu")
		      End Select
		    End If

		    // Handle mouse input
		    If inputData.HasKey("mouseClicked") Then
		      Var clickX As Integer = inputData.Value("mouseX")
		      Var clickY As Integer = inputData.Value("mouseY")
		      System.DebugLog("HelloScene: Mouse clicked at " + clickX.ToString + ", " + clickY.ToString)
		    End If

		  Catch e As RuntimeException
		    System.DebugLog("HelloScene.HandleInput failed: " + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init()
		  // Initialize scene resources and state
		  Try
		    System.DebugLog("HelloScene: Initializing...")

		    // Reset animation state
		    mAnimationTime = 0.0
		    mFrameCounter = 0

		    // Scene is now ready
		    System.DebugLog("HelloScene: Initialization complete")

		  Catch e As RuntimeException
		    System.DebugLog("HelloScene.Init failed: " + e.Message)
		    Raise e
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Update(deltaTime As Double)
		  // Update scene logic, animations, and state
		  Try
		    // Update animation time
		    mAnimationTime = mAnimationTime + deltaTime
		    mFrameCounter = mFrameCounter + 1

		    // Create a subtle pulsing effect for the title
		    Var pulse As Double = Sin(mAnimationTime * 2.0) * 0.1 + 0.9
		    Var intensity As Integer = 255 * pulse
		    mMessageColor = Color.RGB(intensity, intensity, 255)

		  Catch e As RuntimeException
		    System.DebugLog("HelloScene.Update failed: " + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Private Sub DrawAnimatedTitle(g As Graphics)
		  // Draw the main title with animation
		  g.TextSize = 36
		  g.Bold = True
		  g.DrawingColor = mMessageColor

		  // Calculate centered position
		  Var textWidth As Integer = g.TextWidth(mMessage)
		  Var x As Integer = (SharedConstants.kWindowWidth - textWidth) / 2
		  Var y As Integer = SharedConstants.kWindowHeight / 2 - 50

		  // Add subtle wave animation
		  Var wave As Double = Sin(mAnimationTime * 3.0) * 5
		  y = y + wave

		  g.DrawString(mMessage, x, y)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Private Sub DrawDebugInfo(g As Graphics)
		  // Draw debug information overlay
		  g.TextSize = 12
		  g.Bold = False
		  g.DrawingColor = Color.Yellow

		  Var debugY As Integer = 20
		  Var lineHeight As Integer = 16

		  // Frame information
		  g.DrawString("Frame: " + mFrameCounter.ToString, 20, debugY)
		  debugY = debugY + lineHeight

		  g.DrawString("Animation Time: " + Format(mAnimationTime, "#.##") + "s", 20, debugY)
		  debugY = debugY + lineHeight

		  g.DrawString("Scene ID: " + GetSceneID(), 20, debugY)
		  debugY = debugY + lineHeight

		  g.DrawString("Is Active: " + IsActive().ToString, 20, debugY)
		  debugY = debugY + lineHeight

		  g.DrawString("Is Transitioning: " + IsTransitioning().ToString, 20, debugY)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Private Sub DrawFrameworkInfo(g As Graphics)
		  // Draw information about the shared framework
		  g.TextSize = 14
		  g.Bold = False
		  g.DrawingColor = Color.RGB(200, 200, 255)

		  Var infoY As Integer = SharedConstants.kWindowHeight / 2 + 50
		  Var lineHeight As Integer = 20

		  Var infoLines() As String
		  infoLines.Add("✓ GameScene base class working")
		  infoLines.Add("✓ Router system functional")
		  infoLines.Add("✓ AppTemplate managing application lifecycle")
		  infoLines.Add("✓ CanvasManager handling 60 FPS rendering")
		  infoLines.Add("✓ SharedConstants providing configuration")

		  For i As Integer = 0 To infoLines.LastIndex
		    Var text As String = infoLines(i)
		    Var textWidth As Integer = g.TextWidth(text)
		    Var x As Integer = (SharedConstants.kWindowWidth - textWidth) / 2

		    g.DrawString(text, x, infoY + (i * lineHeight))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Private Sub DrawSubtitle(g As Graphics)
		  // Draw the subtitle text
		  g.TextSize = 16
		  g.Bold = False
		  g.DrawingColor = Color.RGB(180, 180, 180)

		  Var textWidth As Integer = g.TextWidth(mSubMessage)
		  Var x As Integer = (SharedConstants.kWindowWidth - textWidth) / 2
		  Var y As Integer = SharedConstants.kWindowHeight / 2 + 10

		  g.DrawString(mSubMessage, x, y)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAnimationTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrameCounter As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessageColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShowDebugInfo As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubMessage As String
	#tag EndProperty


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