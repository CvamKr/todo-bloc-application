Implementation and Architecture
Overview
This Todo app is built using Flutter and employs the BLoC (Business Logic Component) pattern. The application allows users to add, remove, and mark tasks as complete or incomplete.

Architecture
The app follows a structured architecture that separates business logic from UI components. Key components include:

UI Layer: Responsible for displaying the app's interface and interacting with users.
BLoC Layer: Manages the app's business logic, data flow, and state management.
Data Layer: Handles data persistence, retrieval, and management (e.g., local storage, database).
BLoC Implementation
TodoBloc: Manages the state of the todo items. It handles adding, removing, updating, and marking tasks as complete/incomplete. This bloc communicates with the UI layer by emitting states based on user interactions.

TodoRepository: Abstracts the data layer, providing methods for CRUD operations related to todo items. This repository is injected into the TodoBloc to fetch and manipulate data.

