import 'package:flutter/material.dart';
import 'book.dart';
import 'package:url_launcher/url_launcher.dart';

class BookCard extends Card {
  BookCard(Book book, double screenWidth, {super.key})
      : super(
            elevation: 15,
            margin: const EdgeInsets.all(10),
            child: getContent(book, screenWidth));
}

Future<void> launchInBrowser(String url) async {
  if (!await launchUrl(
    Uri.parse(url),
  )) {
    throw 'Could not launch $url';
  }
}

Widget getContent(Book book, double screenWidth) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    book.authors,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    book.publisher,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    book.publishedDate,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${book.pageCount} pages',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    book.isbns,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                (book.thumbnail == 'Thumbnail not found')
                    ? Text(
                        book.thumbnail,
                      )
                    : Image(
                        width: screenWidth * .2,
                        height: screenWidth * .2,
                        alignment: Alignment.center,
                        image: NetworkImage(
                          book.thumbnail,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Text(
                          book.price != 'Unknown Price' ? book.price : '',
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () => launchInBrowser(
                          book.buyLink,
                        ),
                      ),
                      InkWell(
                        child: const Text(
                          'Steal',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () => launchInBrowser(
                          'https://thepiratebay.org/search.php?q=${book.title}&all=on&search=Pirate+Search&page=0&orderby=',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SelectableText(
                book.description,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
