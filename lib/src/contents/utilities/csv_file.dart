import 'dart:io';

/// This is used to extend the functionality of the flutter [File] object
///
/// This is to make it easily mocked while testing
class CSVFile {
  File getFileFromPath(String filePath) => File(filePath);

  List<String> readAsLinesSync(File file) => file.readAsLinesSync();
}
