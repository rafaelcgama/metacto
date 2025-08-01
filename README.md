# Feature Voting System

A modern, full-stack feature voting application that allows users to propose, view, and vote on features. Built with FastAPI for the backend and SwiftUI for iOS frontend.

## ✨ Features

- 👤 **User Management**: Create and manage users with name and email
- 💡 **Feature Proposals**: Submit new feature requests with titles and descriptions
- 🗳️ **Smart Voting**: Upvote features with duplicate vote prevention
- 🔄 **Live Updates**: Real-time synchronization between frontend and backend

## 🛠️ Tech Stack

**Backend:**
- **FastAPI** - Modern, fast web framework for building APIs
- **SQLAlchemy** - SQL toolkit and Object-Relational Mapping
- **SQLite** - Lightweight, file-based database
- **Pydantic** - Data validation using Python type annotations

**Frontend:**
- **SwiftUI** - Apple's declarative UI framework
- **URLSession** - Native HTTP networking
- **Xcode** - Integrated development environment

## 📂 Project Structure

```
feature-voting-system/
│
├── backend/
│   ├── app/
│   │   ├── routes/
│   │   │   ├── 🐍 features.py      # Feature-related endpoints
│   │   │   ├── 🐍 users.py         # User management endpoints
│   │   │   └── 🐍 votes.py         # Voting system endpoints
│   │   ├── 🐍 __init__.py
│   │   ├── 🐍 crud.py              # Database operations
│   │   ├── 🐍 database.py          # Database configuration
│   │   ├── 🐍 main.py              # FastAPI application entry point
│   │   ├── 🐍 models.py            # SQLAlchemy database models
│   │   ├── 🐍 schemas.py           # Pydantic request/response schemas
│   │   └── tests/
│   │       ├── 🐍 test_features.py # Feature endpoint tests
│   │       ├── 🐍 test_users.py    # User endpoint tests
│   │       └── 🐍 test_votes.py    # Vote endpoint tests
│   └── 🐍 __init__.py
├── frontend/
│   ├── FeatureVotingApp/
│   │   ├── FeatureVotingAppTests/
│   │   │   └── 🍎 FeatureVotingAppTests.swift
│   │   └── Views/
│   │       ├── 🍎 AddFeatureView.swift     # Feature creation UI
│   │       ├── 🍎 CreateUserView.swift     # User creation UI
│   │       └── 🍎 FeatureListView.swift    # Main feature list UI
│   ├── 🍎 APIService.swift                 # HTTP client service
│   ├── 🍎 ContentView.swift                # Root view controller
│   ├── ⚙️ FeatureVotingApp.xcodeproj       # Xcode project file
│   ├── 🍎 FeatureVotingAppApp.swift        # App entry point
│   └── 🍎 Models.swift                     # Swift data models
├── 🚫 .gitignore                           # Git ignore rules
├── 💬 prompts.txt                          # AI development prompts
├── 📖 README.md                            # Project documentation
└── 📦 requirements.txt                     # Python dependencies
```

## 🚀 Quick Start

### Prerequisites

**For Backend:**
- Python 3.8+ 
- pip (Python package installer)

**For Frontend:**
- macOS (required for iOS development)
- Xcode 14+ (download from [App Store](https://apps.apple.com/app/xcode/id497799835))

### Backend Setup

1. **Navigate to backend directory**
   ```bash
   cd backend
   ```

2. **Create virtual environment (recommended)**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Start the development server**
   ```bash
   uvicorn app.main:app --reload
   ```

5. **Verify installation**
   - API Server: http://127.0.0.1:8000
   - Interactive API Docs: http://127.0.0.1:8000/docs
   - Alternative Docs: http://127.0.0.1:8000/redoc

> 💡 The SQLite database (`feature_voting.db`) will be created automatically on first run.

### Frontend Setup

1. **Open Xcode project**
   - Launch Xcode
   - File → Open → Navigate to `frontend/FeatureVotingApp/`
   - Select `FeatureVotingApp.xcodeproj`

2. **Create missing Swift files**
   
   The following files need to be created manually in Xcode:
   
   **Right-click on FeatureVotingApp folder → New File → Swift File**
   
   Create each file and paste the corresponding code:
   - `APIService.swift` - HTTP client for backend communication
   - `Models.swift` - Swift data structures
   - `FeatureListView.swift` - Main feature list interface
   - `AddFeatureView.swift` - Feature creation form
   - `CreateUserView.swift` - User registration form

   > ⚠️ **Important**: Ensure "Target Membership" for FeatureVotingApp is checked

3. **Configure build settings**
   - Scheme: **FeatureVotingApp**
   - Destination: **iPhone Simulator** (e.g., iPhone 15 Pro)

4. **Run the application**
   - Ensure backend is running at http://127.0.0.1:8000
   - Press the **Run** button ▶️ in Xcode
   - The iOS Simulator will launch automatically

## 📱 Using the App

1. **Create a User**
   - Tap "Add User" button
   - Enter name and email address
   - User will appear in the picker

2. **Select Active User**
   - Use the picker at the top to choose your user
   - This user will be used for voting

3. **Add Features**
   - Tap "Add Feature" button
   - Enter feature title and description
   - Feature appears in the main list

4. **Vote on Features**
   - Tap the 👍 button next to any feature
   - Features are automatically sorted by vote count
   - Duplicate votes are prevented with user alerts

## 🔌 API Reference

| Method | Endpoint | Description | Request Body |
|--------|----------|-------------|--------------|
| `POST` | `/users/` | Create a new user | `{"name": "string", "email": "string"}` |
| `GET` | `/users/` | Retrieve all users | - |
| `POST` | `/features/` | Create a new feature | `{"title": "string", "description": "string"}` |
| `GET` | `/features/` | Retrieve all features (sorted by votes) | - |
| `POST` | `/votes/` | Vote for a feature | `{"user_id": int, "feature_id": int}` |


## 🧪 Testing

### Backend Tests
```bash
cd backend
python -m pytest tests/ -v
```

### Frontend Tests
- Open project in Xcode
- Press `Cmd + U` to run unit tests
- Tests will run in the iOS Simulator

## 🔧 Troubleshooting

### Common Issues

**"Hello World" still appears in iOS app**
- ✅ Verify `FeatureListView.swift` was created correctly
- ✅ Check that `FeatureVotingAppApp.swift` uses `FeatureListView()` as the main view

**User picker is empty**
- ✅ Create at least one user using "Add User" button
- ✅ Ensure backend API is running and accessible

**Votes don't register or duplicates are allowed**
- ✅ Confirm backend server is running on port 8000
- ✅ Check console logs in Xcode for API errors
- ✅ Verify duplicate vote prevention is implemented in backend

**Network connection errors**
- ✅ Ensure backend is running: `uvicorn app.main:app --reload`
- ✅ Check API endpoint in `APIService.swift` matches backend URL
- ✅ Verify iOS Simulator can access localhost (this should work by default)

## 🏗️ Development Notes

- **No Authentication**: This is an MVP focused on core functionality
- **Default User ID**: Demo uses user ID 1 for simplicity
- **Development Transparency**: All AI prompts used during development are documented in `prompts.txt`
- **Database**: SQLite database is created automatically and persists between runs

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Built with assistance from AI development tools
- Inspired by modern feature request management systems
- Thanks to the FastAPI and SwiftUI communities for excellent documentation