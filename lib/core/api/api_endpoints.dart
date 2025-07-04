class ApiEndpoints {
  //Signup
  static const String signupAPI = 'user/create';
  //User profile
  static const String getProfileAPI = 'user/';
  static const String profileUpdateAPI = 'user/update/';
  //Home Page
  static const String createPostAPI = 'posts/create-post/large-mediav2';
  static const String updatePostAPI = 'posts/update-post/large-mediav2/';
  static const String getPostsAPI = 'posts';
  static const String publicPostAPI = 'home/posts?userId=';
  static const String getCommentsAPI = 'comments/posts/';
  static const String createReactionsAPI = 'reactions';
  static const String deleteReactionsAPI = 'reactions/';
  static const String getReactionsAPI = 'reactions?postId=';
  static const String getPostImageDownloadAPI = 'posts/media-url/';
  static const String getFollowersList = 'user/followers';
  static const String getFollowingList = 'user/following';
  static const String getFollowUserList = 'user/follow';
  static const String getUnfollowUseList = 'user/unfollow';
}
