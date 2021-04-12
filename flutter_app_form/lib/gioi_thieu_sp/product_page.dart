import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gioi thieu san pham",
      theme: ThemeData(primarySwatch: Colors.red),
      home: ProductViewPage(),
    );
  }
}

class ProductViewPage extends StatefulWidget {
  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  List<String> img = ['images/1.jpg', 'images/5.jpg', 'images/16.jpg'];
  int imgPos = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Gioi thieu san pham"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: width * 0.9,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  imgPos = index;
                });
              },
            ),
            itemCount: img.length,
            itemBuilder: (context, index, realIndex) => Container(
              height: width * 0.9,
              width: width * 0.9,
              child: Image.asset(
                img[index],
                width: 200,
                height: 300,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${imgPos + 1}/${img.length}",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text("RAM Laptop Kingmax 8GB DDR4 2400 - Hàng chính hãng", style: TextStyle(fontSize: 25),),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star_half,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text("(Xem 100 đánh giá)", style: TextStyle(fontSize: 20),)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
