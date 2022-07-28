import 'package:html/parser.dart' show parse;

class Util {

  static String parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    return document.body!.text;
  }
}