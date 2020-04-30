import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class LogoutEvent {
  bool isUnauth;

  LogoutEvent(this.isUnauth);
}

class IndexEvent {
  int pageIndex;

  IndexEvent(this.pageIndex);
}

class RefreshRestaurant {
  bool refresh;

  RefreshRestaurant(this.refresh);
}
