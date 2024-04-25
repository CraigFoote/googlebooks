import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'book.dart';
import 'book_card.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage(
      this._searchString, this._orderBy, this._screenWidth,
      {super.key});
  final String _searchString;
  final String _orderBy;
  final double _screenWidth;

  @override
  State<StatefulWidget> createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage> {
  late List<Book> _books;
  late bool _haveBooks;
  late num _numResults;

  @override
  void initState() {
    super.initState();
    _haveBooks = false;
    _numResults = 0;
    _books = [];
    _getSearchResults();
  }

  void _getSearchResults() async {
    Uri url = Uri(
        scheme: 'https',
        host: 'www.googleapis.com',
        path: 'books/v1/volumes',
        query:
            'q=${widget._searchString}&maxResults=40&orderBy=${widget._orderBy}&key=AIzaSyAF1teX6POMtILJGAtLuEuwBRK2wYG1vXU');
    final client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    IOClient http = IOClient(client);
    await http.get(url).then(
      (response) async {
        if (response.statusCode == 200) {
          Map<String, dynamic> result = json.decode(response.body);
          var items = result['items'];
          for (var i = 0; i < items.length; i++) {
            var item = items[i];
            Book book = Book(item);
            _books.add(book);
          }
          _numResults = result['totalItems'];
          setState(() => _haveBooks = true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          '$_numResults Results for ${widget._searchString}',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
      body: !_haveBooks
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                return BookCard(_books[index], widget._screenWidth);
              },
            ),
    );
  }
}
