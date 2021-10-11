
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class CallProvider with ChangeNotifier {

  Future<void> makingPhoneCall(String phone) async {
    String url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}