import 'package:event_bus/event_bus.dart';
EventBus eventBus = EventBus();

class LogoutEvent {
  bool isUnauth;

  LogoutEvent(this.isUnauth);
}