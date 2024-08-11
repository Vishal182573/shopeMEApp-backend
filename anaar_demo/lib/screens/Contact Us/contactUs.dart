import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'For any issues feel free to contact:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Iconsax.call_calling, color: Colors.blue),
              title: Text('Phone Number'),
              subtitle: Text('+123 456 7890'),
              onTap: () {
                // Add action to dial phone number
              },
            ),
            ListTile(
              leading: Icon(Icons.mail_outline_rounded, color: Colors.blue),
              title: Text('Email Address'),
              subtitle: Text('support@example.com'),
              onTap: () {
                // Add action to send email
              },
            ),
          ],
        ),
      ),
    );
  }
}
