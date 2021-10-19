import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop_app/core/init/notifier/theme_notoifier.dart';
import 'package:shop_app/core/init/service/product_service.dart';
import 'package:shop_app/core/init/service/user_operations_service.dart';

import '../navigation/navigation_service.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider get instance {
    if (_instance == null) _instance = ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();
  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
    ),
    Provider<ProductService>(create: (context) => ProductService()),
    ChangeNotifierProvider<User>(create: (context) => User(context)),
    Provider.value(value: NavigationService.instance)
  ];
  List<SingleChildWidget> uiChangesItems = [];
}
