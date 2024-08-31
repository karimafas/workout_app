class RepositoryResult<T> {
  RepositoryResult({this.result, this.exception});

  final T? result;
  final Exception? exception;

  T get asSuccess => result!;

  bool get isSuccess => result != null;

  void fold({
    required Function(T) onSuccess,
    required Function(Exception) onException,
  }) {
    if (isSuccess) {
      onSuccess(result as T);
    } else {
      onException(exception as Exception);
    }
  }
}
