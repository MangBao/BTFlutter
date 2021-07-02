import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'monhoc_app.dart';

//cai nay nay Tri no chi tui , de test, nhung ma may cai cua ong la vl ra(wait a min)
// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
void main() {
  runApp(MyFirebaseApp());
}
