import 'package:lianmiapp/util/app.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'action_utils.dart';

///生成二维码的链接
class UrlUtil {
  static String mapToUrl(QrActionEnum action,
      {required Map<String, dynamic> data}) {
    String _url = App.downloadUrl + '?';
    switch (action) {
      case QrActionEnum.unknow:
        break;
      case QrActionEnum.personInfo:
        break;
    }
    _url += 'action=${action.index}';

    ///拼接数据
    data.forEach((key, value) {
      _url += '&$key=$value';
    });
    logD('解析后的二维码url: $_url');
    return _url;
  }

  ///通过url解析map
  static Map urlToMap(String url) {
    Map _map = Map();
    if (url.contains('?')) {
      String _value = url.substring(url.indexOf('?') + 1);
      List _l = _value.split('&');
      _l.forEach((element) {
        String _value = element.toString();
        if (_value.contains('=')) {
          String key = _value.substring(0, _value.indexOf('='));
          String value = _value.substring(_value.indexOf('=') + 1);
          _map[key] = value;
        }
      });
    }
    logD('url解析完成后的数据: $_map');
    return _map;
  }
}
