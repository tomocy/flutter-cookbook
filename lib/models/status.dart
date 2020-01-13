class Status<T> {
  const Status._();

  factory Status.success(T value) => SuccessStatus(value);

  factory Status.failed(T error) => FailedStatus(error);
}

class SuccessStatus<T> extends Status<T> {
  const SuccessStatus(this.value) : super._();

  final T value;
}

class FailedStatus<T> extends Status<T> {
  const FailedStatus(this.error) : super._();

  final T error;
}
