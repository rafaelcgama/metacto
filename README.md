## Feature Voting System

A simple feature voting system where users can:
- Create features
- View all features sorted by votes
- Upvote features

This project includes:
- Backend: FastAPI (Python) + SQLAlchemy + SQLite
- Frontend: SwiftUI (iOS, runs in Xcode)
-  Audit: prompts.txt containing all AI prompts used to build the project

⸻

📂 Project Structure
```
feature-voting-system/
│
├── backend/
│   ├── app/
│   │   ├── routes/
│   │   │   ├── 🐍 features.py
│   │   │   ├── 🐍 users.py
│   │   │   └── 🐍 votes.py
│   │   ├── 🐍 __init__.py
│   │   ├── 🐍 crud.py
│   │   ├── 🐍 database.py
│   │   ├── 🐍 main.py
│   │   ├── 🐍 models.py
│   │   ├── 🐍 schemas.py
│   │   ├──tests/
│   │   │   ├── 🐍 test_features.py
│   │   │   |── 🐍 test_users.py
│   │   │   └── 🐍 test_votes.py
│   │   └── 🐍 __init__.py
├── frontend/
│   ├── FeatureVotingApp/
│   │   ├── FeatureVotingAppTests/
│   │   │   └── 🍎 FeatureVotingAppTests.swift
│   │   └── Views/
│   │       ├── 🍎 AddFeatureView.swift
│   │       ├── 🍎 CreateUserView.swift
│   │       └── 🍎 FeatureListView.swift       
│   ├── 🍎 APIService.swift
│   ├── 🍎 ContentView.swift
│   ├── ⚙️ FeatureVotingApp.xcodeproj
│   ├── 🍎 FeatureVotingAppApp.swift
│   └── 🍎 Models.swift
├── 🚫 .gitignore
├── 💬 prompts.txt
├── 📖 README.md
└── 📦 requirements.txt
```


🚀 Backend Setup
1.	Install dependencies

bash
```
cd backend
pip install -r requirements.txt
```

2. Install dependencies

bash
```
uvicorn app.main:app --reload
```

3.	Access API Docs

-	Swagger UI: <http://127.0.0.1:8000/docs>

-	Redoc: <http://127.0.0.1:8000/redoc>

The SQLite DB (feature_voting.db) will be created automatically on first run.

📱 Frontend Setup (iOS)
1.	Requirements
- macOS (latest stable version recommended)
- Xcode (full installation from App Store — Command Line Tools alone will not work)
Download from App Store: https://apps.apple.com/app/xcode/id497799835

2️⃣ Open the Project in Xcode
1. Launch Xcode
2. Go to File → Open…
3. Navigate to: 
```feature-voting-system/frontend/FeatureVotingApp/```
4.	Select FeatureVotingApp.xcodeproj
5.	Click Open

3️⃣ Add the Missing Swift Files

When the project is first opened, only the default ContentView.swift and FeatureVotingAppApp.swift will exist.
We must create the other files manually in Xcode.

Create these files:
1.	In Xcode, right-click on the FeatureVotingApp folder → New File → Swift File
2.	Create each of the following:
- APIService.swift
- Models.swift
- FeatureListView.swift
-	AddFeatureView.swift
-	CreateUserView.swift
3.	For each file:
-	Paste in the provided code from the repository (backend README and code sections)
-	Make sure **Target Membership** for FeatureVotingApp is checked (in the right sidebar)

4️⃣ Configure the Project

At the top of Xcode:
- 	Scheme: FeatureVotingApp
- 	Destination: Select an iPhone simulator (e.g., iPhone 15 Pro)

5️⃣ Run the Backend
Before running the iOS app, ensure the backend API is running locally:
```cd backend
uvicorn app.main:app --reload
```

The API will be available at: http://127.0.0.1:8000

6️⃣ Run the App in Simulator
1.	In Xcode, press Run ▶️
2.	The iOS Simulator will launch and install the app
3.	The app will connect to the backend at http://127.0.0.1:8000

7️⃣ Using the App
- 	Add User: Tap “Add User” to create a new user (name + email)
-  Select User: Use the picker at the top to select the active user
-  Add Feature: Tap “Add Feature” to create a feature
-  Vote: Tap 👍 to vote on a feature (duplicate votes show an alert)

8️⃣ Common Issues
-	Hello World still appears
→ Make sure you created FeatureListView.swift and set FeatureVotingAppApp.swift to use FeatureListView() as the main view
-  Picker is empty
→ Add at least one user via “Add User”
-  Vote duplicates still count
→ Backend must be updated with duplicate vote prevention logic (already provided)

🧩 API Endpoints

```
| Method | Endpoint               | Description           |
|--------|------------------------|-----------------------|
| POST   | /users/                | Create user           |
| GET    | /users/                | List all users        |
| POST   | /features/             | Create feature        |
| GET    | /features/             | List all features     |
| POST   | /votes/                | Vote for a feature    |
```

📝 Notes
-	Default user ID for demo: 1
-	No authentication implemented (MVP focus is on functionality)
-	All prompts used during development are in prompts.txt