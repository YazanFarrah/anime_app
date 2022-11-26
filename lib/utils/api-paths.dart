class ApiPaths {
  static const String baseUrl = 'animesma.herokuapp.com';
  static const String _usersEndpoint = 'users';
  static const String _postsEndpoint = 'posts';
  static const String _commentEndpoint = 'comments';
  static const String _chatsEndpoint = 'chats';
  static const String _logInEndpoint = 'auth/login';
  static const String _signUpEndpoint = 'auth/sign-up';

  static String createPosts = '/api/$_postsEndpoint';
  static String logIn = '/api/$_logInEndpoint';
  static String signUp = '/api/$_signUpEndpoint';
  static String fetchUsers = '/api/$_signUpEndpoint';
}
