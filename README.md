# Shared Foundations

## Overview

The Shared Foundations library provides common components and utilities used across all four games in the September 2025 Xojo Contest project. This modular approach ensures consistency, reduces code duplication, and accelerates development by providing battle-tested components that can be easily integrated into any of the game projects.

## Purpose

This library serves as the foundation for:
- **Chain Reaction Simulator** - Puzzle/Reflex game with cascading explosions
- **Digital Escape Room** - Puzzle/Adventure game with interactive hotspots
- **Gravity Maze** - Puzzle/Reflex game with gravity-based movement
- **Stock Market Madness** - Reflex/Strategy trading simulation

## Core Components

### Game Framework
- **GameScene Base Class**: Abstract foundation for all game scenes with standardized Init, Update, Draw, and HandleInput methods
- **Router System**: Scene management and transition system for switching between menu, gameplay, and results screens
- **App Module Template**: Standardized application entry point and global state management

### Rendering System
- **Canvas Management**: 60 FPS rendering pipeline using Canvas with optimized `Invalidate(False)` timing
- **FPS Timer Loop**: Precision timing system ensuring consistent frame rates across platforms
- **Graphics Utilities**: Common drawing functions, coordinate transformations, and visual effects

### User Interface
- **Button Component**: Customizable button with hover states, click feedback, and visual styling
- **Label Component**: Text display with multiple fonts, colors, and alignment options
- **Panel Component**: Container for grouping UI elements with background and border options
- **Popup Dialog System**: Modal dialogs for messages, confirmations, and simple input

### Input Handling
- **Keyboard Manager**: Centralized keyboard input processing with key mapping and state tracking
- **Mouse Manager**: Mouse event handling including clicks, drags, hover detection, and coordinate mapping
- **Input Router**: Channel input events to appropriate game components based on current context

### Audio System
- **Assets Loader**: Preloading system for sounds and music to eliminate runtime latency
- **Audio Helper**: Sound playback management with volume control, looping, and audio mixing
- **Sound Pool**: Efficient management of multiple simultaneous audio effects

### Data Management
- **Save/Load System**: JSON-based persistence for game progress, settings, and player data
- **Settings Manager**: Configuration management for graphics, audio, and gameplay preferences
- **File Utilities**: Cross-platform file operations for application data and content

### Utility Libraries
- **RNG Helper**: Deterministic random number generation with seeding for reproducible results
- **Stopwatch**: High-precision timing for performance measurement and gameplay features
- **Easing Functions**: Animation curves for smooth transitions and visual effects
- **Particles System**: Basic particle emitter for explosions, trails, and ambient effects

### Development Tools
- **Debug Overlay**: F1-toggleable performance metrics including FPS, memory usage, and object counts
- **Logging System**: Configurable logging with different severity levels and output destinations
- **Performance Profiler**: Built-in profiling tools for identifying bottlenecks

## Installation and Usage

### Integration Steps
1. Copy the Shared Foundations folder to your game project directory
2. Add shared components to your project's .xojo_project file
3. Import required modules and classes into your game's App module
4. Initialize shared systems in your application's Open event

### Basic Implementation
```xojo
// In your App module Open event
Call SharedFoundations.Initialize()
Call AudioHelper.LoadSounds()
Call SettingsManager.LoadSettings()
```

### Scene Management Example
```xojo
// Switching between game scenes
Router.SwitchToScene(Router.eGameScene.MainMenu)
Router.SwitchToScene(Router.eGameScene.GamePlay)
Router.SwitchToScene(Router.eGameScene.Results)
```

## System Requirements

- **Xojo Version**: 2023r4 or later (API 2.0)
- **Platform Support**: Windows, macOS, Linux (Xojo Desktop)
- **Target Resolution**: 1280×720 (optimized for contest requirements)
- **Memory**: 256 MB minimum for shared systems
- **Storage**: 10 MB for shared components and assets

## Architecture Benefits

### Consistency
- Unified look and feel across all four games
- Standardized user interface patterns and behaviors
- Common audio and visual feedback systems

### Efficiency
- Shared code reduces overall project size and complexity
- Proven components reduce development time and debugging
- Consistent performance characteristics across games

### Maintainability
- Single location for bug fixes and improvements
- Standardized APIs reduce learning curve for developers
- Modular design enables easy component updates

### Contest Readiness
- Built-in debug tools for demonstration purposes
- Standardized contest requirements (resolution, windowing, etc.)
- Professional polish and error handling throughout

## Component Dependencies

### Required Components
All games must include:
- GameScene base class
- Router system
- Audio helper
- Settings manager

### Optional Components
Include as needed:
- Particle system (for visual effects)
- Advanced UI components (for complex interfaces)
- Performance profiler (for optimization)

## Future Enhancements

### Planned Features
- Network communication helpers (for future multiplayer support)
- Advanced animation system with keyframes
- Texture atlas management for optimized graphics
- Localization system for multiple languages

### Stretch Goals
- Visual scripting system for non-programmers
- Automated testing framework for quality assurance
- Performance monitoring and analytics
- Plugin architecture for third-party extensions

## Support and Documentation

For detailed technical documentation, see the accompanying DEVELOPER.md file which includes:
- Complete API reference for all components
- Implementation examples and best practices
- Performance optimization guidelines
- Troubleshooting and debugging information

---

*The Shared Foundations library accelerates game development while ensuring professional quality and consistency across all contest entries.*