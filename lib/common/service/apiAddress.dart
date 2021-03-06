import 'package:jessie_wish/common/config/Config.dart';

class Address {
  static const String host = "https://jessie.vampuck.com/";

  static userLogin() {
    return "${host}user/login";
  }

  static logOut() {
    return "${host}user/logout";
  }

  static registerJpush() {
    return "${host}user/jpush";
  }

  static sendMsg() {
    return "${host}user/notification";
  }

  static network() {
    return "${host}network";
  }

  static getWish() {
    return "${host}wish";
  }

  static deleteWish() {
    return "${host}wish/delete/";
  }

  static getAvailableVoucher() {
    return "${host}voucher/open";
  }

  static addVoucher() {
    return "${host}voucher";
  }

  static food() {
    return "${host}food";
  }

  static deleteFood() {
    return "${host}food/delete/";
  }

  static anniv() {
    return "${host}anniv";
  }

  static update() {
    return "${host}update";
  }

  static flower() {
    return "${host}flower";
  }

  static restaurant() {
    return "${host}restaurant";
  }

  static delRestaurant() {
    return "${host}restaurant/restaurant/";
  }

  static delDish() {
    return "${host}restaurant/dish/";
  }

  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return "${tab}page=$page&per_page=$pageSize";
      } else {
        return "${tab}page=$page";
      }
    } else {
      return "";
    }
  }
}
