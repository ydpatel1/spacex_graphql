// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';

// class HiveConfig {
//   static const String graphqlCacheBox = 'graphql_cache';

//   static Future<void> init() async {
//     final appDocumentDir = await getApplicationDocumentsDirectory();
//     await Hive.initFlutter(appDocumentDir.path);

//     // Register any Hive adapters here if needed
//     // Hive.registerAdapter(YourAdapter());

//     // Open GraphQL cache box
//     if (!Hive.isBoxOpen(graphqlCacheBox)) {
//       await Hive.openBox(graphqlCacheBox);
//     }
//   }
// }
