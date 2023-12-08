<img src="https://private-user-images.githubusercontent.com/34348253/289099961-9fdaccdf-417d-475f-b5de-53630208c0f5.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDIwNDY5ODEsIm5iZiI6MTcwMjA0NjY4MSwicGF0aCI6Ii8zNDM0ODI1My8yODkwOTk5NjEtOWZkYWNjZGYtNDE3ZC00NzVmLWI1ZGUtNTM2MzAyMDhjMGY1LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMDglMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjA4VDE0NDQ0MVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWY4MTNjM2NkNDFlYThmMWY1MGJlYTRhYzYyMDc3ZDVkZTYyNjU3MjZkN2NiZGQ5MzI1MTkzZDAzMTExOTMxZDUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.LfNpdBnPy2d6XQPt6bmvBdJyFiRppawdo0rvUT2ypRI" alt="Image 1" width="200" height="350">



<img src="https://github.com/CvamKr/todo-bloc-application/raw/master/assets/34348253/d201748b-028a-4207-a263-3ccb989bb5ae.png" alt="Image 2" width="200" height="150">

<img src="https://github.com/CvamKr/todo-bloc-application/raw/master/assets/34348253/8a3a66be-4b54-41ac-9e9c-f01cf5873983.png" alt="Image 3" width="200" height="150">

<img src="https://github.com/CvamKr/todo-bloc-application/raw/master/assets/34348253/2b17549f-cdd2-4a95-9d76-c8cef3acf13b.png" alt="Image 4" width="200" height="150">

<img src="https://github.com/CvamKr/todo-bloc-application/raw/master/assets/34348253/459b0c4e-7ef8-4ea4-97d4-f2f7d42c0bca.png" alt="Image 5" width="200" height="150">


# Setup and Run Instructions

1. **Clone the Repository:**
    ```bash
    git clone <repository_url>
    ```

2. **Navigate to the Project Directory:**
    ```bash
    cd todo_app_flutter_bloc
    ```

3. **Install Dependencies:**
    ```bash
    flutter pub get
    ```

4. **Run the App:**
    ```bash
    flutter run
    ```


# Implementation and Architecture

## Overview
This Todo app is built using Flutter and employs the BLoC (Business Logic Component) pattern. The application allows users to add, remove, edit, filter, and mark tasks as complete or incomplete.

## Architecture
The app follows a structured architecture that separates business logic from UI components. Key components include:
- **UI Layer:** Responsible for displaying the app's interface and interacting with users.
- **BLoC Layer:** Manages the app's business logic, data flow, and state management.
- **Data Layer:** Handles data persistence, retrieval, and management (using shared preference).

## BLoC Implementation
- **TodoBloc:** Manages the state of the todo items. It handles adding, removing, editing, filtering and marking tasks as complete/incomplete. This bloc communicates with the UI layer by emitting states based on user interactions.

- **TodoRepository:** Abstracts the data layer, providing methods for CRUD operations related to todo items. This repository is injected into the TodoBloc to fetch and manipulate data.
