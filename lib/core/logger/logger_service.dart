import 'package:logger/web.dart';

class LoggerService {
  final logger = Logger();

  void info(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.i(message);
  }

  void debug(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.d(message);
  }

  void error(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.e(message);
  }
}
