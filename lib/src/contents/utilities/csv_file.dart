import 'dart:io';

class CSVFile {
  File getFileFromPath(String filePath) => File(filePath);

  List<String> readAsLinesSync(File file) => file.readAsLinesSync();
}
