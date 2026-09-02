/// Extension to convert DateTime into a relative time format with short months
extension RelativeTimeExtension on DateTime? {
  String toRelativeTime({String fallback = 'N/A'}) {
    // Null handle korar fallback value
    if (this == null) return fallback;
    
    final now = DateTime.now();
    final difference = now.difference(this!);

    if (difference.isNegative || difference.inMinutes < 1) {
      return 'Just now';
    } 
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } 
    
    if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } 
    
    if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } 
    
    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w';
    } 
    
    // Over a month: Format to "ShortMonth Day" (e.g., Jun 26)
    const shortMonths = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    return '${shortMonths[this!.month]} ${this!.day}';
  }
}