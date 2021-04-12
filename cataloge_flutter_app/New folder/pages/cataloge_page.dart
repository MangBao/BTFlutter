import 'package:cataloge_flutter_app/provider/cataloge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogePage extends StatefulWidget {
  @override
  _CatalogePageState createState() => _CatalogePageState();
}

class _CatalogePageState extends State<CatalogePage> {
  @override
  Widget build(BuildContext context) {
    ProviderCataloge providerCataloge = context.watch<ProviderCataloge>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cataloge"),
        actions: [
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.shopping_cart, size: 48, color: Colors.green,),
                Text("${providerCataloge.slMH}", style: TextStyle(fontSize: 16),)
              ],
            ),
            //onTap: () => toCartPage(context),
          )
        ],
      ),
      //body: buil,
    );
  }
}

// class CatalogePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     ProviderCataloge providerCataloge = context.watch<ProviderCataloge>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cataloge"),
//         actions: [
//           GestureDetector(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Icon(Icons.shopping_cart, size: 48, color: Colors.green,),
//                 Text("${providerCataloge.slMH}", style: TextStyle(fontSize: 16),)
//               ],
//             ),
//             //onTap: () => toCartPage(context),
//           )
//         ],
//       ),
//       //body: buil,
//     );
//   }
// }
