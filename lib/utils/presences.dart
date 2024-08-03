import 'package:cloud_firestore/cloud_firestore.dart';

class Presences {
  Presences._(this.presenceId, this.date, this.userId, this.serviceId);

  static List<Presences>? _presenceInstances;

  factory Presences(
      String presenceId, DateTime date, String userId, String serviceId) {
    _presenceInstances ??= [];
    Presences newPresence = Presences._(presenceId, date, userId, serviceId);
    return newPresence;
  }

  final String presenceId;
  final DateTime date;
  final String userId;
  final String serviceId;

  static Future<void> getPresencesByUserId(String userId) async {
    _presenceInstances = [];

    final CollectionReference presenceQuery =
        FirebaseFirestore.instance.collection('presences');
    final QuerySnapshot presenceSnapshot =
        await presenceQuery.where('user_id', isEqualTo: userId).get();
    final List<QueryDocumentSnapshot> presenceDocuments = presenceSnapshot.docs;

    for (QueryDocumentSnapshot presenceDocument in presenceDocuments) {
      final data = presenceDocument.data() as Map<String, dynamic>;
      _presenceInstances!.add(Presences(
        presenceDocument.id,
        (data['date'] as Timestamp).toDate(),
        data['user_id'] as String,
        data['service_id'] as String,
      ));
    }
  }

  static List<Presences>? get instances => _presenceInstances;
}
