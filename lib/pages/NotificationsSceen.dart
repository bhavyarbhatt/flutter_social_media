import 'package:flutter/material.dart';
import 'package:flutter_social_media/common/Widgets/drawer.dart';

class NotificationsScreen extends StatelessWidget {
  final List<NotificationItem> notifications = List.generate(
    20,
        (index) => NotificationItem(
      title: 'New follower',
      description: 'User $index started following you.',
      timestamp: DateTime.now().subtract(Duration(minutes: index * 3)),
      icon: Icons.person_add,
      imageUrl: 'https://picsum.photos/200/200?random=$index', // Placeholder image
    ),
  );

  @override
  Widget build(BuildContext context) {

    void _logout() {
      Navigator.pushReplacementNamed(context, '/login'); // Example navigation
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      drawer: CustomDrawer(onLogout: _logout), // Use the custom drawer here

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: notifications.length,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            return NotificationCard(notification: notifications[index]);
          },
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                notification.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    notification.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _formatTimestamp(notification.timestamp),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}

class NotificationItem {
  final String title;
  final String description;
  final DateTime timestamp;
  final IconData icon;
  final String imageUrl;

  NotificationItem({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.imageUrl,
  });
}