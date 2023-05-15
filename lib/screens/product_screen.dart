import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Text('Product');
                }),
          )
        ]),
      ),
    );
  }
}
