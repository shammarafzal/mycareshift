import 'package:flutter/material.dart';

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Card(
              color: Colors.white,
              elevation: 5,
              child: NotificationScreen(
                img: 'https://googleflutter.com/sample_image.jpg',
                title: "New Notifications",
                body: 'You received a notification',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class NotificationScreen extends StatefulWidget {
  final String img;
  final String title;
  final String body;
  NotificationScreen({
    required this.img,
    required this.title,
    required this.body,
  });

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(widget.img), fit: BoxFit.fill),
        ),
      ),
      title: Text(
        widget.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        widget.body,
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
