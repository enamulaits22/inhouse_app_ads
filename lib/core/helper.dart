import 'package:url_launcher/url_launcher.dart';

class Helper {
  Helper._();
  static Helper instance = Helper._();

  ///Launch url in default browser
  Future<void> launchUrlInBrowser(String urlToLaunch) async {
    final uri = Uri.parse(urlToLaunch);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $urlToLaunch';
    }
  }
}
