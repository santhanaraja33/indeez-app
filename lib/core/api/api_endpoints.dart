class ApiEndpoints {
  //Signup
  static const String signupAPI = 'user/create';
  //User profile
  static const String getProfileAPI = 'user/';
  static const String profileUpdateAPI = 'user/update/';
  //Home Page
  static const String createPostAPIImage = 'posts/create-post/image';
  static const String createPostAPIVideo = 'posts/create-post/video';
  static const String createPostAPIAudio = 'posts/create-post/audio';

  static const String updatePostAPI = 'posts/update-post/large-mediav2/';
  static const String getPostsAPI = 'posts';
  static const String publicPostAPI = 'home/posts?userId=';
  static const String getCommentsAPI = 'comments/posts/';
  static const String createReactionsAPI = 'reactions';
  static const String deleteReactionsAPI = 'reactions/';
  static const String getReactionsAPI = 'reactions?postId=';
  static const String getPostImageDownloadAPI = 'posts/media-url/';
  static const String getFollowersFollowingList = 'user/';
  static const String getFollowUserList = 'user/follow';
  static const String getUnfollowUseList = 'user/unfollow';
  static const String followingUsers = 'user/following';
}
