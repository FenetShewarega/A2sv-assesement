import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
// import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Consumer<Cart>(
        builder: (context, cart, child) {
          return Card(
            
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: cart.itemCount == 0
                          ? MaterialStateProperty.all(Colors.orange[400]!)
                          : MaterialStateProperty.all(Colors.orange[900]!),
                    ),
                    onPressed: cart.itemCount == 0
                        ? null
                        : () {
                            // Order functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color.fromARGB(255, 255, 229, 214),
                                content: Text(
                                  "Purchase completed!",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(
                          color: cart.itemCount == 0 ? Colors.grey[100] : Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => Dismissible(
                key: Key(cart.items.values.toList()[i].id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    final itemKey = cart.items.keys.toList()[i];
                    cart.removeItem(itemKey);
                  });
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: cart.items.containsKey(cart.items.keys.toList()[i])
                    ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                          leading: Image.network(
                            cart.items.values.toList()[i].imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(cart.items.values.toList()[i].title),
                          subtitle: Text('Price: \$${cart.items.values.toList()[i].price}'),
                          trailing: Text('Quantity: ${cart.items.values.toList()[i].quantity}'),
                        ),
                    )
                    : const SizedBox.shrink(),
              ),
            ),
          )
        ],
      ),
    );
  }
}