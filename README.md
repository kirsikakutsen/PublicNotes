# Notes App

A cross-platform notes application built with Flutter and Firebase. This app allows users to create, edit, view, and delete notes with a dark theme UI.

## Features

### Core Functionality
- **Create Notes**: Add new notes with title and description
- **Edit Notes**: Modify existing notes with real-time updates
- **View Notes**: Read all user's notes in an organized list
- **Delete Notes**: Remove notes with confirmation dialog
- **Real-time Sync**: All data is synchronized with Firebase Firestore
- **Cross-platform**: Works on Android and iOS

### User Interface
- **Dark Theme**: Dark color scheme
- **Responsive Design**: Adapts to different screen sizes and orientations
- **Material Design**: Follows Material Design principles for consistent UX
- **Loading States**: Loading indicators during data operations
- **Empty States**: Helpful empty state when no notes exist

### User Experience
- **Intuitive Navigation**: Simple navigation between notes list and detail views
- **Confirmation Dialogs**: Safe deletion with confirmation prompts
- **Keyboard Support**: Proper keyboard handling and focus management

## Tech Stack

### Frontend Framework
- **Flutter 3.7.2+**: Cross-platform UI framework by Google
- **Dart**: Programming language for Flutter development

### Backend & Database
- **Firebase Firestore**: NoSQL cloud database for real-time data synchronization
- **Firebase Core**: Core Firebase functionality
- **Firebase Database**: Real-time database capabilities

### State Management
- **Flutter StatefulWidget**: Local state management for UI components
- **FutureBuilder**: Async data handling and loading states

### UI/UX Libraries
- **Material Design**: Google's design system
- **Cupertino Icons**: iOS-style icons
- **Flutter SVG**: SVG image support for custom icons

### Utilities
- **HTTP**: HTTP client for network requests
- **Intl**: Internationalization and formatting
- **Flutter Dotenv**: Environment variable management

## Design System

### Color Palette
- **Background**: Dark navy (`#1A1B26`)
- **Card Background**: Slightly lighter navy (`#24283B`)
- **Text**: Light cream (`#CDD6F4`)
- **Accent**: Blue (`#7AA2F7`)
- **Hints**: Muted gray (`#414C65`)

## Getting Started

### Firebase Configuration

The app requires Firebase Firestore to be configured with the following collection:
- **Collection**: `notes`
- **Fields**: 
  - `title` (string)
  - `description` (string) 
  - `date` (timestamp)

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/
│   └── notes_model.dart      # Note data model
├── services/
│   └── database_service.dart # Firebase operations
├── ui/
│   ├── notes_list/          # Notes list screen
│   ├── note_details/        # Note creation/editing screen
│   └── theme/
│       └── colors.dart      # App color definitions
├── dialog/
│   └── confirm_dialog.dart  # Confirmation dialogs
└── utils/
    └── routes.dart          # App routing
```

## Dependencies

### Core Dependencies
- `flutter`: UI framework
- `firebase_core`: Firebase core functionality
- `cloud_firestore`: Firestore database
- `firebase_database`: Real-time database
- `flutter_svg`: SVG image support
- `http`: HTTP client
- `intl`: Internationalization
- `flutter_dotenv`: Environment variables

### Development Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Code linting
- `flutter_launcher_icons`: App icon generation
- 
<img src="https://github.com/user-attachments/assets/24a2cd6b-9506-4f72-9edf-16c2c2c2ab6a" width="300" />
<img src="https://github.com/user-attachments/assets/39eff629-9dd5-43aa-bacb-673c68c50cd2" width="300" />
<img src="https://github.com/user-attachments/assets/8e668dfd-9fcb-445b-b3d2-9c07ea6036fd" width="300" />

