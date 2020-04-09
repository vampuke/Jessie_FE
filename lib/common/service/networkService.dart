import 'package:jessie_wish/common/service/apiAddress.dart';
import 'package:jessie_wish/common/service/basicService.dart';

class NetworkSvc {
  static getNetwork() async {
    // User user = store.state.userInfo;
    // if (user == null || user.login == null) {
    //   return null;
    // }

    // String userName = user.login;
    String url = Address.network();

    var res = await HttpManager.netFetch(url, null, null, null);
    if (res != null && res.result) {
      return true;
    } else {
      return false;
    }
  }
}
