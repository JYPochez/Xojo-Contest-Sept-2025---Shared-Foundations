#tag Class
Protected Class CanvasManager
	#tag Method, Flags = &h0
		Sub BeginFrame()
		  // Start new frame rendering
		  If mTargetCanvas = Nil Then Return
		  
		  mFrameStartTime = System.Microseconds / 1000000.0
		  
		  // Create back buffer if needed
		  If mBackBuffer = Nil Or mBackBuffer.Width <> mTargetCanvas.Width Or mBackBuffer.Height <> mTargetCanvas.Height Then
		    CreateBackBuffer()
		  End If
		  
		  // Get graphics context for back buffer
		  If mBackBuffer <> Nil Then
		    mBackBufferGraphics = mBackBuffer.Graphics
		    SetupGraphicsContext(mBackBufferGraphics)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(targetCanvas As DesktopCanvas)
		  // Initialize canvas management system
		  If targetCanvas = Nil Then
		    Raise New InvalidArgumentException("Target canvas cannot be Nil")
		  End If
		  
		  mTargetCanvas = targetCanvas
		  mRenderingEnabled = True
		  mFrameRate = 0.0
		  mLastRenderTime = 0.0
		  mFrameCount = 0
		  mFrameRateUpdateTime = 0.0
		  mBackBuffer = Nil
		  mBackBufferGraphics = Nil
		  mUseDoubleBuffering = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CreateBackBuffer()
		  // Create off-screen rendering buffer
		  If mTargetCanvas = Nil Then Return
		  
		  Try
		    Var width As Integer = mTargetCanvas.Width
		    Var height As Integer = mTargetCanvas.Height
		    
		    If width > 0 And height > 0 Then
		      mBackBuffer = New Picture(width, height)
		      mBackBufferGraphics = mBackBuffer.Graphics
		      SetupGraphicsContext(mBackBufferGraphics)
		    End If
		    
		  Catch e As RuntimeException
		    System.DebugLog("CanvasManager.CreateBackBuffer failed: " + e.Message)
		    mBackBuffer = Nil
		    mBackBufferGraphics = Nil
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBackBufferGraphics() As Graphics
		  // Get graphics context for direct drawing to back buffer
		  If Not mRenderingEnabled Or mBackBufferGraphics = Nil Then Return Nil

		  // Clear back buffer
		  mBackBufferGraphics.DrawingColor = Color.Black
		  mBackBufferGraphics.FillRectangle(0, 0, mBackBuffer.Width, mBackBuffer.Height)

		  Return mBackBufferGraphics
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EndFrame()
		  // Complete frame and present to screen
		  If Not mRenderingEnabled Then Return
		  
		  Try
		    // Present back buffer to canvas
		    If mUseDoubleBuffering And mBackBuffer <> Nil Then
		      PresentFrame()
		    End If
		    
		    // Update performance metrics
		    UpdateFrameRate()
		    
		  Catch e As RuntimeException
		    System.DebugLog("CanvasManager.EndFrame failed: " + e.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFrameRate() As Double
		  // Return current FPS measurement
		  Return mFrameRate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTargetCanvas() As DesktopCanvas
		  // Return the target canvas reference
		  Return mTargetCanvas
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBackBuffer() As Picture
		  // Return the back buffer for direct drawing in Paint events
		  Return mBackBuffer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRenderingEnabled() As Boolean
		  // Check if rendering is currently enabled
		  Return mRenderingEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PresentFrame()
		  // Copy back buffer to visible canvas
		  If mTargetCanvas = Nil Or mBackBuffer = Nil Then Return

		  // Trigger canvas refresh to display the back buffer
		  // The actual drawing will be handled in the canvas Paint event
		  mTargetCanvas.Refresh(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDoubleBuffering(enabled As Boolean)
		  // Enable/disable double buffering
		  mUseDoubleBuffering = enabled
		  
		  If Not enabled And mBackBuffer <> Nil Then
		    // Release back buffer when double buffering is disabled
		    mBackBuffer = Nil
		    mBackBufferGraphics = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRenderingEnabled(enabled As Boolean)
		  // Enable/disable rendering (for debugging)
		  mRenderingEnabled = enabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupGraphicsContext(g As Graphics)
		  // Configure graphics context for optimal rendering
		  If g = Nil Then Return
		  
		  // Enable anti-aliasing for smooth graphics
		  g.AntiAlias = True

		  // Set high quality text rendering
		  g.AntiAliasMode = Graphics.AntiAliasModes.HighQuality

		  // Set default drawing properties
		  g.DrawingColor = Color.White
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateFrameRate()
		  // Update FPS measurement
		  Var currentTime As Double = System.Microseconds / 1000000.0
		  mFrameCount = mFrameCount + 1
		  
		  If mLastRenderTime = 0.0 Then
		    mLastRenderTime = currentTime
		    Return
		  End If
		  
		  mFrameRateUpdateTime = mFrameRateUpdateTime + (currentTime - mLastRenderTime)
		  mLastRenderTime = currentTime
		  
		  // Update frame rate every second
		  If mFrameRateUpdateTime >= 1.0 Then
		    mFrameRate = mFrameCount / mFrameRateUpdateTime
		    mFrameCount = 0
		    mFrameRateUpdateTime = 0.0
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBackBuffer As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBackBufferGraphics As Graphics
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrameCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrameRate As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrameRateUpdateTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFrameStartTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastRenderTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRenderingEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetCanvas As DesktopCanvas
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseDoubleBuffering As Boolean
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
