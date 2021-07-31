import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/util/alert_utils.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/sdk/AuthMod.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateUtils {
  static void checkForUpdate({bool showLoading = true}) {
    if (showLoading) HubView.showLoading();
    AuthMod.checkUpdate().then((value) async {
      HubView.dismiss();
      logD(value);
      String newVersion = value['version'];
      int newVersionCode = int.parse(newVersion.replaceAll('.', ''));
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String localVersion = packageInfo.version;
      int localVersionCode = int.parse(localVersion.replaceAll('.', ''));
      if (newVersionCode > localVersionCode) {
        AlertUtils.showChooseAlert(App.context!,
            title: '提示',
            content: '检测到新版本',
            confirmTitle: '去更新', onTapConfirm: () {
          String downloadUrl = value['download_url'];
          launch(downloadUrl);
        });
      } else {
        if (showLoading) HubView.showToastAfterLoadingHubDismiss('当前已是最新版本');
      }
    }).catchError((err) {
      HubView.dismiss();
      logE('检查版本更新失败:$err');
      if (showLoading) HubView.showToastAfterLoadingHubDismiss('检查版本更新失败:$err');
    });
  }
}
