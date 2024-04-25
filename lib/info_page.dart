import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(30, 35, 40, 1.0),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/programmer.jpg',
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Linkify(
              text: 'Another fine mess by http://Footeware.ca',
              style: const TextStyle(color: Colors.white70),
              onOpen: _openUrl,
            ),
          ),
        ),
      ]),
    );
  }

  void _openUrl(link) async {
    if (await canLaunchUrl(Uri.parse(link.url))) {
      await launchUrl(
        Uri.parse(link.url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $link';
    }
  }
}
