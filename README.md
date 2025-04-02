# CombineAPI

A Swift iOS application demonstrating the use of Combine framework for reactive programming and Core Data for persistent storage.

## Overview

This project showcases modern iOS development practices using:
- **Combine Framework**: For reactive programming and handling asynchronous operations
- **Core Data**: For local data persistence and management
- **MVVM Architecture**: For clean separation of concerns

## Features

- Reactive API calls using Combine
- Efficient data persistence with Core Data
- Clean architecture with MVVM pattern
- Unit and UI testing support

## Project Structure

```
CombineAPI/
├── CombineAPI/           # Main application code
│   ├── Model/           # Data models
│   ├── Networking/      # API service and networking layer
│   ├── ViewModels/      # View models for MVVM
│   └── Views/           # SwiftUI views
├── CombineAPITests/     # Unit tests
└── CombineAPIUITests/   # UI tests
```

## Combine Framework Usage

The project uses Combine for:
- Handling asynchronous API calls
- Managing data flow between components
- Reactive UI updates
- Error handling

Example of Combine usage in API calls:
```swift
func fetchData<T>(from url: String, modelType: T.Type) -> AnyPublisher<T, Error> {
    return urlSession.dataTaskPublisher(for: urlObj)
        .tryMap({ data, response in
            // Handle response
        })
        .decode(type: modelType.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}
```

## Core Data Integration

Core Data is used for:
- Local data persistence
- Efficient data management
- Relationship handling between entities
- Background context operations

## Requirements

- iOS 13.0+
- Xcode 12.0+
- Swift 5.0+

## Installation

1. Clone the repository
2. Open `CombineAPI.xcodeproj` in Xcode
3. Build and run the project

## Testing

The project includes:
- Unit tests for business logic
- UI tests for interface testing
- Mock API service for testing

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details 