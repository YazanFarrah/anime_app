class ApiPaths {
  static const String baseUrl = 'animebe-production.up.railway.app';
  static const String _usersEndpoint = 'anime-fan';
  static const String _postsEndpoint = 'posts';
  static const String _commentEndpoint = 'comments';
  // static const String _chatsEndpoint = 'chats';
  static const String _logInEndpoint = 'auth/login';
  static const String _signUpEndpoint = 'auth/sign-up';

  static String createPosts = '/api/$_postsEndpoint';
  static String logIn = '/api/$_logInEndpoint';
  static String signUp = '/api/$_signUpEndpoint';
  static String getUsers = '/api/$_usersEndpoint';
  static String getPosts = '/api/$_postsEndpoint';
  static String deletePosts = '/api/$_postsEndpoint';
  static String editPosts = '/api/$_postsEndpoint';
  static String getComments = '/api/$_commentEndpoint';
}
