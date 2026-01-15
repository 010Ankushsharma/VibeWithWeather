import 'package:flutter/material.dart';

class WeatherTunePage extends StatelessWidget {
  const WeatherTunePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Tune 🎵')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
            ),
            title: const Text('Song Name'),
            subtitle: const Text('Artist'),
            trailing: const Icon(Icons.open_in_new),
          );
        },
      ),
    );
  }
}
