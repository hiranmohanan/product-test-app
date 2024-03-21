import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        
        child: Column(
          children: [
            const Text('Product Name'),
            SizedBox(height: 10),
            const Text('Product Description'),
            const SizedBox(height: 10),
    
    
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/150'),
                  fit: BoxFit.cover,
                ),
              ),
              
            )
          ],
        ),
      ),
    );
  }
}
