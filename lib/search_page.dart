import 'package:flutter/material.dart';
import 'package:googlebooks/info_page.dart';
import 'results_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  String _orderBy = 'newest';

  double get screenWidth {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          'Google Books',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'About',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const InfoPage(title: 'About',);
                  },
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(30, 35, 40, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sort Results by:',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(
              width: 200,
              child: RadioListTile<String>(
                title: const Text(
                  'Newest',
                  style: TextStyle(color: Colors.white70),
                ),
                value: 'newest',
                groupValue: _orderBy,
                onChanged: (String? value) {
                  setState(() {
                    _orderBy = value!;
                  });
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: RadioListTile<String>(
                title: const Text(
                  'Relevance',
                  style: TextStyle(color: Colors.white70),
                ),
                value: 'relevance',
                groupValue: _orderBy,
                onChanged: (String? value) {
                  setState(() {
                    _orderBy = value!;
                  });
                },
                activeColor: Colors.blueAccent,
              ),
            ),
            SizedBox(
                width: screenWidth * .7,
                child: TextField(
                    controller: _searchController,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 24.0,
                    ),
                    autofocus: true,
                    maxLength: 50,
                    enableSuggestions: true,
                    onSubmitted: (value) =>
                        _sendToResults(value, screenWidth))),
            ElevatedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text('Search'),
                onPressed: () =>
                    _sendToResults(_searchController.text, screenWidth)),
          ],
        ),
      ),
    );
  }

  _sendToResults(String text, double screenWidth) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ResultsPage(text, _orderBy, screenWidth);
        },
      ),
    );
  }
}
