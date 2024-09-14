import 'package:alg_bucket/core/logic/navigation/navigation_bloc.dart';
import 'package:alg_bucket/presentation/fluent_ui/views/settings_content_view.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../views/about_project_content_view.dart';
import '../views/getting_started_content_view.dart';
import '../views/home_page_content_view.dart';

abstract class WebViewMapper {
  static Widget view(NavigationDestinationEnum item) => switch (item) {
        NavigationDestinationEnum.signInUserHomePage => const HomePageContentView(),
        NavigationDestinationEnum.signInUserSettings => const SettingsContentView(),
        NavigationDestinationEnum.newUserHomePage => const GettingStartedContentView(),
        NavigationDestinationEnum.newUserAbout ||
        NavigationDestinationEnum.signInUserAboutPage =>
          const AboutProjectContentView(),
      };
}
