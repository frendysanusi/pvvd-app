import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  Services._(this.serviceId, this.date, this.leader, this.speaker, this.topic,
      this.translator);

  static List<Services>? _serviceInstances;

  factory Services(String serviceId, DateTime date, String leader,
      String speaker, String topic, String translator) {
    _serviceInstances ??= [];
    Services newService =
        Services._(serviceId, date, leader, speaker, topic, translator);
    return newService;
  }

  final String serviceId;
  final DateTime date;
  final String leader;
  final String speaker;
  final String topic;
  final String translator;

  static Future<void> getServices() async {
    _serviceInstances = [];

    final CollectionReference serviceQuery =
        FirebaseFirestore.instance.collection('services');
    final QuerySnapshot serviceSnapshot = await serviceQuery.get();
    final List<QueryDocumentSnapshot> serviceDocuments = serviceSnapshot.docs;

    for (QueryDocumentSnapshot serviceDocument in serviceDocuments) {
      final data = serviceDocument.data() as Map<String, dynamic>;
      _serviceInstances!.add(Services(
        serviceDocument.id,
        (data['date'] as Timestamp).toDate(),
        data['leader'] as String,
        data['speaker'] as String,
        data['topic'] as String,
        data['translator'] as String,
      ));
    }
  }

  static List<Services>? get instances => _serviceInstances;
}
