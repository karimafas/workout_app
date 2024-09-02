# Magic AI Tech Task - Workout App

## Overview

This mobile app was created as part of a tech assessment for Magic AI. 

You can find the Figma design file for this project [here](https://www.figma.com/design/2HTzv60hVPU1cWTpLoJvQD/Magic-AI-Task-Designs?node-id=0-1&t=9wF7WZ7046ILd8VG-1).

## Architecture

The app follows Clean Architecture principles with a feature-first approach. This architecture promotes good separation of concerns and maintainability.

### Project Structure

```
lib/
├── core/
│   ├── assets/
│   ├── widgets/
│   ├── services/
│   └── etc...
└── app/
    └── features/
        ├── home/
        │   ├── domain/
        │   ├── data/
        │   └── presentation/
        └── etc...
```

- `core/`: contains shared logic, widgets, and services used across the app.
- `app/features/`: contains feature-specific implementations.
  - `domain/`: includes entities, repository base classes, and use cases. This layer is independent of any framework or external dependencies, and it ensures that business logic remains separate from implementation details. It also outlines the exact contract between repositories and 
  - `data/`: contains models and repository implementations.
  - `presentation/`: includes widgets, screens, and BLoCs.

## Key Packages and Patterns Used

1. **Dependency Injection**: I used the service locator pattern with the `get_it` package. This provides better testability, scalability, and maintainability by decoupling dependencies.

2. **Navigation**: I decided to go for the `go_router` package for declarative routing within the app.

3. **Local Storage**: I used `hive` and `hive_flutter` for solid local data persistance. This could be swapped out for an API. 

4. **Model Serialization**: I went for the `json_serializable` package to create serialisable and deserialisable models.

5. **Testing**: I used `mocktail` for creating mock objects in tests.

6. **Localization**: I used the `easy_localization` package for handling app localisation and language support more simply. 

## Development Practices

### Commit Naming Convention

This project follows the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification for commit messages. This format makes the commit history more readable and allows for automated changelog generation.

### Flutter Version

This app was developed using Flutter version:
```
Flutter 3.22.2

Dart version 3.4.3
```

## Testing

A range of unit and widget tests are available for the Home module of the app (`test/home/`).

You can also find a number of integration tests which cover the most crucial flows of the app (workout creation, deletion and editing) within `integration_test/app_test.dart`.
