import 'package:cladiaq/commons/widgets/buttom_navigation/cq_buttomn_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:xml/xml.dart'; // Import the xml package
import 'package:url_launcher/url_launcher.dart';

Future<List<RssItem>> fetchRssFeed(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return parseRssFeed(response.body);
  } else {
    throw Exception('Failed to load RSS feed');
  }
}

List<RssItem> parseRssFeed(String responseBody) {
  final document = XmlDocument.parse(responseBody);
  final items = document.findAllElements('item');

  return items.map((element) {
    final title = element.findElements('title').single.text;
    final description = element.findElements('description').single.text;
    final pubDate = element.findElements('pubDate').single.text;
    final link = element.findElements('link').single.text;

    return RssItem(
        title: title, description: description, pubDate: pubDate, link: link);
  }).toList();
}

class RssItem {
  final String title;
  final String description;
  final String pubDate;
  final String link;

  RssItem({
    required this.title,
    required this.description,
    required this.pubDate,
    required this.link,
  });
}

List<RssItem> filterEnvironmentalNews(List<RssItem> items) {
  final keywords = ['environment', 'climate', 'pollution', 'sustainability'];

  return items.where((item) {
    final title = item.title.toLowerCase();
    final description = item.description.toLowerCase();

    return keywords.any(
        (keyword) => title.contains(keyword) || description.contains(keyword));
  }).toList();
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<RssItem>> rssFeed;

  @override
  void initState() {
    super.initState();
    rssFeed = fetchRssFeed(
        'https://www.jpl.nasa.gov/feeds/news/'); // Replace with the actual RSS URL
  }

  Future<void> _launchUrl(Uri uri) async {
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Environmental News'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<RssItem>>(
        future: rssFeed,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading news'));
          } else {
            final filteredNews = filterEnvironmentalNews(snapshot.data!);

            return ListView.builder(
              itemCount: filteredNews.length,
              itemBuilder: (context, index) {
                final item = filteredNews[index];
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 206, 222, 251)),
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.pubDate.substring(1, 10)),
                    onTap: () {
                      final url = item.link;
                      if (url.isNotEmpty) {
                        _launchUrl(Uri.parse(url));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("No link available for this article")));
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: const CqButtomnNavBar(
        page: 2,
      ),
    );
  }
}
