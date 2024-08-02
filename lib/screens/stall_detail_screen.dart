import 'package:flutter/material.dart';

class StallDetailScreen extends StatelessWidget {
  final Stall stall;

  const StallDetailScreen({Key? key, required this.stall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(stall.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company: ${stall.company}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${stall.description}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text('Media:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stall.videos.length + 1, 
                itemBuilder: (context, index) {
                  if (index < stall.videos.length) {
                    return Container(
                      width: 120,
                      margin: EdgeInsets.only(right: 10),
                      color: Colors.blue,
                      child: Center(child: Text('Video ${index + 1}')),
                    );
                  } else {
                    
                    return Container(
                      width: 120,
                      margin: EdgeInsets.only(right: 10),
                      color: Colors.green,
                      child: Center(child: Text('Image')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Stall {
  final String name;
  final String company;
  final String description;
  final String imageUrl;
  final List<String> videos;
  final int numberOfFiles;
  final DateTime startDate;
  final DateTime endDate;

  Stall({
    required this.name,
    required this.company,
    required this.description,
    required this.imageUrl,
    required this.videos,
    required this.numberOfFiles,
    required this.startDate,
    required this.endDate,
  });
}
