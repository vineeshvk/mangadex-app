import '../../models/common/relationship_model.dart';
import '../constants/manga_constants.dart';

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension GetRelationWithType<E> on Iterable<RelationshipModel>? {
  RelationshipModel? getRelation(MangaRelationshipTypes type) {
    if (this == null) return null;

    for (final element in this!) {
      if (element.type == type) return element;
    }
  }
}

extension CheckBoxLogic<T> on List<T>? {
  List<T>? checkBox(T value) {
    List<T>? list = this ?? [];

    if (list.contains(value)) {
      list.remove(value);
    } else {
      list.add(value);
    }

    if (list.isEmpty) list = null;

    return list;
  }
}
