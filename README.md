#inhouse_app_ads

A Flutter package for showing the In House Product Ads of Audacity It Solutions Ltd.

## Features

- Can be used for showing the product ads of the Audacity It Solutions Ltd.
- No need to import Supabase and its dependencies
- No need to create the Response/Model class for Supabase response
- By clicking on the ads item will be redirected to the AppStore(for IOS) or PlayStore(for Android)

## Getting started

1. Add the `inhouse_app_ads` package to your `pubspec.yaml`

    ```dart
      inhouse_app_ads:
         git:
         url: https://github.com/enamulaits22/inhouse_app_ads.git
         ref: main
    ```

2. Import `inhouse_app_ads`.
    ```dart
    import 'package:inhouse_app_ads/inhouse_app_ads.dart';
    ```


## Usage

1. Initialize `inhouse_app_ads` before using it
    ```dart
    import 'package:inhouse_app_ads/inhouse_app_ads.dart';

    void main() async {
    WidgetsFlutterBinding.ensureInitialized();
   
   // Add this
   await AdsService.instance.initAds(
    url: SUPABASE_URL,
    anonKey: SUPABASE_ANON_KEY,
    );
    
    runApp(MyApp());
    }
    ```
2. Call the `getAdsModeListFromSupabase()` method to get the list of `InAppAdsSupabaseModelResponse` instances, this will return `List<InAppAdsSupabaseModelResponse>` instances
    ```dart
    final supabase = AdsService.instance;
    final List<InAppAdsSupabaseModelResponse> data = await supabase.getAdsModeListFromSupabase();
    ```
3. There has a default implementation for UI `AdsPage`, where there need to pass the `InAppAdsSupabaseModelResponse` class instance and a `Primary color` for UI
    ```dart
    class MyAdsPage extends StatelessWidget {
    const MyAdsPage({super.key});
    
    @override
    Widget build(BuildContext context) {
    return AdsPage(
    state: inAppAdsSupabaseModelResponseInstance,
    primaryColor: primaryColor,
    );
    }
    }
    ```

