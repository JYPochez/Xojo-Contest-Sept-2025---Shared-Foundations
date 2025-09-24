# Shared Foundations - Developer Documentation

## Library Architecture

### Project Structure
```
Shared Foundations/
├── Core/
│   ├── GameScene (Class)
│   ├── Router (Module)
│   └── AppTemplate (Module)
├── UI/
│   ├── Button (Class)
│   ├── Label (Class)
│   ├── Panel (Class)
│   └── DialogManager (Class)
├── Input/
│   ├── KeyboardManager (Class)
│   ├── MouseManager (Class)
│   └── InputRouter (Class)
├── Audio/
│   ├── AudioHelper (Module)
│   ├── SoundPool (Class)
│   └── AssetLoader (Class)
├── Graphics/
│   ├── CanvasManager (Class)
│   ├── GraphicsUtils (Module)
│   └── ParticleSystem (Class)
├── Data/
│   ├── SaveLoadManager (Class)
│   ├── SettingsManager (Module)
│   └── FileUtils (Module)
├── Utils/
│   ├── RNGHelper (Module)
│   ├── Stopwatch (Class)
│   ├── EasingFunctions (Module)
│   └── MathUtils (Module)
├── Debug/
│   ├── DebugOverlay (Class)
│   ├── Logger (Module)
│   └── Profiler (Class)
└── Constants/
    └── SharedConstants (Module)
```

## Core Framework Classes

### GameScene (Class)
Abstract base class providing the foundation for all game scenes.

**Properties:**
- `mIsActive As Boolean` - Scene activation state
- `mIsInitialized As Boolean` - Initialization completion flag
- `mSceneID As String` - Unique scene identifier
- `mTransitionState As eTransitionState` - Current transition status

**Enums:**
```xojo
// Stored within GameScene class
Enum eTransitionState
  None
  FadingIn
  Active
  FadingOut
End Enum
```

**Abstract Methods (must be implemented by subclasses):**
```xojo
Sub Init()
  // Initialize scene resources and state

Sub Update(deltaTime As Double)
  // Update scene logic, animations, and state

Sub Draw(g As Graphics)
  // Render scene contents to graphics context

Sub HandleInput(inputData As Dictionary)
  // Process keyboard and mouse input for scene

Sub Cleanup()
  // Release resources when scene is destroyed
```

**Base Methods:**
```xojo
Sub Constructor(sceneID As String)
  // Initialize base scene properties

Function IsActive() As Boolean
  // Return current activation status

Sub SetActive(active As Boolean)
  // Change scene activation state

Sub StartTransition(newState As eTransitionState)
  // Begin scene transition animation
```

### Router (Module)
Central scene management and navigation system.

**Enums:**
```xojo
// Stored within Router module
Enum eGameScene
  MainMenu
  HowToPlay
  GamePlay
  Results
  Settings
  Credits
End Enum
```

**Properties:**
- `gCurrentScene As GameScene` - Currently active scene
- `gPreviousScene As GameScene` - Previous scene for back navigation
- `gSceneStack As GameScene()` - Scene history stack
- `gTransitionTime As Double` - Duration of scene transitions

**Methods:**
```xojo
Sub Initialize()
  // Setup router system and register default scenes

Sub SwitchToScene(newScene As eGameScene)
  // Transition to specified scene with animation

Sub PushScene(newScene As eGameScene)
  // Add scene to stack (for modal overlays)

Sub PopScene()
  // Return to previous scene in stack

Sub UpdateCurrentScene(deltaTime As Double)
  // Update active scene and handle transitions

Sub DrawCurrentScene(g As Graphics)
  // Render active scene and transition effects

Function GetCurrentSceneID() As String
  // Return identifier of active scene
```

### AppTemplate (Module)
Standardized application structure and initialization.

**Properties:**
- `gIsInitialized As Boolean` - Application initialization status
- `gGameWindow As Window` - Main game window reference
- `gLastFrameTime As Double` - Previous frame timestamp for delta calculation
- `gTargetFPS As Integer` - Desired frames per second (typically 60)

**Methods:**
```xojo
Sub InitializeApplication()
  // Setup all shared systems and components

Sub StartGameLoop()
  // Begin main update/render loop

Sub UpdateFrame(deltaTime As Double)
  // Update all active systems and current scene

Sub RenderFrame(g As Graphics)
  // Render current scene and debug overlays

Sub ShutdownApplication()
  // Clean shutdown of all systems

Function CalculateDeltaTime() As Double
  // Calculate time elapsed since last frame
```

## UI Component Library

### Button (Class)
Customizable button component with states and styling.

**Enums:**
```xojo
// Stored within Button class
Enum eButtonState
  Normal
  Hover
  Pressed
  Disabled
End Enum
```

**Properties:**
- `mBounds As Rectangle` - Button position and size
- `mText As String` - Button label text
- `mState As eButtonState` - Current interaction state
- `mTextColor As Color` - Text color for each state
- `mBackgroundColor As Color` - Background color for each state
- `mIsEnabled As Boolean` - Whether button responds to input

**Methods:**
```xojo
Sub Constructor(x As Integer, y As Integer, width As Integer, height As Integer)
  // Initialize button with position and size

Sub SetText(text As String)
  // Update button label

Sub SetColors(textColor As Color, backgroundColor As Color, state As eButtonState)
  // Configure colors for specific button state

Function HandleMouseMove(x As Integer, y As Integer) As Boolean
  // Update button state based on mouse position

Function HandleMouseClick(x As Integer, y As Integer) As Boolean
  // Process mouse click, return true if button was clicked

Sub Draw(g As Graphics)
  // Render button with current state styling

Function IsPointInside(x As Integer, y As Integer) As Boolean
  // Check if coordinates are within button bounds
```

### Label (Class)
Text display component with formatting options.

**Properties:**
- `mBounds As Rectangle` - Label position and size
- `mText As String` - Display text content
- `mFont As Font` - Text font and size
- `mTextColor As Color` - Text color
- `mAlignment As eTextAlignment` - Text alignment within bounds
- `mWordWrap As Boolean` - Whether to wrap long text

**Enums:**
```xojo
// Stored within Label class
Enum eTextAlignment
  Left
  Center
  Right
End Enum
```

**Methods:**
```xojo
Sub Constructor(x As Integer, y As Integer, width As Integer, height As Integer)
  // Initialize label with position and size

Sub SetText(text As String)
  // Update display text

Sub SetFont(font As Font)
  // Change text font

Sub SetAlignment(alignment As eTextAlignment)
  // Set text alignment

Sub Draw(g As Graphics)
  // Render text with current formatting

Function GetTextWidth() As Integer
  // Calculate rendered text width

Function GetTextHeight() As Integer
  // Calculate rendered text height
```

### Panel (Class)
Container component for grouping UI elements.

**Properties:**
- `mBounds As Rectangle` - Panel position and size
- `mBackgroundColor As Color` - Panel background color
- `mBorderColor As Color` - Panel border color
- `mBorderWidth As Integer` - Border thickness
- `mChildComponents As Variant()` - Array of contained UI elements
- `mIsVisible As Boolean` - Panel visibility state

**Methods:**
```xojo
Sub Constructor(x As Integer, y As Integer, width As Integer, height As Integer)
  // Initialize panel with position and size

Sub AddChild(component As Variant)
  // Add UI component to panel

Sub RemoveChild(component As Variant)
  // Remove UI component from panel

Sub SetBackground(color As Color)
  // Change panel background color

Sub SetBorder(color As Color, width As Integer)
  // Configure panel border

Sub Draw(g As Graphics)
  // Render panel background, border, and all child components

Function HandleInput(inputData As Dictionary) As Boolean
  // Route input to appropriate child components
```

## Input Management System

### KeyboardManager (Class)
Centralized keyboard input processing and state tracking.

**Properties:**
- `mKeyStates As Dictionary` - Current state of all keys
- `mKeyBindings As Dictionary` - Key to action mappings
- `mModifierKeys As Dictionary` - Shift, Ctrl, Alt, Cmd states

**Methods:**
```xojo
Sub Constructor()
  // Initialize keyboard state tracking

Sub ProcessKeyDown(key As String)
  // Record key press and trigger associated actions

Sub ProcessKeyUp(key As String)
  // Record key release

Function IsKeyPressed(key As String) As Boolean
  // Check if key is currently pressed

Function IsKeyJustPressed(key As String) As Boolean
  // Check if key was pressed this frame (edge detection)

Sub BindKey(key As String, action As String)
  // Associate key with named action

Function GetBoundAction(key As String) As String
  // Return action name for specified key

Sub ClearAllKeys()
  // Reset all key states (useful for focus changes)
```

### MouseManager (Class)
Mouse input handling with position tracking and button states.

**Properties:**
- `mMouseX As Integer` - Current mouse X coordinate
- `mMouseY As Integer` - Current mouse Y coordinate
- `mPreviousX As Integer` - Previous frame mouse X
- `mPreviousY As Integer` - Previous frame mouse Y
- `mLeftButtonDown As Boolean` - Left button state
- `mRightButtonDown As Boolean` - Right button state
- `mMiddleButtonDown As Boolean` - Middle button state

**Methods:**
```xojo
Sub Constructor()
  // Initialize mouse state tracking

Sub ProcessMouseMove(x As Integer, y As Integer)
  // Update mouse position

Sub ProcessMouseDown(button As Integer, x As Integer, y As Integer)
  // Record button press at coordinates

Sub ProcessMouseUp(button As Integer, x As Integer, y As Integer)
  // Record button release

Function GetMousePosition() As Point
  // Return current mouse coordinates

Function GetMouseDelta() As Point
  // Return mouse movement since last frame

Function IsButtonPressed(button As Integer) As Boolean
  // Check if mouse button is currently pressed

Function IsButtonJustPressed(button As Integer) As Boolean
  // Check if button was pressed this frame
```

### InputRouter (Class)
Routes input events to appropriate game components based on context.

**Properties:**
- `mActiveInputTarget As Variant` - Component currently receiving input
- `mInputQueue As Dictionary()` - Queued input events for processing
- `mModalComponents As Variant()` - Components that capture all input

**Methods:**
```xojo
Sub Constructor()
  // Initialize input routing system

Sub SetActiveTarget(target As Variant)
  // Direct input to specific component

Sub PushModalTarget(target As Variant)
  // Add modal component that captures all input

Sub PopModalTarget()
  // Remove most recent modal input target

Sub RouteInput(inputType As String, inputData As Dictionary)
  // Send input to appropriate target based on current context

Sub ProcessInputQueue()
  // Handle all queued input events

Sub ClearInputQueue()
  // Remove all pending input events
```

## Audio System

### AudioHelper (Module)
Sound playback management with volume control and mixing.

**Properties:**
- `gSoundLibrary As Dictionary` - Loaded sound files by ID
- `gMasterVolume As Double` - Overall volume level (0.0-1.0)
- `gEffectsVolume As Double` - Sound effects volume
- `gMusicVolume As Double` - Background music volume
- `gIsMuted As Boolean` - Audio mute state

**Methods:**
```xojo
Sub Initialize()
  // Setup audio system and load default sounds

Sub LoadSound(soundID As String, filePath As String)
  // Load sound file and store with identifier

Sub PlaySound(soundID As String, volume As Double = 1.0)
  // Play sound effect at specified volume

Sub PlaySoundLooped(soundID As String, volume As Double = 1.0)
  // Start looping sound (for ambient audio)

Sub StopSound(soundID As String)
  // Stop playing specified sound

Sub StopAllSounds()
  // Stop all currently playing audio

Sub SetMasterVolume(volume As Double)
  // Adjust overall audio volume

Sub SetMuted(muted As Boolean)
  // Mute or unmute all audio
```

### SoundPool (Class)
Efficient management of multiple simultaneous audio effects.

**Properties:**
- `mSoundInstances As Sound()` - Pool of reusable sound objects
- `mActiveInstances As Integer()` - Tracking of currently playing sounds
- `mPoolSize As Integer` - Maximum concurrent sounds
- `mNextAvailableIndex As Integer` - Pool allocation pointer

**Methods:**
```xojo
Sub Constructor(poolSize As Integer)
  // Initialize sound pool with specified capacity

Function PlayPooledSound(soundData As MemoryBlock, volume As Double) As Integer
  // Play sound using pool, return instance ID

Sub StopPooledSound(instanceID As Integer)
  // Stop specific sound instance

Sub UpdatePool()
  // Clean up finished sound instances

Function GetAvailableSlots() As Integer
  // Return number of free sound slots

Sub ClearPool()
  // Stop all sounds and reset pool
```

## Graphics and Rendering

### CanvasManager (Class)
Optimized Canvas rendering with double buffering and performance monitoring.

**Properties:**
- `mTargetCanvas As Canvas` - Canvas control for rendering
- `mBackBuffer As Picture` - Off-screen rendering buffer
- `mFrameRate As Double` - Current FPS measurement
- `mLastRenderTime As Double` - Previous frame timestamp
- `mRenderingEnabled As Boolean` - Master rendering switch

**Methods:**
```xojo
Sub Constructor(targetCanvas As Canvas)
  // Initialize canvas management system

Sub BeginFrame()
  // Start new frame rendering

Sub EndFrame()
  // Complete frame and present to screen

Sub DrawToBackBuffer(g As Graphics)
  // Render to off-screen buffer

Sub PresentFrame()
  // Copy back buffer to visible canvas

Function GetFrameRate() As Double
  // Return current FPS measurement

Sub SetRenderingEnabled(enabled As Boolean)
  // Enable/disable rendering (for debugging)
```

### GraphicsUtils (Module)
Common drawing functions and coordinate transformations.

**Methods:**
```xojo
Sub DrawRoundedRectangle(g As Graphics, x As Integer, y As Integer, width As Integer, height As Integer, radius As Integer)
  // Draw rectangle with rounded corners

Sub DrawGradient(g As Graphics, bounds As Rectangle, startColor As Color, endColor As Color, vertical As Boolean)
  // Draw gradient fill

Sub DrawDropShadow(g As Graphics, bounds As Rectangle, offset As Integer, blur As Integer)
  // Add drop shadow effect

Function ScaleRectangle(rect As Rectangle, scale As Double) As Rectangle
  // Scale rectangle by specified factor

Function PointInRectangle(point As Point, rect As Rectangle) As Boolean
  // Test point-rectangle intersection

Sub SetupSmoothGraphics(g As Graphics)
  // Configure graphics context for anti-aliasing
```

### ParticleSystem (Class)
Basic particle emitter for visual effects.

**Properties:**
- `mParticles As Particle()` - Active particle array
- `mMaxParticles As Integer` - Maximum particle count
- `mEmissionRate As Double` - Particles emitted per second
- `mGravity As Vector2D` - Gravitational force applied to particles
- `mIsActive As Boolean` - System emission state

**Particle Structure:**
```xojo
Structure Particle
  X As Double
  Y As Double
  VelocityX As Double
  VelocityY As Double
  Life As Double
  MaxLife As Double
  Size As Double
  Color As Color
  IsActive As Boolean
End Structure
```

**Methods:**
```xojo
Sub Constructor(maxParticles As Integer)
  // Initialize particle system

Sub EmitParticles(x As Double, y As Double, count As Integer)
  // Create new particles at specified position

Sub Update(deltaTime As Double)
  // Update all particle physics and lifetimes

Sub Draw(g As Graphics)
  // Render all active particles

Sub SetGravity(x As Double, y As Double)
  // Configure gravitational force

Sub SetEmissionRate(rate As Double)
  // Change particle generation rate

Sub ClearParticles()
  // Remove all active particles
```

## Data Management

### SaveLoadManager (Class)
JSON-based persistence for game progress and settings.

**Properties:**
- `mSaveDirectory As FolderItem` - Application data folder
- `mDefaultSettings As Dictionary` - Fallback configuration values
- `mCurrentData As Dictionary` - Active game data

**Methods:**
```xojo
Sub Constructor()
  // Initialize save/load system

Function SaveData(data As Dictionary, filename As String) As Boolean
  // Save dictionary to JSON file

Function LoadData(filename As String) As Dictionary
  // Load dictionary from JSON file

Function GetSaveDirectory() As FolderItem
  // Return platform-appropriate save location

Function BackupSaveFile(filename As String) As Boolean
  // Create backup of save file

Function RestoreFromBackup(filename As String) As Boolean
  // Restore save file from backup

Sub ClearSaveData(filename As String)
  // Delete specified save file
```

### SettingsManager (Module)
Configuration management for graphics, audio, and gameplay preferences.

**Properties:**
- `gGraphicsSettings As Dictionary` - Display and rendering options
- `gAudioSettings As Dictionary` - Sound and music preferences
- `gGameplaySettings As Dictionary` - Difficulty and control options
- `gUserPreferences As Dictionary` - Personal customizations

**Methods:**
```xojo
Sub LoadSettings()
  // Load all settings from file or use defaults

Sub SaveSettings()
  // Persist current settings to file

Function GetSetting(category As String, key As String) As Variant
  // Retrieve specific setting value

Sub SetSetting(category As String, key As String, value As Variant)
  // Update specific setting value

Sub ResetToDefaults(category As String)
  // Restore default values for setting category

Function ExportSettings() As String
  // Generate JSON string of all settings
```

## Utility Libraries

### RNGHelper (Module)
Deterministic random number generation with seeding.

**Properties:**
- `gRandomSeed As UInt64` - Current random seed value
- `gRandomState As UInt64` - Internal RNG state

**Methods:**
```xojo
Sub SetSeed(seed As UInt64)
  // Initialize RNG with specific seed for reproducible results

Function RandomInteger(min As Integer, max As Integer) As Integer
  // Generate random integer in specified range

Function RandomDouble() As Double
  // Generate random double between 0.0 and 1.0

Function RandomBoolean() As Boolean
  // Generate random true/false value

Function RandomColor() As Color
  // Generate random RGB color

Function WeightedChoice(choices As String(), weights As Double()) As String
  // Select random item based on weighted probabilities
```

### Stopwatch (Class)
High-precision timing for performance measurement.

**Properties:**
- `mStartTime As Double` - Timer start timestamp
- `mEndTime As Double` - Timer end timestamp
- `mIsRunning As Boolean` - Timer active state
- `mLapTimes As Double()` - Recorded lap durations

**Methods:**
```xojo
Sub Constructor()
  // Initialize stopwatch

Sub Start()
  // Begin timing

Sub Stop()
  // End timing

Sub Reset()
  // Clear timer and return to stopped state

Sub Lap()
  // Record lap time without stopping

Function GetElapsedTime() As Double
  // Return time elapsed since start

Function GetAverageTime() As Double
  // Return average of all recorded times

Function GetFormattedTime() As String
  // Return human-readable time string (MM:SS.mmm)
```

### EasingFunctions (Module)
Animation curves for smooth transitions and visual effects.

**Methods:**
```xojo
Function Linear(t As Double) As Double
  // Linear interpolation (no easing)

Function EaseInQuad(t As Double) As Double
  // Quadratic ease-in

Function EaseOutQuad(t As Double) As Double
  // Quadratic ease-out

Function EaseInOutQuad(t As Double) As Double
  // Quadratic ease-in-out

Function EaseInCubic(t As Double) As Double
  // Cubic ease-in

Function EaseOutCubic(t As Double) As Double
  // Cubic ease-out

Function EaseInOutCubic(t As Double) As Double
  // Cubic ease-in-out

Function EaseInBounce(t As Double) As Double
  // Bounce ease-in

Function EaseOutBounce(t As Double) As Double
  // Bounce ease-out
```

## Debug and Development Tools

### DebugOverlay (Class)
F1-toggleable performance metrics and development information.

**Properties:**
- `mIsVisible As Boolean` - Overlay display state
- `mFPSCounter As Double` - Current frame rate
- `mMemoryUsage As UInt64` - Application memory consumption
- `mObjectCounts As Dictionary` - Count of active game objects
- `mOverlayFont As Font` - Text font for debug display

**Methods:**
```xojo
Sub Constructor()
  // Initialize debug overlay system

Sub Toggle()
  // Show/hide debug overlay

Sub Update(deltaTime As Double)
  // Update performance measurements

Sub Draw(g As Graphics)
  // Render debug information

Sub AddCounter(name As String, value As Integer)
  // Add custom counter to display

Sub RemoveCounter(name As String)
  // Remove custom counter

Function GetPerformanceReport() As String
  // Generate detailed performance summary
```

### Logger (Module)
Configurable logging with different severity levels.

**Enums:**
```xojo
// Stored within Logger module
Enum eLogLevel
  Debug
  Info
  Warning
  Error
  Critical
End Enum
```

**Properties:**
- `gLogLevel As eLogLevel` - Minimum level to record
- `gLogToFile As Boolean` - Whether to write log file
- `gLogToConsole As Boolean` - Whether to output to debug console

**Methods:**
```xojo
Sub Initialize(logLevel As eLogLevel)
  // Setup logging system

Sub LogDebug(message As String)
  // Record debug information

Sub LogInfo(message As String)
  // Record general information

Sub LogWarning(message As String)
  // Record warning message

Sub LogError(message As String)
  // Record error message

Sub LogCritical(message As String)
  // Record critical error

Sub SetLogLevel(level As eLogLevel)
  // Change minimum logging level

Function GetLogContents() As String
  // Return current log contents
```

## Constants and Configuration

### SharedConstants (Module)

**Application Constants:**
```xojo
Const kApplicationName = "Xojo Contest Games 2025"
Const kApplicationVersion = "1.0.0"
Const kTargetFPS = 60
Const kWindowWidth = 1280
Const kWindowHeight = 720
```

**File Paths:**
```xojo
Const kSettingsFileName = "settings.json"
Const kSaveGameFileName = "savegame.json"
Const kHighScoresFileName = "highscores.json"
Const kAssetDirectory = "Assets"
Const kSoundDirectory = "Sounds"
```

**Performance Constants:**
```xojo
Const kMaxParticles = 1000
Const kMaxSoundInstances = 16
Const kDefaultUpdateInterval = 16  // ~60 FPS in milliseconds
Const kMaxFrameSkip = 5
```

**UI Constants:**
```xojo
Const kDefaultButtonWidth = 120
Const kDefaultButtonHeight = 40
Const kDefaultPadding = 10
Const kDefaultBorderWidth = 2
```

## Build Configuration

**Target Platform:** Desktop (Windows, macOS, Linux)
**API Version:** Xojo 2.0
**Dependencies:** None (self-contained library)
**Thread Safety:** Single-threaded design for Xojo compatibility
**Memory Management:** Automatic memory management with cleanup methods