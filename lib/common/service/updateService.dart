import 'package:jessie_wish/common/service/apiAddress.dart';
import 'package:jessie_wish/common/service/basicService.dart';
import 'package:package_info/package_info.dart';

class UpdateSvc {

  static getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static getLatestVersion() async {
    var res = await HttpManager.netFetch(Address.update(), null, null, null);
    if (res != null && res.result) {
      if (res.data["code"] == null) {
        var currentVersion = await getCurrentVersion();
        print(currentVersion);
        if (currentVersion != res.data["version"]) {
          return res.data;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
