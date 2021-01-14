class Failure {
  final String message;
  final int type;

  Failure(this.message, {this.type});

  @override
  String toString() => message;
}
