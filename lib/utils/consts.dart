import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseConst{
  static const String users = 'users';
  static const String threads = 'threads';
  static const String comments = 'comments';
  static const String replies = 'replies';
}




String formatTimestamp(Timestamp timestamp) {
  final now = DateTime.now();
  final postTime = timestamp.toDate(); // The timestamp should be in seconds

  final difference = now.difference(postTime);

  if (difference.inDays > 0) {
    if (difference.inDays >= 1 && difference.inDays < 2) {
      return 'Yesterday';
    } else {
      return '${postTime.day}/${postTime.month}/${postTime.year}';
    }
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m';
  } else if (difference.inSeconds > 0) {
    return '${difference.inSeconds}s';
  } else {
    return 'Just now';
  }
}

// class PageConst{
//   static const String settingPage = 'setting-page';  
// }