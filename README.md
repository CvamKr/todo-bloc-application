![](https://github.com/CvamKr/todo-bloc-application/assets/34348253/9fdaccdf-417d-475f-b5de-53630208c0f5)
![](https://github.com/CvamKr/todo-bloc-application/assets/34348253/d201748b-028a-4207-a263-3ccb989bb5ae)
![](https://github.com/CvamKr/todo-bloc-application/assets/34348253/8a3a66be-4b54-41ac-9e9c-f01cf5873983)
![](https://github.com/CvamKr/todo-bloc-application/assets/34348253/2b17549f-cdd2-4a95-9d76-c8cef3acf13b)
![](https://github.com/CvamKr/todo-bloc-application/assets/34348253/459b0c4e-7ef8-4ea4-97d4-f2f7d42c0bca)

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
