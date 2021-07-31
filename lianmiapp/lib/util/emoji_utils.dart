import 'package:lianmiapp/res/expressio_standard.dart';

class EmojiUitls {
  final Map<String, String> _emojiMap = new Map<String, String>();

  Map<String, String> get emojiMap => _emojiMap;

  static EmojiUitls? _instance;
  static EmojiUitls get instance {
    if (_instance == null) _instance = new EmojiUitls._();
    return _instance!;
  }

  EmojiUitls._() {
    ExpressionStandard.expressionPath.forEach((element) {
      _emojiMap['[${element.label}]'] = element.path!;
    });
  }
}
