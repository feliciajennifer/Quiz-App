List<Map<String, dynamic>> allQuizzes = [
  {
    'id': '1',
    'title': 'Flutter Fundamentals',
    'category': 'Technology',
    'image': 'assets/images/flutter_quiz.jpg',
    'questionCount': 2,
    'description': 'Test your knowledge about Flutter framework, Dart programming language, and mobile app development concepts. Perfect for beginners and intermediate developers.',
    'difficulty': 'Beginner',
    'questions': [
      {
        'question': 'What is Flutter primarily used for?',
        'answers': [
          'Building mobile applications',
          'Web development only',
          'Database management',
          'Game development'
        ],
        'correctAnswer': 0,
      },
      {
        'question': 'Which programming language does Flutter use?',
        'answers': [
          'Dart',
          'Java',
          'Swift',
          'Kotlin'
        ],
        'correctAnswer': 0,
      },
    ],
  },
  {
    'id': '2',
    'title': 'Computer Science Fundamentals',
    'category': 'Technology',
    'image': 'assets/images/cs_quiz.jpg',
    'questionCount': 1,
    'description': 'Test your knowledge of computer science concepts and programming principles.',
    'difficulty': 'Intermediate',
    'questions': [
      {
        'question': 'What does CPU stand for?',
        'answers': [
          'Central Processing Unit',
          'Computer Processing Unit',
          'Central Program Unit',
          'Computer Program Unit'
        ],
        'correctAnswer': 0,
      },
    ],
  },
  {
    'id': '3',
    'title': 'Solar System Explorer',
    'category': 'Astronomy',
    'image': 'assets/images/space_quiz.jpg',
    'questionCount': 1,
    'description': 'Explore the wonders of our solar system and beyond. Learn about planets, stars, and cosmic phenomena.',
    'difficulty': 'Intermediate',
    'questions': [
      {
        'question': 'Which planet is known as the Red Planet?',
        'answers': [
          'Mars',
          'Jupiter',
          'Venus',
          'Saturn'
        ],
        'correctAnswer': 0,
      },
    ],
  },
  {
    'id': '4',
    'title': 'Biology Basics',
    'category': 'Science',
    'image': 'assets/images/biology_quiz.jpg',
    'questionCount': 1,
    'description': 'Explore the fundamentals of biology, from cells to ecosystems.',
    'difficulty': 'Beginner',
    'questions': [
      {
        'question': 'What is the basic unit of life?',
        'answers': [
          'Cell',
          'Atom',
          'Molecule',
          'Organ'
        ],
        'correctAnswer': 0,
      },
    ],
  },
  {
    'id': '5',
    'title': 'Chemistry Elements',
    'category': 'Science',
    'image': 'assets/images/chemistry_quiz.jpg',
    'questionCount': 1,
    'description': 'Test your knowledge of chemical elements and periodic table.',
    'difficulty': 'Intermediate',
    'questions': [
      {
        'question': 'What is the chemical symbol for Gold?',
        'answers': [
          'Au',
          'Ag',
          'Go',
          'Gd'
        ],
        'correctAnswer': 0,
      },
    ],
  },
  {
    'id': '6',
    'title': 'World Geography',
    'category': 'Geography',
    'image': 'assets/images/geography_quiz.jpg',
    'questionCount': 1,
    'description': 'Test your knowledge of world geography, countries, capitals, landmarks, and cultural facts.',
    'difficulty': 'Intermediate',
    'questions': [
      {
        'question': 'What is the capital of Australia?',
        'answers': [
          'Canberra',
          'Sydney',
          'Melbourne',
          'Perth'
        ],
        'correctAnswer': 0,
      },
    ],
  },
  {
    'id': '7',
    'title': 'Basic Mathematics',
    'category': 'Mathematics',
    'image': 'assets/images/math_quiz.jpg',
    'questionCount': 1,
    'description': 'A fun quiz covering basic arithmetic, algebra, and geometry concepts. Perfect for refreshing your math skills.',
    'difficulty': 'Beginner',
    'questions': [
      {
        'question': 'What is 15 + 27?',
        'answers': [
          '42',
          '32',
          '52',
          '37'
        ],
        'correctAnswer': 0,
      },
    ],
  },
  {
    'id': '8',
    'title': 'Ancient History',
    'category': 'History',
    'image': 'assets/images/history_quiz.jpg',
    'questionCount': 1,
    'description': 'Journey through ancient civilizations and historical events that shaped our world.',
    'difficulty': 'Intermediate',
    'questions': [
      {
        'question': 'Which civilization built the pyramids?',
        'answers': [
          'Ancient Egyptians',
          'Ancient Greeks',
          'Romans',
          'Mayans'
        ],
        'correctAnswer': 0,
      },
    ],
  },
];

// Group quizzes by category
Map<String, List<Map<String, dynamic>>> getQuizzesByCategory() {
  Map<String, List<Map<String, dynamic>>> quizzesByCategory = {};
  
  for (var quiz in allQuizzes) {
    String category = quiz['category'];
    if (!quizzesByCategory.containsKey(category)) {
      quizzesByCategory[category] = [];
    }
    quizzesByCategory[category]!.add(quiz);
  }
  
  return quizzesByCategory;
}

List<Map<String, dynamic>> popularQuizzes = [
  allQuizzes[0], // Flutter Fundamentals
  allQuizzes[2], // Solar System Explorer
  allQuizzes[5], // World Geography Challenge
  allQuizzes[6], // Basic Mathematics Quiz
  allQuizzes[7], // Ancient History Adventure
];