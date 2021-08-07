/*
 钱包模块 
 */

import 'package:linkme_flutter_sdk/common/http_utils.dart';
import 'package:linkme_flutter_sdk/common/urls.dart';
import 'dart:async';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

/// @nodoc 钱包类
class WalletMod {
  /// @nodoc 查询余额
  static Future getBalance() async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(HttpApi.getBalance);
      // logD('_body: $_body');

      if (_body['code'] == 200) {
        _completer.complete(_body['data']); //返回data部分
      } else {
        logE('getBalance error, msg: ${_body['msg']}');
        _completer.completeError('${_body['msg']}');
        return false;
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法查询余额');
    } finally {
      // logD('getBalance end.');
    }
    return _c;
  }

  /// @nodoc 微信预支付
  /// amount 充值金额，以元为单位
  static Future wxPrepay(double amount) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    //舍弃当前变量的小数部分。返回值为 int 类型。
    int _amount = (amount * 100).truncate();

    ///提交数据
    try {
      var _map = {
        'amount': _amount, //总金额，单位为分
      };

      var _body = await HttpUtils.post(HttpApi.wxPrepay, data: _map);

      if (_body['code'] == 200) {
        _completer.complete(_body['data']); //返回data部分, PrepayId
      } else if (_body['code'] == 302) {
        // logD('_body: $_body');
        _completer.complete(false); //1元充值仅限一次
      } else {
        logE('aliPrepay error, reson: ${_body['data']}');
        _completer.completeError('${_body['data']}');
        return false;
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法微信预支付');
    } finally {
      logD('wxPrepay end.');
    }
    return _c;
  }

  /// @nodoc 支付宝预支付
  /// amount 充值金额，以元为单位 精确到小数点后两位，取值范围：[0.01,100000000] 。
  /// 返回的是支付宝SDK需要的支付参数
  static Future aliPrepay(double amount) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _map = {
        'amount': amount, //总金额，单位为元 。
      };

      var _body = await HttpUtils.post(HttpApi.aliPrepay, data: _map);

      if (_body['code'] == 200) {
        _completer.complete(_body['data']); //返回data部分, payParam
      } else if (_body['code'] == 302) {
        // logD('_body: $_body');
        _completer.complete(false); //1元充值仅限一次
      } else {
        logE('aliPrepay error, reson: ${_body['data']}');
        _completer.completeError('${_body['data']}');
        return false;
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法支付宝预支付');
    } finally {
      logD('aliPrepay end.');
    }
    return _c;
  }

  /// @nodoc 查询充值记录
  /// start_time, end_time unix时间，毫秒
  static Future getTransactions(int startTime, int endTime,
      {int page = 1, int limit = 20}) async {
    try {
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['start_time'] = startTime;
      params['end_time'] = endTime;
      params['page'] = page;
      params['limit'] = limit;
      var _body = await HttpUtils.get(HttpApi.getTransactions, params: params);
      // logD('_body: $_body');
      var code = _body['code'];
      if (code == 200) {
        return _body['data'];
      } else {
        return '';
      }
    } catch (e) {
      logE(e);
    } finally {
      logD('AuthMod.getTransactions end.');
    }
  }

  /// @nodoc 查询手续费扣款记录
  /// start_time, end_time unix时间，毫秒
  static Future getSpendings(int startTime, int endTime,
      {int page = 1, int limit = 20}) async {
    try {
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['start_time'] = startTime;
      params['end_time'] = endTime;
      params['page'] = page;
      params['limit'] = limit;
      var _body = await HttpUtils.get(HttpApi.getSpendings, params: params);
      // logD('_body: $_body');
      var code = _body['code'];
      if (code == 200) {
        return _body['data'];
      } else {
        return '';
      }
    } catch (e) {
      logE(e);
    } finally {
      logD('AuthMod.getTransactions end.');
    }
  }
}
