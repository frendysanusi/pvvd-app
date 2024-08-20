import 'package:cloud_firestore/cloud_firestore.dart';

class Announcements {
  Announcements._(this.announcementId, this.desc, this.title);

  static List<Announcements>? _announcementInstances;

  factory Announcements(String announcementId, String desc,
      String title) {
    _announcementInstances ??= [];
    Announcements newAnnouncement =
    Announcements._(announcementId, desc, title);
    return newAnnouncement;
  }

  final String announcementId;
  final String desc;
  final String title;

  static Future<void> getAnnouncements() async {
    _announcementInstances = [];

    final CollectionReference announcementQuery =
    FirebaseFirestore.instance.collection('announcements');
    final QuerySnapshot announcementSnapshot = await announcementQuery.get();
    final List<QueryDocumentSnapshot> announcementDocuments = announcementSnapshot.docs;

    for (QueryDocumentSnapshot announcementDocument in announcementDocuments) {
      final data = announcementDocument.data() as Map<String, dynamic>;

      _announcementInstances!.add(Announcements(
        announcementDocument.id,
        data['desc'] as String,
        data['title'] as String,
      ));
    }
  }

  static List<Announcements>? get instances => _announcementInstances;
}
