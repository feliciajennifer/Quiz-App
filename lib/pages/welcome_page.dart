import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import 'main_navigation.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _startQuiz() {
    if (_formKey.currentState!.validate()) {
      final userModel = Provider.of<UserModel>(context, listen: false);
      userModel.name = _nameController.text.trim();
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView( 
          padding: EdgeInsets.all(AppDimensions.getLargePadding(context)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo dan Welcome Message
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/Thinkzone.png', 
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback jika image tidak ditemukan
                        return Icon(
                          Icons.lightbulb_outline,
                          size: 50,
                          color: AppColors.primary,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: AppDimensions.getLargePadding(context)),
                
                Text(
                  'Welcome to Thinkzone!',
                  style: AppTextStyles.playfulTitle(context).copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: AppDimensions.getSmallPadding(context)),
                
                Text(
                  'Expand your knowledge with fun quizzes',
                  style: TextStyle(
                    fontSize: AppDimensions.getBodyFontSize(context) - 2,
                    color: Colors.white.withOpacity(0.8),
                    fontFamily: 'Nunito',
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: AppDimensions.getLargePadding(context)),

                // Name Input Form
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.getCardRadius(context)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            'Let\'s get started!',
                            style: TextStyle(
                              fontSize: AppDimensions.getSubtitleFontSize(context),
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          
                          SizedBox(height: AppDimensions.getMediumPadding(context)),
                          
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Enter your name',
                              hintText: 'Your awesome name...',
                              prefixIcon: Image.asset(
                                'assets/images/user-profile.png',
                                width: 10,
                                height: 10,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback jika image tidak ditemukan
                                  return Icon(
                                    Icons.person_outline,
                                    color: Colors.grey[600],
                                  );
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppDimensions.getButtonRadius(context)),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your name';
                              }
                              if (value.trim().length < 2) {
                                return 'Name must be at least 2 characters';
                              }
                              return null;
                            },
                          ),
                          
                          SizedBox(height: AppDimensions.getLargePadding(context)),
                          
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _startQuiz,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppDimensions.getButtonRadius(context)),
                                ),
                                elevation: 4,
                              ),
                              child: Text(
                                'Start Learning',
                                style: TextStyle(
                                  fontSize: AppDimensions.getBodyFontSize(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppDimensions.getMediumPadding(context)),

                // Fun Facts
                Container(
                  padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.getCardRadius(context)),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/idea.png',
                        width: 20,
                        height: 20,
                        color: Colors.white.withOpacity(0.8),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback jika image tidak ditemukan
                          return Icon(
                            Icons.emoji_events,
                            color: Colors.white.withOpacity(0.8),
                            size: 20,
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.getSmallPadding(context)),
                      Expanded(
                        child: Text(
                          'Complete quizzes to earn achievements!',
                          style: TextStyle(
                            fontSize: AppDimensions.getBodyFontSize(context) - 4,
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}