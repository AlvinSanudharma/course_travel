import 'package:course_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailDestinationPage extends StatefulWidget {
  const DetailDestinationPage({super.key, required this.destination});

  final DestinationEntity destination;

  @override
  State<DetailDestinationPage> createState() => _DetailDestinationPageState();
}

class _DetailDestinationPageState extends State<DetailDestinationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        widget.destination.name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        margin:
            EdgeInsets.only(left: 20, top: MediaQuery.of(context).padding.top),
        alignment: Alignment.centerLeft,
        child: const Row(
          children: [BackButton()],
        ),
      ),
    );
  }
}
