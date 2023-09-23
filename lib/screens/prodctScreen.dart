import 'package:flutter/material.dart';
import 'package:task3/screens/ListScreen.dart';

import '../data/models/product.dart';

class ProductScreen extends StatelessWidget {
  final ProductData datak;
  const ProductScreen({super.key, required this.datak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height:80,
          ),
          Image.network(
            // width:370,
            // height:330,
              datak.image,
          ),
          SizedBox(
            height:50,
          ),
          Text(
              datak.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight:FontWeight.w700,
            color:Colors.black,
            fontSize:30,
          )),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              width:370,
              height:85,
              child: Text(
                  datak.detail,
                  textAlign: TextAlign.center,
                  style: const TextStyle(

                    color:Colors.black,
                    fontSize:12,
                  )),
            ),
          ),
          Text(
              datak.price.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight:FontWeight.w700,
                color:Colors.black,
                fontSize:16,
              )),
        ],
      ),
    );
  }
}
