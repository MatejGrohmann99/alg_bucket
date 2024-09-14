
import 'package:alg_bucket/core/service/firebase_storage_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HomePageContentView extends StatefulWidget {
  const HomePageContentView({super.key});

  @override
  State<HomePageContentView> createState() => _HomePageContentViewState();
}

class _HomePageContentViewState extends State<HomePageContentView> {
  @override
  void initState() {
    FirebaseStorageService.instance.getUserAlgCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Center(
        child: Text('HomePageContentView'),
      ),
    );
  }
}
