/// This method is used for throwing custom errors
///
/// It accepts the [message] and the [type] properties
/// [message] is the error message
/// [type] is used occasionally to register and detect the type of error
class Failure {
  final String message;
  final int type;

  Failure(this.message, {this.type});

  @override
  String toString() => message;
}
