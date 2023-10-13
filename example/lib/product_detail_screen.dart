import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medusa_demo/currency_formatter.dart';
import 'package:medusa_demo/main.dart';
import 'package:medusa_flutter/medusa_flutter.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isItemAlreadyInCart = false; //this is only for example purpose, need to fetch this from cartId
  @override
  Widget build(BuildContext context) {
    String price;
    String symbol;
    final product = widget.product;
    if (product.variants?.isEmpty ?? false || (product.variants?.first.prices?.isEmpty ?? false)) {
      price = '';
      symbol = '\$';
    } else {
      final currencyFormatter = CurrencyTextInputFormatter(name: product.variants?[0].prices?[0].currencyCode);
      price = currencyFormatter.format(product.variants?.first.prices?.first.amount.toString() ?? '');
      symbol = product.variants![0].prices![0].currency?.symbol ?? '\$';
    }
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom + 10;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      bottomNavigationBar: _isItemAlreadyInCart
          ? null
          : Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, bottomPadding),
              child: ElevatedButton(
                onPressed: _addProductInCart,
                child: const Text("Add to Cart"),
              ),
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.thumbnail != null)
                Expanded(
                  child: Hero(
                    tag: product.thumbnail!,
                    child: Image.network(
                      product.thumbnail!,
                      errorBuilder: (context, error, stack) =>
                          const Icon(Icons.warning_amber_outlined, color: Colors.amber),
                    ),
                  ),
                ),
              if (product.thumbnail == null) const Spacer(),
              Text(
                product.title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (product.subtitle != null)
                Text(
                  product.subtitle!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              const SizedBox(
                height: 10,
              ),
              Text(
                symbol + price,
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addProductInCart() async {
    SnackBar addCartProgress = const SnackBar(
        content: Row(
      children: [
        CircularProgressIndicator(),
        SizedBox(
          width: 10,
        ),
        Text("Adding item into cart")
      ],
    ));
    ScaffoldMessenger.of(context).showSnackBar(addCartProgress);
    final regionRes = await medusa.regions.list();
    await regionRes.when((success) async {
      final result = await medusa.carts.create(
          req: StorePostCartReq(
              items: [Item(variantId: widget.product.variants?[0].id, quantity: 1)],
              regionId: success.regions?.first.id));

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      result.when((success) {
        _isItemAlreadyInCart = true;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Item added to cart"),
          duration: Duration(seconds: 3),
        ));
      }, (error) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          duration: const Duration(seconds: 3),
        ));
      });
    }, (error) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message),
        duration: const Duration(seconds: 3),
      ));
    });
  }
}
