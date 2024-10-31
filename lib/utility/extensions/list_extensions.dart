
extension ListExtensions<E> on List<E> {
  
  E? get firstOrNull {
    return isEmpty ? null : first;
  }

   E? get lastOrNull {
    return isEmpty ? null : last;
  }
}