# Shared Foundations Demo Usage

## Overview

This demo demonstrates the core framework components of the Shared Foundations library for the September 2025 Xojo Contest games.

## Framework Components Tested

### ✅ GameScene Base Class
- Abstract base class providing structure for all game scenes
- Implemented methods: Init(), Update(), Draw(), HandleInput(), Cleanup()
- Built-in transition system with fade in/out effects
- Scene lifecycle management

### ✅ Router System
- Scene management and navigation
- Scene history stack for back navigation
- Smooth transitions between scenes
- Scene registration and instantiation

### ✅ AppTemplate Module
- Standardized application lifecycle management
- Delta time calculation for frame-independent updates
- 60 FPS game loop structure
- Error handling and logging

### ✅ CanvasManager Class
- Optimized Canvas rendering with double buffering
- 60 FPS frame rate targeting
- Performance monitoring and FPS calculation
- Graphics context setup and management

### ✅ SharedConstants Module
- Centralized configuration constants
- Window dimensions (1280×720)
- Performance settings and limits
- File naming conventions

## Demo Application Features

### Hello Scene Demo
The demo includes a `HelloScene` that demonstrates:

- **Scene Inheritance**: Properly extends GameScene base class
- **Rendering System**: Animated title with pulsing effect and wave animation
- **Input Handling**: Keyboard and mouse input processing
- **Transition Effects**: Fade in/out with alpha blending
- **Debug Information**: F1 toggleable performance metrics

### Controls
- **SPACE**: Would switch to next scene (logged to debug console)
- **F1**: Toggle debug information overlay
- **ESCAPE**: Would exit to menu (logged to debug console)
- **Mouse Click**: Registers click coordinates (logged to debug console)

### Debug Information (F1)
When enabled, shows:
- Frame counter
- Animation time
- Scene ID
- Scene active status
- Transition state

## Running the Demo

### Prerequisites
- Xojo 2023r4 or later with API 2.0 support
- Any supported platform (Windows, macOS, Linux)

### Setup
1. Open `SharedFoundationsDemo.xojo_project` in Xojo
2. Build and run the application
3. The demo window should open at 1280×720 resolution
4. You should see the animated "Hello, Shared Foundations!" message

### Expected Behavior
- Smooth 60 FPS animation with pulsing title
- Responsive input handling
- Clean fade transitions
- Debug information available via F1
- Proper error handling and logging

## Integration Guide

To use these components in your game projects:

### 1. Copy Core Files
Copy these files to your game project:
- `GameScene.xojo_code`
- `Router.xojo_code`
- `AppTemplate.xojo_code`
- `CanvasManager.xojo_code`
- `SharedConstants.xojo_code`

### 2. Initialize in Your App
```xojo
Sub Opening() // In your main window
  // Initialize shared foundations
  AppTemplate.InitializeApplication(Self)

  // Create your custom scenes
  Var menuScene As New YourMenuScene
  Var gameScene As New YourGameScene

  // Register scenes with Router
  Router.RegisterScene(Router.eGameScene.MainMenu, menuScene)
  Router.RegisterScene(Router.eGameScene.GamePlay, gameScene)

  // Switch to initial scene
  Router.SwitchToScene(Router.eGameScene.MainMenu)

  // Start game loop
  GameTimer.Enabled = True
End Sub
```

### 3. Implement Game Loop
```xojo
Sub GameTimer_Action() // 16ms timer for 60 FPS
  Var deltaTime As Double = AppTemplate.CalculateDeltaTime()
  AppTemplate.UpdateFrame(deltaTime)
  GameCanvas.Invalidate(False)
End Sub

Sub GameCanvas_Paint(g As Graphics)
  AppTemplate.RenderFrame(g)
End Sub
```

### 4. Create Custom Scenes
```xojo
Class YourGameScene
Inherits GameScene

Sub Constructor()
  Super.Constructor("YourGameScene")
End Sub

Sub Init()
  // Initialize game resources
End Sub

Sub Update(deltaTime As Double)
  // Update game logic
End Sub

Sub Draw(g As Graphics)
  // Render game content
End Sub

Sub HandleInput(inputData As Dictionary)
  // Process input
End Sub

Sub Cleanup()
  // Release resources
End Sub
```

## Performance Notes

- The framework targets 60 FPS with 16ms update intervals
- Double buffering is used by default for smooth rendering
- Delta time is calculated automatically for frame-independent updates
- Large delta times are capped to prevent issues during debugging
- FPS monitoring is built-in for performance analysis

## Error Handling

- All framework methods include try-catch error handling
- Errors are logged to the system debug log
- Graceful fallbacks prevent crashes during development
- Invalid parameters raise appropriate exceptions

## Next Steps

This core framework is ready for use in the four contest games:
1. **Chain Reaction Simulator** - Add ReactorGrid and ChainReaction scenes
2. **Digital Escape Room** - Add RoomScene and puzzle management
3. **Gravity Maze** - Add MazeScene with physics system
4. **Stock Market Madness** - Add TradingScene with market simulation

Each game can extend these foundation components while maintaining consistency and performance across all contest entries.