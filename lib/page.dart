import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hw5/beers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Beers>? _beers;
  bool isLoading = true;
  //
  void _getBeers() async {
    Response response = await Dio().get('https://api.sampleapis.com/beers/ale');
    List<dynamic> jsonData = response.data;

    setState(() {
      _beers = jsonData.map((beers) => Beers.fromJson(beers)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // เรียกเมธอดสำหรับโหลดข้อมูลใน initState() ของคลาสที่ extends มาจาก State
    _getBeers();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beers Rating',
        ),
      ),
      //
      body: _beers == null
          ? SizedBox.shrink()
          : ListView.builder(
              itemCount: _beers!.length,
              itemBuilder: (context, index) {
                var beer = _beers![index];
                return InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("Name:" + '${beer.name}'),
                            Text("Price:" + '${beer.price}'),
                            Text("reviews:" + '${beer.reviews}'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                beer.image ?? '',
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error);
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text(beer.name ?? ''),
                    subtitle: Text(beer.price ?? ''),
                    trailing: Image.network(
                      beer.image ?? '',
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
