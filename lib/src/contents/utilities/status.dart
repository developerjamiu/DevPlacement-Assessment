enum Status { initial, loading, back }

extension StatusExtension on Status {
  bool get isLoading => this == Status.loading;
}
