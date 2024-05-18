import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа №8',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> imageUrls = [
    'https://pic.rutubelist.ru/user/c9/6d/c96dc63958c6e871a5129798b85be77e.jpg',
    'https://yt3.googleusercontent.com/ytc/APkrFKb2cmqNpsV9zEFyUyAlT3jYKV8bxJBCzb7vbe-j=s900-c-k-c0x00ffffff-no-rj',
    'https://images.8tracks.com/cover/i/000/344/506/Nature-Mountains-907.jpg?rect=0,0,1600,1600&q=98&fm=jpg&fit=max',
    'https://img.goodfon.ru/original/2048x2048/3/43/priroda-peyzazh-melnicy-reka.jpg',
    'https://yt3.googleusercontent.com/ytc/AIf8zZSknZg6AOcDm4DO5AG97Ndvbwl04EFaaIcqmwSy=s900-c-k-c0x00ffffff-no-rj',
    'https://avatars.yandex.net/get-music-content/2266607/da1de77d.a.8873173-1/m1000x1000?webp=false'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Практическая работа №8'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: imageUrls[index],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
