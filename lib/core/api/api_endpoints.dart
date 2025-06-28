class ApiEndpoints {
  //Signup
  static const String signupAPI = 'user/create';
  //User profile
  static const String getProfileAPI = 'user/';
  static const String profileUpdateAPI = 'user/update/';
  //Home Page
  static const String getPostsAPI = 'posts';
  static const String getCommentsAPI = 'comments/posts/';
  static const String createReactionsAPI = 'reactions';
  static const String deleteReactionsAPI = 'reactions/';
  static const String getReactionsAPI = 'reactions?postId=';
}
