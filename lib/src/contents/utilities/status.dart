/// This is used in the [FilterCarCubit] State to detect changes in the UI
enum Status { initial, loading, loaded, back }

extension StatusExtension on Status {
  bool get isLoading => this == Status.loading;
}
