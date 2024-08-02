import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'video_player_screen.dart';

class StallListScreen extends StatefulWidget {
  const StallListScreen({Key? key}) : super(key: key);

  @override
  _StallListScreenState createState() => _StallListScreenState();
}

class _StallListScreenState extends State<StallListScreen> {
  final List<Stall> stalls = [
    Stall(
      name: 'Gourmet Burger Shack',
      company: 'Food Co.',
      description: 'Delicious street food including burgers and fries.',
      imageUrl: 'assets/burger_shack.jpg',
      videos: [
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
        'https://www.youtube.com/watch?v=fFGpTaBI6dk',
         'https://www.youtube.com/watch?v=8QQ6nlhQXyg'

      ],
      numberOfFiles: 5,
      startDate: DateTime(2024, 6, 23),
      endDate: DateTime(2024, 6, 24),
    ),
    Stall(
      name: 'Fresh Organic Market',
      company: 'Fruit Farm',
      description: 'Fresh organic fruits and vegetables from local farms.',
      imageUrl: 'assets/organic_market.jpg',
      videos: [
        'https://www.youtube.com/watch?v=LGF33NN4B8U',
        'https://www.youtube.com/watch?v=rsD2VJ65hEA',
        'https://www.youtube.com/watch?v=If9U6ME3ycQ',
        'https://www.youtube.com/watch?v=aRxymTETvXk'

      ],
      numberOfFiles: 3,
      startDate: DateTime(2024, 6, 25),
      endDate: DateTime(2024, 6, 26),
    ),
    Stall(
      name: 'Artisan Crafts Corner',
      company: 'Crafts Co.',
      description: 'Handmade crafts and unique gifts from local artisans.',
      imageUrl: 'assets/crafts_corner.jpg',
      videos: [
        'https://www.youtube.com/watch?v=6FpY5Q5achs',
        'https://www.youtube.com/watch?v=lhIUet2eJdg',
        'https://www.youtube.com/shorts/UoFey62USHU'
      ],
      numberOfFiles: 4,
      startDate: DateTime(2024, 6, 27),
      endDate: DateTime(2024, 6, 28),
    ),
    Stall(
      name: 'Coffee & Pastry Haven',
      company: 'Coffee Co.',
      description: 'Artisan coffee and pastries to delight your taste buds.',
      imageUrl: 'assets/coffee_haven.png',
      videos: [
        'https://www.youtube.com/watch?v=wLtVgLt7dBA',
        'https://www.youtube.com/watch?v=Hm7PMJlQozI',
        'https://www.youtube.com/watch?v=zy-q26ycr3E'
      ],
      numberOfFiles: 2,
      startDate: DateTime(2024, 6, 29),
      endDate: DateTime(2024, 6, 30),
    ),
    Stall(
      name: 'Taco Fiesta',
      company: 'Mexican Delights',
      description: 'Gourmet tacos with fresh ingredients and bold flavors.',
      imageUrl: 'assets/taco_fiesta.png',
      videos: [
        'https://www.youtube.com/watch?v=7_MND9EHZtc',
        'https://www.youtube.com/watch?v=bfbea0iF6M4'
      ],
      numberOfFiles: 6,
      startDate: DateTime(2024, 7, 1),
      endDate: DateTime(2024, 7, 2),
    ),
    Stall(
      name: 'Sweet Treats Galore',
      company: 'Dessert Co.',
      description: 'Traditional sweets and desserts that bring back memories.',
      imageUrl: 'assets/sweet_treats.jpg',
      videos: [
        'https://www.youtube.com/watch?v=iDcekQeBGOY',
        'https://www.youtube.com/watch?v=8GxfnU5gVII'
      ],
      numberOfFiles: 8,
      startDate: DateTime(2024, 7, 3),
      endDate: DateTime(2024, 7, 4),
    ),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stall List'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _searchCard(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stall",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              _stallListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value.toLowerCase();
            });
          },
          decoration: InputDecoration(
            hintText: "Search",
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            prefixIcon: Icon(FontAwesomeIcons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _stallListView() {
    final filteredStalls = stalls
        .where((stall) =>
            stall.name.toLowerCase().contains(searchQuery) ||
            stall.company.toLowerCase().contains(searchQuery))
        .toList();

    return ListView.builder(
      itemCount: filteredStalls.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final stall = filteredStalls[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StallDetailScreen(stall: stall),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DateFormat('MMM d').format(stall.startDate)} - ${DateFormat('MMM d, yyyy').format(stall.endDate)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    stall.imageUrl,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 10),
                  Text(
                    stall.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Company: ${stall.company}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Files Uploaded: ${stall.numberOfFiles}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Image.asset("assets/redplus.png", width: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class StallDetailScreen extends StatefulWidget {
  final Stall stall;

  StallDetailScreen({Key? key, required this.stall}) : super(key: key);

  @override
  _StallDetailScreenState createState() => _StallDetailScreenState();
}

class _StallDetailScreenState extends State<StallDetailScreen> {
  List<File> _attachedImages = [];


  Future<void> _pickImage(int videoIndex) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File newImage = File(pickedFile.path);
      setState(() {
        widget.stall.attachedImages.add(newImage);
      });
    }
  }

  Widget _buildAttachedImages() {
    return GridView.builder(
      itemCount: widget.stall.attachedImages.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            
          },
          child: Image.file(widget.stall.attachedImages[index], fit: BoxFit.cover),
        );
      },
    );
  }


  void _launchImageViewer(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: Container(
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.windowClose,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowCircleLeft, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.upload, color: Colors.white),
            onPressed: () {
              
              widget.stall.attachedImages.forEach((image) {
                print(image.path);
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(widget.stall.videos.length + 1, (index) {
                    if (index < widget.stall.videos.length) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 350,
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(getThumbnail(widget.stall.videos[index])),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen(
                                  videoUrl: 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Icon(
                                FontAwesomeIcons.solidPlayCircle,
                                color: Colors.red,
                                size: 45,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          _launchImageViewer(context, widget.stall.imageUrl);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.stall.imageUrl),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Company: ${widget.stall.company}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Description: ${widget.stall.description}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '${widget.stall.numberOfFiles} Files',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  _pickImage(widget.stall.videos.length); 
                },
                child: DottedBorder(
                  color: Colors.black,
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(8),
                  dashPattern: [7, 7],
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      height: 70,
                      width: 320,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.plusSquare),
                          SizedBox(height: 5),
                          Text('Attach file'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildAttachedImages(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  } 


 String getThumbnail(String videoUrl) {
    if (videoUrl.contains('youtube.com') || videoUrl.contains('youtu.be')) {
      Uri uri = Uri.parse(videoUrl);
      String? videoId;

      if (uri.host.contains('youtube.com')) {
        videoId = uri.queryParameters['v'];
      } else if (uri.host.contains('youtu.be')) {
        videoId = uri.pathSegments.first;
      }

      if (videoId != null) {
        return 'https://img.youtube.com/vi/$videoId/0.jpg';
      }
    }

    return 'https://via.placeholder.com/150';
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
  List<File> attachedImages = [];

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
