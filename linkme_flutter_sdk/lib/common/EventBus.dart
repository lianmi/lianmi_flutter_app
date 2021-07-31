import 'package:event_bus/event_bus.dart';

//全局
EventBus global_bus = new EventBus();

EventBus get bus => global_bus;