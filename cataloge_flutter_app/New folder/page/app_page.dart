
import 'package:cataloge_flutter_app/provider/catalog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'catalog_page.dart';

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderCatalog(),
      child: MaterialApp(
        title: "Cataloge",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
       home: CatalogPage(),
      ),
    );
  }
}
