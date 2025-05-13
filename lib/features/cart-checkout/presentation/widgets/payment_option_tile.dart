import 'package:flutter/material.dart';

class PaymentOptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const PaymentOptionTile({
    super.key,
    required this.title,
    required this.icon,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 2 : 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        onTap: onTap,
        trailing: Radio<bool>(
          value: true,
          groupValue: selected,
          onChanged: (_) => onTap(),
        ),
      ),
    );
  }
}
