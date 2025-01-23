# Movie Application 🎬

A Flutter-based movie application that allows users to browse, search, and save their favorite movies. This app fetches movie data from a backend API, displays it in a user-friendly interface, and provides features like saving movies to a watchlist, viewing movie details, and exploring movies by categories. 

---

## Technologies Used 🛠️

### **Frontend**
- **Flutter**: The app is built using Flutter, a cross-platform framework for building natively compiled applications.
- **Dart**: The programming language used for Flutter development.

### **Backend**
- **Node.js**: The backend server is built using Node.js, providing RESTful APIs for fetching and managing movie data.
- **Express.js**: A Node.js framework used to simplify API development and handle HTTP requests.

### **Database**
- **MongoDB**: A NoSQL database used to store movie data, user watchlists, and other application data.

### **Features**
- **Backend API**: Custom APIs built with Node.js and Express.js to fetch movie data (e.g., `fetchMovies`, `fetchActionMovies`, etc.) and manage user interactions (e.g., saving/removing movies from the watchlist).
- **State Management**: Uses Flutter's built-in `setState` for managing local state and triggering UI updates.
- **Widgets**: Custom reusable widgets like `MovieComponent`, `ListMovieComponent`, `ImageSlider`, and `CategoriesButton`.
- **Navigation**: Uses Flutter's `Navigator` for seamless screen transitions.
- **Theming**: Custom app theme with dark mode aesthetics.

---

## Future Improvements 🔮

1. Integrate a real movie API (e.g., TMDB) for fetching movie data.
2. Add user authentication for personalized watchlists.
3. Implement movie downloads functionality.
4. Enhance the user profile section with customization options.
5. Add animations and transitions for a more engaging user experience.

---

### **Get Started**

1. Clone the repository:
   ```bash
   git clone <repository-url>

