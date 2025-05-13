import 'package:flutter/material.dart';

class DeliveryOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final bool selected;
  final VoidCallback onTap;
  const DeliveryOptionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 2 : 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,
        leading: Radio<bool>(
          value: true,
          groupValue: selected,
          onChanged: (_) => onTap(),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Text(
          price,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
