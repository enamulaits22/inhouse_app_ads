import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/inAppAdsSupabaseModelResponse.dart';

/// Flutter package to seamlessly integrate and display in-house app ads sourced from Supabase.
///
/// This package provides a straightforward solution for developers to incorporate advertisements within their Flutter applications while leveraging Supabase as the backend for ad data management.
///
/// Features:
/// - **Easy Integration:** Streamline the process of adding in-house ads to your Flutter app with minimal effort.
/// - **Supabase Integration:** Retrieve ad content and configurations from Supabase, enabling dynamic updates and customization without app updates.
/// - **Customizable UI:** Tailor the appearance of ads to seamlessly blend with your app's design, ensuring a consistent user experience.
/// - **Efficient Rendering:** Optimize ad rendering for performance, ensuring smooth user interaction and a responsive app.
///
/// Usage:
/// 1. Initialize the package with Supabase credentials.
/// 2. Configure the ad display parameters and UI components.
/// 3. Integrate the ad widget into your app's layout.
/// 4. Enjoy dynamic and customizable in-house ads sourced from Supabase.
///
/// Example:
/// ```dart
/// InHouseAdManager adManager = InHouseAdManager(
///   supabaseUrl: 'your_supabase_url',
///   supabaseKey: 'your_supabase_key',
/// );
///
/// AdWidget adWidget = AdWidget(
///   adManager: adManager,
///   // Additional configuration parameters can be set here.
/// );
///
/// // Add adWidget to your app's widget tree.
/// ```
///
/// Note: Make sure to replace 'your_supabase_url' and 'your_supabase_key' with your Supabase project URL and API key.
///
/// For more details and customization options, refer to the documentation on GitHub.
/// GitHub: https://github.com/yourusername/your-package-repo
///
/// Created by [Audacity IT Solutions Limited] - [founders@audacityit.com]
/// Version: 1.0.0
/// License: MIT

class AdsService {
  /// Initializes the AdsService with Supabase credentials.
  ///
  AdsService._();
  static AdsService instance = AdsService._();

  Future<void> initAds({
    required String supabaseUrl,
    required String supabaseKey,
  }) async {
    /// Use Supabase SDK to initialize with provided URL and key.
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
  }

  /// Getter method to access the SupabaseClient instance.
  SupabaseClient get _supabaseClient => Supabase.instance.client;

  //:::::::::::::::::::: GET Data from Supabase ::::::::::::::::::::::
  Future<List<InAppAdsSupabaseModelResponse>>
      getAdsModeListFromSupabase() async {
    const String tableName = 'audacity_apps_ads';
    List<InAppAdsSupabaseModelResponse> dataList = [];

    try {
      final response = await _supabaseClient
          .from(tableName)
          .select()
          .order('id', ascending: true);

      dataList = response
          .map((e) => InAppAdsSupabaseModelResponse.fromJson(e))
          .toList();

      return dataList;
    } catch (e, st) {
      log('[❌❌❌ ERROR] ${e.toString()}');
      log('[❌❌❌ ERROR] $st');
      // chatRoleInfo = [];
    }
    return dataList;
  }
}
