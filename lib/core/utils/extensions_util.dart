import 'package:mangadex/core/constants/manga_constants.dart';
import 'package:mangadex/models/common/relationship_model.dart';

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
