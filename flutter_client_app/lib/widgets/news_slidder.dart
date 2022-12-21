import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class news_widget extends StatelessWidget {
  const news_widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 220.0),
      items: [1,2,3,4,5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(8,8,44,1.0),
                        Color.fromRGBO(8,8,44,0.85),
                      ],
                    )
                ),
                child: Text('text $i', style: const TextStyle(fontSize: 16.0),)
            );
          },
        );
      }).toList(),
    );
  }
}
