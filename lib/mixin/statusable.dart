enum Status {
  initial,
  loading,
  updating,
  success,
  failure,
}

mixin Statusable {
  Status status = Status.initial;
}
