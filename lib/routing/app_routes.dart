abstract final class AppRoutes {
  static const login = '/login';
  static const home = '/';
  static const chat = '/chat';
  static const chatDetail = '/chat/detail';
  static const agent = '/agent';
  static const knowledge = '/knowledge';
  static const settings = '/settings';
  static const settingsModelProviders = '/settings/model-providers';
  static const settingsModelProvidersCatalog =
      '$settingsModelProviders/catalog';

  static String settingsModelProviderDetail(String providerId) {
    return '$settingsModelProviders/$providerId';
  }

  static String settingsModelProviderModels(String providerId) {
    return '$settingsModelProviders/$providerId/models';
  }
}
