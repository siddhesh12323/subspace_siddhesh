import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostsDetailPage extends StatefulWidget {
  PostsDetailPage({Key? key, required this.imageUrl, required this.title})
      : super(key: key);
  String imageUrl;
  String title;

  @override
  State<PostsDetailPage> createState() => _PostsDetailPageState();
}

class _PostsDetailPageState extends State<PostsDetailPage> {
  Icon unfavoriteIcon = const Icon(
    Icons.favorite_border_outlined,
    color: Colors.white,
  );
  Icon favoriteIcon = const Icon(
    Icons.favorite,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //title: const Text('Subspace'),
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 45, 0, 0),
              child: SvgPicture.asset(
                'images/subspace_hor.svg', // Replace with your SVG or PNG image path
                height: 26, // Adjust the height as needed
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageUrl,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (unfavoriteIcon.icon ==
                            Icons.favorite_border_outlined) {
                          unfavoriteIcon = favoriteIcon;
                        } else {
                          unfavoriteIcon = const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          );
                        }
                      });
                    },
                    icon: unfavoriteIcon)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
