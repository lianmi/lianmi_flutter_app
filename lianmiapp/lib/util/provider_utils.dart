import 'package:provider/provider.dart';
import 'package:lianmiapp/util/app.dart';

// ignore: non_constant_identifier_names
T GetProvider<T>() => App.context!.read<T>();
