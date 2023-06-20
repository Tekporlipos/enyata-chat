class Converter{
 static String formatTimestampToTimeAgo(int timestamp) {
    final currentTime = DateTime.now();
    final convertedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    final difference = currentTime.difference(convertedTime);

    if (difference.inSeconds < 0) {
      return '3 seconds ago';
    }else if (difference.inSeconds > 0 && difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else{
      final months = difference.inDays ~/ 30;
      return '$months months ago';
    }
  }


}