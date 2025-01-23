const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Middleware to conditionally parse JSON for POST, PUT, and PATCH requests
app.use((req, res, next) => {
  if (['POST', 'PUT', 'PATCH'].includes(req.method)) {
    return express.json()(req, res, next);
  }
  next();
});

mongoose
  .connect('mongodb://localhost:27017/Movies')
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('Could not connect to MongoDB', err));

// Schemas ================================
const movieSchema = new mongoose.Schema({
  imageURL: String,
  MovieName: String,
  movietype: String,
  moviedate: Date,
  movietime: String,
  ListOfEpesoide: [String],
  AboutMovie: String,
});

const Movie = mongoose.model('movies', movieSchema);

const UserSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  ListOfMoviesId: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'movies', 
  }],
});

const User = mongoose.model('Users', UserSchema);

module.exports = User;

//================================================================

// Utility function to exclude user's saved movies
async function excludeUserSavedMovies(userId) {
  const user = await User.findById(userId).select('ListOfMoviesId');
  return user ? user.ListOfMoviesId : [];
}

// Routes for movies 

// Get random 20 movies excluding user's saved movies
app.get('/movies/:userId', async (req, res) => {
  try {
    const userId = req.params.userId;
    const excludedMovieIds = await excludeUserSavedMovies(userId);
    const movies = await Movie.aggregate([
      { $match: { _id: { $nin: excludedMovieIds } } },
      { $sample: { size: 20 } },
    ]);
    res.json(movies);
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch movies', error: err.message });
  }
});

// Get movies by category: Action
app.get('/movies/:userId/action', async (req, res) => {
  try {
    const userId = req.params.userId;
    const excludedMovieIds = await excludeUserSavedMovies(userId);
    const movies = await Movie.aggregate([
      { $match: { movietype: "Action", _id: { $nin: excludedMovieIds } } }, 
      { $sample: { size: 15 } }, 
    ]);
    res.json(movies);
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch Action movies', error: err.message });
  }
});

// Get movies by category: Romantic
app.get('/movies/:userId/romantic', async (req, res) => {
  try {
    const userId = req.params.userId;
    const excludedMovieIds = await excludeUserSavedMovies(userId);
    const movies = await Movie.aggregate([
      { $match: { movietype: "Romantic", _id: { $nin: excludedMovieIds } } }, 
      { $sample: { size: 15 } }, 
    ]);
    res.json(movies);
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch Romantic movies', error: err.message });
  }
});

// Get movies by category: Horror
app.get('/movies/:userId/horror', async (req, res) => {
  try {
    const userId = req.params.userId;
    const excludedMovieIds = await excludeUserSavedMovies(userId);
    const movies = await Movie.aggregate([
      { $match: { movietype: "Horror", _id: { $nin: excludedMovieIds } } }, 
      { $sample: { size: 15 } }, 
    ]);
    res.json(movies);
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch Horror movies', error: err.message });
  }
});

// Get movies by category: Comedy
app.get('/movies/:userId/comedy', async (req, res) => {
  try {
    const userId = req.params.userId;
    const excludedMovieIds = await excludeUserSavedMovies(userId);
    const movies = await Movie.aggregate([
      { $match: { movietype: "Comedy", _id: { $nin: excludedMovieIds } } }, 
      { $sample: { size: 15 } }, 
    ]);
    res.json(movies);
  } catch (err) {
    res.status(500).json({ message: 'Failed to fetch Comedy movies', error: err.message });
  }
});


// Search for movies by name, excluding user's saved movies
app.get('/search-movie/:userId', async (req, res) => {
  try {
    const { userId } = req.params; // Get userId from URL parameters
    const { MovieName } = req.query; // Get MovieName from query parameters

    if (!MovieName) {
      return res.status(400).json({ message: 'MovieName is required' });
    }

    // Exclude user's saved movies
    const excludedMovieIds = await excludeUserSavedMovies(userId);

    // Search for movies by name (case-insensitive) and exclude saved movies
    const movies = await Movie.aggregate([
      {
        $match: {
          MovieName: { $regex: MovieName, $options: 'i' }, // Case-insensitive search
          _id: { $nin: excludedMovieIds }, // Exclude user's saved movies
        },
      },
      { $sample: { size: 20 } }, // Limit results to 20 random movies
    ]);

    if (movies.length === 0) {
      return res.status(404).json({ message: 'No movies found with that name' });
    }

    // Return the list of movies
    res.status(200).json({ movies });
  } catch (err) {
    console.error('Error searching for movies:', err);
    res.status(500).json({ message: 'Failed to search for movies', error: err.message });
  }
});

//======================================================
// For Users

// Get all users
app.get('/users', async (req, res) => {
  try {
    // Fetch all users, excluding the password field
    const users = await User.find({}, { password: 0 }); // Excludes the password field
    res.json(users);
  } catch (err) {
    console.error('Error fetching users:', err);
    res.status(500).json({ message: 'Failed to fetch users', error: err.message });
  }
});

// Get saved movies for a user
app.get('/users/:userId/saved-movies', async (req, res) => {
  try {
    const userId = req.params.userId;

    const user = await User.findById(userId).select('ListOfMoviesId');

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    if (user.ListOfMoviesId.length === 0) {
      return res.json({ savedMovies: [] });
    }

    const savedMovies = await Movie.find({
      _id: { $in: user.ListOfMoviesId }, 
    });

    res.json({ savedMovies });
  } catch (err) {
    console.error('Error fetching saved movies:', err);
    res.status(500).json({ message: 'Failed to fetch saved movies', error: err.message });
  }
});

// Save a movie for a user
app.post('/users/:userId/save-movie', async (req, res) => {
  try {

    const { userId } = req.params; 
    const { movieId } = req.body;

    // Validate the user ID
    if (!mongoose.Types.ObjectId.isValid(userId)) {
      return res.status(400).json({ message: 'Invalid User ID' });
    }
    
    const user = await User.findByIdAndUpdate(
      userId, 
      { $addToSet: { ListOfMoviesId: movieId } },
      { new: true } 
    );

    
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Respond with the updated user
    res.json(user);
  } catch (err) {
    console.error('Error saving movie:', err);
    res.status(500).json({ message: 'Failed to save movie', error: err.message });
  }
});

// Remove a movie from a user's saved list
app.delete('/users/:userId/remove-movie', async (req, res) => {
  try {
    const userId = req.params.userId
    const { movieId } = req.body;

    if (!movieId) {
      return res.status(400).json({ message: 'Movie ID is required' });
    }

    const user = await User.findByIdAndUpdate(
      userId,
      { $pull: { ListOfMoviesId: movieId } }, 
      { new: true }
    );

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json(user);
  } catch (err) {
    console.error('Error removing movie:', err);
    res.status(500).json({ message: 'Failed to remove movie', error: err.message });
  }
});

//=========================================================
app.post('/login', async (req, res) => {
  try {
    const { username, password } = req.body;

    // Check if username and password are provided
    if (!username || !password) {
      return res.status(400).json({ message: 'Username and password are required' });
    }

    // Find the user by username
    const user = await User.findOne({ username });

    // If user doesn't exist
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Compare the provided password with the password in the database
    if (password !== user.password) {
      return res.status(401).json({ message: 'Invalid password' });
    }

    // If login is successful, return the user (excluding the password)
    const userResponse = { ...user.toObject(), password: undefined };
    res.json({ message: 'Login successful', user: userResponse });
  } catch (err) {
    console.error('Error during login:', err);
    res.status(500).json({ message: 'Failed to login', error: err.message });
  }
});

app.post('/signup', async (req, res) => {
  try {
    const { username, password } = req.body;

    if (!username || !password) {
      return res.status(400).json({ message: 'Username and password are required' });
    }

    // Check if the username already exists
    const existingUser = await User.findOne({ username });
    if (existingUser) {
      return res.status(409).json({ message: 'Username already exists' });
    }

    // Create  new user
    const newUser = new User({
      username,
      password,
      ListOfMoviesId: [], 
    });

    await newUser.save();

    const userResponse = { ...newUser.toObject(), password: undefined };
    res.status(201).json({ message: 'User created successfully', user: userResponse });
  } catch (err) {
    console.error('Error during signup:', err);
    res.status(500).json({ message: 'Failed to create user', error: err.message });
  }
});

// Start the server
const port = 3000;
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
