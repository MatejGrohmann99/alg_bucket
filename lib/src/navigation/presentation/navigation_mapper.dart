import 'package:fluent_ui/fluent_ui.dart';

import '../../about/presentation/about_project_content_view.dart';
import '../../getting_started/presentation/getting_started_content_view.dart';
import '../../algset/presentation/algset_page.dart';
import '../../settings/presentation/settings_content_view.dart';
import '../domain/navigation_destination.dart';

abstract class NavigationMapper {
  static List<NavigationPaneItem> getPaneItems(List<NavigationDestinationEnum> destinations) {
    return destinations.map<NavigationPaneItem>(
      (item) {
        return PaneItem(
          title: Text(
            getNavigationDestinationTitle(item),
          ),
          body: getNavigationDestinationBody(item),
          icon: Icon(
            getNavigationDestinationIcon(item),
          ),
        );
      },
    ).toList();
  }

  static String getNavigationDestinationTitle(NavigationDestinationEnum destination) {
    return switch (destination) {
      NavigationDestinationEnum.signInUserHomePage => 'Your algorithms',
      NavigationDestinationEnum.signInUserSettings => 'User settings',
      NavigationDestinationEnum.signInUserAboutPage => 'About project',
      NavigationDestinationEnum.newUserHomePage => 'Getting started',
      NavigationDestinationEnum.newUserAbout => 'About project',
    };
  }

  static Widget getNavigationDestinationBody(NavigationDestinationEnum destination) {
    return switch (destination) {
      NavigationDestinationEnum.signInUserHomePage => const HomePageContentView(),
      NavigationDestinationEnum.signInUserSettings => const SettingsContentView(),
      NavigationDestinationEnum.newUserHomePage => const GettingStartedContentView(),
      NavigationDestinationEnum.newUserAbout ||
      NavigationDestinationEnum.signInUserAboutPage =>
        const AboutProjectContentView(),
    };
  }

  static IconData getNavigationDestinationIcon(NavigationDestinationEnum item) {
    return switch (item) {
      NavigationDestinationEnum.signInUserHomePage => FluentIcons.border_dash,
      NavigationDestinationEnum.signInUserSettings => FluentIcons.settings,
      NavigationDestinationEnum.newUserHomePage => FluentIcons.apps_content,
      NavigationDestinationEnum.newUserAbout || NavigationDestinationEnum.signInUserAboutPage => FluentIcons.info,
    };
  }
}
