import 'dart:io';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart'; //日志插件

class LogManager {
  factory LogManager() => const LogManager.instance();

  const LogManager.instance();

  //日志等级
  static SDKLogLevel _logLevel = SDKLogLevel.verbose;
  static SDKLogLevel get logLevel => _logLevel;

  //日志输出实例
  static Logger? _logger;
  static Logger get logger => _logger!;

  static Logger? _loggerNoStack;
  static Logger get loggerNoStack => _loggerNoStack!;

  /// 初始化日志输出实例，传参是日志等级
  void init(SDKLogLevel level, {LogOutputEnum? output}) async {
    _logLevel = level;

    //如果不填，默认为文件
    if (output == null) {
      Directory tempDir = await getTemporaryDirectory();

      String logFilepath = tempDir.path + '/linkme_sdk.log';

      var logFile = new File(logFilepath);

      // FileOutput fileOutput = new FileOutput(file: logFile);

      _logger = Logger(
        printer: PrettyPrinter(),
        // output: fileOutput,
        level: Level.values[_logLevel.index],
      );

      _loggerNoStack = Logger(
        printer: PrettyPrinter(methodCount: 0),
        // output: fileOutput,
        level: Level.values[_logLevel.index],
      );
    } else {
      switch (output) {
        case LogOutputEnum.console:
          _logger = Logger(
            printer: PrettyPrinter(),
            output: ConsoleOutput(),
            level: Level.values[_logLevel.index],
          );

          _loggerNoStack = Logger(
            printer: PrettyPrinter(methodCount: 0),
            output: ConsoleOutput(),
            level: Level.values[_logLevel.index],
          );
          break;
        case LogOutputEnum.file:
          // TODO: Handle this case.
          break;
        case LogOutputEnum.stream:
          // TODO: Handle this case.
          break;
      }
    }
  }

  /// 日志输出 -verbose
  void logV(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    SDKLogLevel curLevel = SDKLogLevel.verbose;

    if (_logger == null) {
      _logger = Logger(
        printer: PrettyPrinter(),
        level: Level.values[_logLevel.index],
      );

      _loggerNoStack = Logger(
        printer: PrettyPrinter(methodCount: 0),
        level: Level.values[_logLevel.index],
      );
    }
    if (curLevel.index >= _logLevel.index) {
      switch (curLevel) {
        case SDKLogLevel.verbose:
          if (AppManager.isProduct) {
            _loggerNoStack!.v(message, error, stackTrace);
          } else {
            _logger!.v(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.debug:
          if (AppManager.isProduct) {
            _loggerNoStack!.d(message, error, stackTrace);
          } else {
            _logger!.d(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.info:
          if (AppManager.isProduct) {
            _loggerNoStack!.i(message, error, stackTrace);
          } else {
            _logger!.i(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.warning:
          if (AppManager.isProduct) {
            _loggerNoStack!.w(message, error, stackTrace);
          } else {
            _logger!.w(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.error:
          if (AppManager.isProduct) {
            _loggerNoStack!.e(message, error, stackTrace);
          } else {
            _logger!.e(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.wtf:
          if (AppManager.isProduct) {
            _loggerNoStack!.wtf(message, error, stackTrace);
          } else {
            _logger!.wtf(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.nothing: // 关闭日志
          break;
      }
    }
  }

  /// 日志输出 -debug
  void logD(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    SDKLogLevel curLevel = SDKLogLevel.debug;

    if (_logger == null) {
      _logger = Logger(
        printer: PrettyPrinter(),
        level: Level.values[_logLevel.index],
      );

      _loggerNoStack = Logger(
        printer: PrettyPrinter(methodCount: 0),
        level: Level.values[_logLevel.index],
      );
    }
    if (curLevel.index >= _logLevel.index) {
      switch (curLevel) {
        case SDKLogLevel.verbose:
          if (AppManager.isProduct) {
            _loggerNoStack!.v(message, error, stackTrace);
          } else {
            _logger!.v(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.debug:
          if (AppManager.isProduct) {
            _loggerNoStack!.d(message, error, stackTrace);
          } else {
            _logger!.d(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.info:
          if (AppManager.isProduct) {
            _loggerNoStack!.i(message, error, stackTrace);
          } else {
            _logger!.i(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.warning:
          if (AppManager.isProduct) {
            _loggerNoStack!.w(message, error, stackTrace);
          } else {
            _logger!.w(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.error:
          if (AppManager.isProduct) {
            _loggerNoStack!.e(message, error, stackTrace);
          } else {
            _logger!.e(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.wtf:
          if (AppManager.isProduct) {
            _loggerNoStack!.wtf(message, error, stackTrace);
          } else {
            _logger!.wtf(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.nothing: // 关闭日志
          break;
      }
    }
  }

  /// 日志输出 -info
  void logI(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    SDKLogLevel curLevel = SDKLogLevel.info;

    if (_logger == null) {
      _logger = Logger(
        printer: PrettyPrinter(),
        level: Level.values[_logLevel.index],
      );

      _loggerNoStack = Logger(
        printer: PrettyPrinter(methodCount: 0),
        level: Level.values[_logLevel.index],
      );
    }
    if (curLevel.index >= _logLevel.index) {
      switch (curLevel) {
        case SDKLogLevel.verbose:
          if (AppManager.isProduct) {
            _loggerNoStack!.v(message, error, stackTrace);
          } else {
            _logger!.v(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.debug:
          if (AppManager.isProduct) {
            _loggerNoStack!.d(message, error, stackTrace);
          } else {
            _logger!.d(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.info:
          if (AppManager.isProduct) {
            _loggerNoStack!.i(message, error, stackTrace);
          } else {
            _logger!.i(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.warning:
          if (AppManager.isProduct) {
            _loggerNoStack!.w(message, error, stackTrace);
          } else {
            _logger!.w(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.error:
          if (AppManager.isProduct) {
            _loggerNoStack!.e(message, error, stackTrace);
          } else {
            _logger!.e(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.wtf:
          if (AppManager.isProduct) {
            _loggerNoStack!.wtf(message, error, stackTrace);
          } else {
            _logger!.wtf(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.nothing: // 关闭日志
          break;
      }
    }
  }

  /// 日志输出 -warning
  void logW(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    SDKLogLevel curLevel = SDKLogLevel.warning;

    if (_logger == null) {
      _logger = Logger(
        printer: PrettyPrinter(),
        level: Level.values[_logLevel.index],
      );

      _loggerNoStack = Logger(
        printer: PrettyPrinter(methodCount: 0),
        level: Level.values[_logLevel.index],
      );
    }
    if (curLevel.index >= _logLevel.index) {
      switch (curLevel) {
        case SDKLogLevel.verbose:
          if (AppManager.isProduct) {
            _loggerNoStack!.v(message, error, stackTrace);
          } else {
            _logger!.v(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.debug:
          if (AppManager.isProduct) {
            _loggerNoStack!.d(message, error, stackTrace);
          } else {
            _logger!.d(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.info:
          if (AppManager.isProduct) {
            _loggerNoStack!.i(message, error, stackTrace);
          } else {
            _logger!.i(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.warning:
          if (AppManager.isProduct) {
            _loggerNoStack!.w(message, error, stackTrace);
          } else {
            _logger!.w(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.error:
          if (AppManager.isProduct) {
            _loggerNoStack!.e(message, error, stackTrace);
          } else {
            _logger!.e(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.wtf:
          if (AppManager.isProduct) {
            _loggerNoStack!.wtf(message, error, stackTrace);
          } else {
            _logger!.wtf(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.nothing: // 关闭日志
          break;
      }
    }
  }

  /// 日志输出 - error
  void logE(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    SDKLogLevel curLevel = SDKLogLevel.error;

    if (_logger == null) {
      _logger = Logger(
        printer: PrettyPrinter(),
        level: Level.values[_logLevel.index],
      );

      _loggerNoStack = Logger(
        printer: PrettyPrinter(methodCount: 0),
        level: Level.values[_logLevel.index],
      );
    }
    if (curLevel.index >= _logLevel.index) {
      switch (curLevel) {
        case SDKLogLevel.verbose:
          if (AppManager.isProduct) {
            _loggerNoStack!.v(message, error, stackTrace);
          } else {
            _logger!.v(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.debug:
          if (AppManager.isProduct) {
            _loggerNoStack!.d(message, error, stackTrace);
          } else {
            _logger!.d(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.info:
          if (AppManager.isProduct) {
            _loggerNoStack!.i(message, error, stackTrace);
          } else {
            _logger!.i(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.warning:
          if (AppManager.isProduct) {
            _loggerNoStack!.w(message, error, stackTrace);
          } else {
            _logger!.w(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.error:
          if (AppManager.isProduct) {
            _loggerNoStack!.e(message, error, stackTrace);
          } else {
            _logger!.e(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.wtf:
          if (AppManager.isProduct) {
            _loggerNoStack!.wtf(message, error, stackTrace);
          } else {
            _logger!.wtf(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.nothing: // 关闭日志
          break;
      }
    }
  }

  /// 日志输出 - what the fuck
  void logWTF(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    SDKLogLevel curLevel = SDKLogLevel.wtf;

    if (_logger == null) {
      _logger = Logger(
        printer: PrettyPrinter(),
        level: Level.values[_logLevel.index],
      );

      _loggerNoStack = Logger(
        printer: PrettyPrinter(methodCount: 0),
        level: Level.values[_logLevel.index],
      );
    }
    if (curLevel.index >= _logLevel.index) {
      switch (curLevel) {
        case SDKLogLevel.verbose:
          if (AppManager.isProduct) {
            _loggerNoStack!.v(message, error, stackTrace);
          } else {
            _logger!.v(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.debug:
          if (AppManager.isProduct) {
            _loggerNoStack!.d(message, error, stackTrace);
          } else {
            _logger!.d(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.info:
          if (AppManager.isProduct) {
            _loggerNoStack!.i(message, error, stackTrace);
          } else {
            _logger!.i(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.warning:
          if (AppManager.isProduct) {
            _loggerNoStack!.w(message, error, stackTrace);
          } else {
            _logger!.w(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.error:
          if (AppManager.isProduct) {
            _loggerNoStack!.e(message, error, stackTrace);
          } else {
            _logger!.e(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.wtf:
          if (AppManager.isProduct) {
            _loggerNoStack!.wtf(message, error, stackTrace);
          } else {
            _logger!.wtf(message, error, stackTrace);
          }

          break;

        case SDKLogLevel.nothing: // 关闭日志
          break;
      }
    }
  }
}

//简化
void logV(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
  LogManager.instance().logV(message, error, stackTrace);
}

//简化
void logD(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
  LogManager.instance().logD(message, error, stackTrace);
}

//简化
void logI(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
  LogManager.instance().logI(message, error, stackTrace);
}

//简化
void logW(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
  LogManager.instance().logW(message, error, stackTrace);
}

//简化
void logE(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
  LogManager.instance().logE(message, error, stackTrace);
}

//简化
void logWTF(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
  LogManager.instance().logWTF(message, error, stackTrace);
}
