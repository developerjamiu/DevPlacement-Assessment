enum Status { initial, loading, loaded, back }

extension StatusExtension on Status {
  bool get isLoading => this == Status.loading;
}
