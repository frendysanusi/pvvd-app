import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile {
  Profile._(
      this.email,
      this.firstname,
      this.nickname,
      this.birthdate,
      this.phone,
      this.school,
      this.educationlevel,
      this.major,
      this.bloodtype,
      this.domicile,
      this.subdistrict,
      this.district,
      this.province,
      this.role);

  static Profile? _profileInstance;

  factory Profile(
      String email,
      String firstname,
      String nickname,
      String birthdate,
      String phone,
      String school,
      String educationlevel,
      String major,
      String bloodtype,
      String domicile,
      String subdistrict,
      String district,
      String province,
      String role) {
    _profileInstance = Profile._(
      email,
      firstname,
      nickname,
      birthdate,
      phone,
      school,
      educationlevel,
      major,
      bloodtype,
      domicile,
      subdistrict,
      district,
      province,
      role,
    );
    return _profileInstance!;
  }

  final String email;
  final String firstname;
  final String nickname;
  final String birthdate; // will be changed to date
  final String phone;
  final String school;
  final String educationlevel;
  final String major;
  final String bloodtype;
  final String domicile;
  final String subdistrict;
  final String district;
  final String province;
  final String role;

  static Future<void> getProfile() async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference profileQuery =
        FirebaseFirestore.instance.collection("users");
    final QuerySnapshot profileSnapshot =
        await profileQuery.where('id', isEqualTo: userId).limit(1).get();
    final QueryDocumentSnapshot profileDocument = profileSnapshot.docs.first;
    final data = profileDocument.data() as Map<String, dynamic>;
    Profile(
      FirebaseAuth.instance.currentUser!.email as String,
      data['firstname'] as String,
      data['nickname'] as String,
      data['birthdate'] as String,
      data['phone'] as String,
      data['school'] as String,
      data['educationlevel'] as String,
      data['major'] as String,
      data['bloodtype'] as String,
      data['domicile'] as String,
      data['subdistrict'] as String,
      data['district'] as String,
      data['province'] as String,
      data['role'] as String,
    );
  }

  static Profile? get instance => _profileInstance;
}
