import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mono_kit/utils/logger.dart';

Future<List<DocumentReference>> deleteAllDocuments({
  required Query query,
  int batchSize = 500,
}) async {
  return _deleteQueryBatch(
    query: query.orderBy(FieldPath.documentId).limit(batchSize),
    batchSize: batchSize,
    deletedRefs: [],
  );
}

Future<List<DocumentReference>> _deleteQueryBatch({
  required Query query,
  required int batchSize,
  required List<DocumentReference> deletedRefs,
}) async {
  final snapshots = await query.get();
  final docs = snapshots.docs;
  if (docs.isEmpty) {
    return deletedRefs;
  }

  await runBatchWrite<void>((batch) {
    for (final doc in docs) {
      batch.delete(doc.reference);
    }
    return Future.value();
  });

  logger.fine('deleted count: ${docs.length}');

  return _deleteQueryBatch(
    query: query,
    batchSize: batchSize,
    deletedRefs: [
      ...deletedRefs,
      ...docs.map((d) => d.reference),
    ],
  );
}

Future<T> runBatchWrite<T>(Future<T> Function(WriteBatch batch) f) async {
  final batch = FirebaseFirestore.instance.batch();
  final result = await f(batch);
  await batch.commit();
  return result;
}
