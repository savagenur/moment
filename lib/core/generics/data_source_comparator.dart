// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataSourceComparator<T> {
  final T? local;
  final T? remote;

  const DataSourceComparator({
    this.local,
    this.remote,
  });
  bool get hasBoth => local != null && remote != null;
  T? getLatestItem(DateTime Function(T?) createdAt) {
    if (hasBoth) {
      return createdAt(local).isAfter(createdAt(remote)) ? local : remote;
    }
    return local ?? remote;
  }
}
