import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

///{@category Core}

//logs >= info in release
class InfoFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kProfileMode || kDebugMode) return true;
    return event.level.index >= Level.info.index;
  }
}

final memLog = MemoryOutput(bufferSize: 10000, secondOutput: ConsoleOutput());

final log = Logger(
    printer: PrettyPrinter(
        methodCount: 0,
        dateTimeFormat: DateTimeFormat.none,
        colors: false,
        lineLength: 200,
        noBoxingByDefault: true),
    filter: InfoFilter(),
    output: memLog);
