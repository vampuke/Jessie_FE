import 'package:jessie_wish/common/config/Config.dart';

class Address {
  static const String host = "https://jessie.vampuck.com/";

  static userLogin() {
    return "${host}user/login";
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

  static anniv() {
    return "${host}anniv";
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
