import 'package:ecommerce_app/core/router/app_router_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {}, // remove all items
            child: const Text(
              'Remove All',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            _CartItemTile(
              imageUrl:
                  'https://imgs.search.brave.com/arhRk40nX0-kDzG65bzg9xb8viMike9__BrnXtK5zu8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9oaXBz/LmhlYXJzdGFwcHMu/Y29tL3ZhZGVyLXBy/b2QuczMuYW1hem9u/YXdzLmNvbS8xNjcw/OTUxMTU4LTYtMTY3/MDk1MTE1NS5qcGc_/Y3JvcD0xeHc6MXho/O2NlbnRlcix0b3Am/cmVzaXplPTk4MDoq',
              title: "Men's Harrington Jacket",
              price: 148,
              size: 'M',
              color: 'Lemon',
            ),
            const SizedBox(height: 10),
            _CartItemTile(
              imageUrl:
                  'https://imgs.search.brave.com/pQ6jhgImDsDAo8HzKrcAiUPBVdKthuTKnvwRXV9DKqM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NDF0OFdoZHlTUUwu/anBn',
              title: "Men's Coaches Jacket",
              price: 52,
              size: 'M',
              color: 'Black',
            ),
            const Spacer(),
            _PriceSummary(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.pushNamed(AppRouterConstants.productCheckoutRoute);
                }, // checkout
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final String imageUrl, title, size, color;
  final double price;

  const _CartItemTile({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xfff6f6f6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 80,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Size - $size    Color - $color',
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _circleButton(Icons.remove, () {}),
                const SizedBox(width: 8),
                const Text('1', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                _circleButton(Icons.add, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff0e6ff),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        color: Colors.deepPurple,
        onPressed: onTap,
      ),
    );
  }
}

class _PriceSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // const style = TextStyle(fontWeight: FontWeight.w500, fontSize: 14);
    return Column(
      children: const [
        _SummaryRow(label: 'Subtotal', value: '\$200'),
        _SummaryRow(label: 'Shipping Cost', value: '\$8.00'),
        _SummaryRow(label: 'Tax', value: '\$0.00'),
        Divider(height: 20),
        _SummaryRow(label: 'Total', value: '\$208', isBold: true),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label, value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}
