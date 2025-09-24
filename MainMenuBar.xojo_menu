#tag DesktopMenuBar
Begin DesktopMenuBar MainMenuBar
   Begin DesktopMenuItem FileMenu
      SpecialMenu = 0
      Text = "&File"
      Index = -2147483648
      AutoEnabled = False
      Visible = True
      Begin DesktopMenuItem QuitSeparator
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnabled = False
         Visible = True
      End
      Begin DesktopMenuItem QuitMenuItem
         SpecialMenu = 0
         Text = "&Quit"
         Index = -2147483648
         ShortcutKey = "Q"
         Shortcut = "Cmd+Q"
         AutoEnabled = False
         Visible = True
      End
   End
   Begin DesktopMenuItem HelpMenu
      SpecialMenu = 0
      Text = "&Help"
      Index = -2147483648
      AutoEnabled = False
      Visible = True
      Begin DesktopMenuItem AboutMenuItem
         SpecialMenu = 0
         Text = "&About"
         Index = -2147483648
         AutoEnabled = False
         Visible = True
      End
   End
End
#tag EndDesktopMenuBar

#tag MenuHandler
Function QuitMenuItem() As Boolean Handles QuitMenuItem.MenuAction
  Return False
End Function
#tag EndMenuHandler

#tag MenuHandler
Function AboutMenuItem() As Boolean Handles AboutMenuItem.MenuAction
  MessageBox("Shared Foundations Demo" + EndOfLine + EndOfLine + _
             "A demonstration of the core framework components for the " + EndOfLine + _
             "September 2025 Xojo Contest games." + EndOfLine + EndOfLine + _
             "Framework components:" + EndOfLine + _
             "• GameScene base class" + EndOfLine + _
             "• Router system" + EndOfLine + _
             "• AppTemplate" + EndOfLine + _
             "• CanvasManager" + EndOfLine + _
             "• SharedConstants")

  Return True
End Function
#tag EndMenuHandler

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