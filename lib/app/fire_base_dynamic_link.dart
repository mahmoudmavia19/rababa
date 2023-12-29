import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share/share.dart';

class DynamicLinkProvider {


  Future<String> createLink(String refCode) async{
    final String url = "https://com.Rababa.rababa?ref=$refCode";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      androidParameters:const AndroidParameters(packageName: 'com.Rababa.rababa',minimumVersion: 0),
        link: Uri.parse(url), uriPrefix: "https://rababa.page.link");
    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters) ;
    return refLink.shortUrl.toString() ;
  }

  void initDynamicLink()async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink() ;
    if(instanceLink!=null)
      {
        final Uri refLink = instanceLink.link;
        Share.share("this is the link ${refLink.data}");
      }

  }

}
