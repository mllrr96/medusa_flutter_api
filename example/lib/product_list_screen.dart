import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:medusa_demo/main.dart';
import 'package:medusa_demo/product_detail_screen.dart';
import 'package:medusa_flutter/medusa_flutter.dart';

import 'currency_formatter.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  ProductListScreenState createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductListScreen> {
  static const _pageSize = 20;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 4);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    final result = await medusa.products.list(queryParams: {
      'offset': _pagingController.itemList?.length ?? 0,
      'limit': _pageSize,
    });

    result.when((success) {
      final products = success.products;
      if (products == null) {
        _pagingController.error = 'Error loading products';
        return;
      }
      final isLastPage = products.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(products);
      } else {
        final nextPageKey = pageKey + products.length;
        _pagingController.appendPage(products, nextPageKey);
      }
    }, (error) {
      _pagingController.error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: Scaffold(
        body: SafeArea(
          child: PagedGridView(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Product>(
                itemBuilder: (context, product, index) => _ProductItem(product: product),
                firstPageProgressIndicatorBuilder: (context) =>
                    const Center(child: CircularProgressIndicator.adaptive()),
                noItemsFoundIndicatorBuilder: (_) => const Center(
                  child: Text('No products found'),
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              )),
        ),
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  final Product product;

  const _ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String price;
    String symbol;
    if (product.variants?.isEmpty ?? false || (product.variants?.first.prices?.isEmpty ?? false)) {
      price = '';
      symbol = '\$';
    } else {
      final currencyFormatter = CurrencyTextInputFormatter(name: product.variants?[0].prices?[0].currencyCode);
      price = currencyFormatter.format(product.variants?.first.prices?.first.amount.toString() ?? '');
      symbol = product.variants![0].prices![0].currency?.symbol ?? '\$';
    }

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.thumbnail != null)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: product.thumbnail!,
                        child: Image.network(
                          product.thumbnail!,
                          errorBuilder: (context, error, stack) => const Icon(Icons.warning_amber_outlined),
                        ),
                      ),
                    ],
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
              if (product.variants?.isNotEmpty ?? false)
                Text(
                  "$symbol $price",
                  style: Theme.of(context).textTheme.titleSmall,
                )
            ],
          ),
        ),
      ),
    );
  }
}
