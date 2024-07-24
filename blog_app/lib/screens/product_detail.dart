import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product/product.dart';
import '../models/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? 'Product Detail'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              shadowColor: Colors.grey,
              margin: const EdgeInsets.all(8),
              surfaceTintColor: Colors.white,

              child: CachedNetworkImage(
                imageUrl: product.image ?? '',
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.orange[900],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Loading image...",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.circular(5),

                      border: Border.all(
                        color: Colors.orange,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      product.description ?? '',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 16),
                 
                    Row(
                    children: [
                      Text(
                      'Category: ',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                      ),
                      ),
                      Text(
                      '${product.category}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      ),
                    ],
                    ),


   Row(
     children: [
      Row(
        children: [
          Text(
            'Rating: ',
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 14,
            ),
          ),
          Row(
            children: List.generate(
              (product.rating?.rate ?? 0.0).toInt(),
              (index) => Icon(
                Icons.star,
                color: Colors.orange,
                size: 14,
              ),
            ),
          ),
        ],
      ),
     ],
   ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              color: Colors.orange[800],
              child: TextButton(
                onPressed: () {
                  Provider.of<Cart>(context, listen: false).addItem(product: product);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add to Cart',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
