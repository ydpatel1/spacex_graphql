# SpaceX GraphQL App

A Flutter application that displays SpaceX launch data using GraphQL API.

## Features

- View upcoming and past SpaceX launches
- Detailed information about each launch
- Real-time data updates
- Cross-platform support (iOS & Android)

## Prerequisites

- Flutter SDK (version 3.0.0 or higher)
- Dart SDK (version 2.17.0 or higher)
- Android Studio / Xcode for platform-specific development
- Git

## Setup Instructions

1. Clone the repository:
```bash
git clone https://github.com/yourusername/spacex_graphql.git
cd spacex_graphql
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart              # Entry point of the application
├── config/               # Configuration files
├── models/              # Data models
├── screens/             # UI screens
├── services/            # API and business logic
├── widgets/             # Reusable widgets
└── utils/               # Utility functions
```

## Technical Documentation

### Dependencies and Version Management

#### Core Dependencies

##### State Management
- **flutter_bloc (^8.1.3)**
  - Justification: Provides a predictable state management solution
  - Used for: Managing application state, handling complex UI logic
  - Benefits: Separation of concerns, testability, reactive programming

##### GraphQL Integration
- **graphql_flutter (^5.1.2)**
  - Justification: Official Flutter package for GraphQL integration
  - Used for: API communication with SpaceX GraphQL API
  - Benefits: Type-safe queries, efficient data fetching, real-time updates

##### UI Components
- **cached_network_image (^3.3.1)**
  - Justification: Efficient image caching and loading
  - Used for: Launch images and mission patches
  - Benefits: Offline support, reduced bandwidth usage

- **flutter_map (^6.1.0) & latlong2 (^0.9.0)**
  - Justification: Interactive map visualization
  - Used for: Launch site locations and mission trajectories
  - Benefits: Customizable maps, offline support

- **flutter_svg (^2.0.7)**
  - Justification: SVG rendering support
  - Used for: Vector graphics and icons
  - Benefits: Scalable graphics, smaller file sizes

- **fl_chart (^0.65.0)**
  - Justification: Data visualization
  - Used for: Launch statistics and mission data
  - Benefits: Interactive charts, customizable styling

##### Utilities
- **intl (^0.18.1)**
  - Justification: Internationalization and formatting
  - Used for: Date/time formatting, number formatting
  - Benefits: Localization support, consistent formatting

- **shared_preferences (^2.2.2)**
  - Justification: Local storage solution
  - Used for: User preferences, cached data
  - Benefits: Simple key-value storage, persistence

- **connectivity_plus (^6.1.3)**
  - Justification: Network connectivity monitoring
  - Used for: Offline mode detection
  - Benefits: Real-time network status updates

- **equatable (^2.0.5)**
  - Justification: Value equality comparison
  - Used for: State comparison in BLoC
  - Benefits: Clean state management, reduced boilerplate

#### Version Management Strategy

1. **Semantic Versioning**
   - Major version: Breaking changes
   - Minor version: New features, backward compatible
   - Patch version: Bug fixes, backward compatible

2. **Dependency Updates**
   - Regular updates through `flutter pub upgrade`
   - Version constraints using caret (^) for minor updates
   - Lock file (pubspec.lock) for reproducible builds

3. **Security Updates**
   - Regular security audits
   - Automated dependency scanning
   - Immediate updates for security patches

### Architecture Overview

#### Clean Architecture Implementation

##### 1. Presentation Layer
- **Screens**
  - Launch List Screen
  - Launch Details Screen
  - Mission Statistics Screen
  - Settings Screen

- **Widgets**
  - Reusable UI components
  - Custom animations
  - Theme-aware components

- **BLoC Pattern**
  - Event handling
  - State management
  - Business logic separation

##### 2. Domain Layer
- **Entities**
  - Launch
  - Mission
  - Rocket
  - Launch Site

- **Use Cases**
  - GetLaunches
  - GetLaunchDetails
  - GetMissionStatistics
  - UpdateFavorites

- **Repository Interfaces**
  - ILaunchRepository
  - IMissionRepository
  - IUserPreferencesRepository

##### 3. Data Layer
- **Repositories**
  - LaunchRepository
  - MissionRepository
  - UserPreferencesRepository

- **Data Sources**
  - GraphQL API Client
  - Local Storage
  - Cache Manager

- **Models**
  - DTOs (Data Transfer Objects)
  - Entity Mappers

#### Design Decisions

1. **State Management**
   - Chose BLoC for predictable state management
   - Separation of UI and business logic
   - Easy testing and maintenance

2. **API Integration**
   - GraphQL for efficient data fetching
   - Real-time updates support
   - Type-safe queries

3. **Caching Strategy**
   - Multi-level caching
   - Offline-first approach
   - Efficient data synchronization

4. **UI/UX Decisions**
   - Material Design 3
   - Responsive layouts
   - Accessibility support

### Known Issues

1. **Performance**
   - [ ] Large image loading optimization needed
   - [ ] List view performance with many items
   - [ ] Memory management in long sessions

2. **Network**
   - [ ] Intermittent connection handling
   - [ ] API timeout management
   - [ ] Data synchronization conflicts

3. **UI/UX**
   - [ ] Loading state improvements
   - [ ] Error message localization
   - [ ] Dark mode inconsistencies

### Future Improvements

1. **Features**
   - [ ] User authentication
   - [ ] Push notifications
   - [ ] Offline mode
   - [ ] Social sharing
   - [ ] AR view for launch sites

2. **Technical**
   - [ ] Unit test coverage
   - [ ] Integration tests
   - [ ] Performance monitoring
   - [ ] Analytics integration
   - [ ] CI/CD pipeline

3. **UI/UX**
   - [ ] Custom animations
   - [ ] Advanced filtering
   - [ ] Search functionality
   - [ ] Custom themes
   - [ ] Accessibility improvements

### Screenshots and Recordings

*Note: Add screenshots and recordings of the application here once available*

#### Key Screens
1. Launch List
2. Launch Details
3. Mission Statistics
4. Settings

#### User Flows
1. Launch Discovery
2. Mission Details
3. Statistics View
4. Settings Management

### Development Guidelines

1. **Code Style**
   - Follow Flutter style guide
   - Use meaningful variable names
   - Document public APIs

2. **Testing**
   - Unit tests for business logic
   - Widget tests for UI components
   - Integration tests for features

3. **Documentation**
   - Code comments
   - API documentation
   - Architecture decisions

4. **Version Control**
   - Feature branches
   - Pull request reviews
   - Semantic commit messages

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

Your Name - your.email@example.com
Project Link: [https://github.com/yourusername/spacex_graphql](https://github.com/yourusername/spacex_graphql)

