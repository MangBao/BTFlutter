import 'package:cataloge_flutter_app/provider/cataloge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cataloge_page.dart';

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ProviderCataloge(),
    child: MaterialApp(
      title: "Cataloge App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatalogePage(),
    ),);
  }
}
