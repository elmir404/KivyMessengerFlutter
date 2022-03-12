import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiwi/model/user.dart';
import 'package:kiwi/services/database_base.dart';

class FireStoreDbService implements DbBase{
  final  FirebaseFirestore _firestore =FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(MyUser user) async {

    DocumentSnapshot _okunanUser =
    await FirebaseFirestore.instance.doc("users/${user.userID}").get();

    if (_okunanUser.data == null) {
      await _firestore
          .collection("users")
          .doc(user.userID)
          .set(user.toMap());
      return true;
    } else {
      return true;
    }
  }

  @override
  Future<MyUser> readUser(String userID)async {
    DocumentSnapshot _readUser =await _firestore.collection("users").doc(userID).get();
    Map<String,dynamic>_readUserInfoMap =_readUser.data();
    MyUser _oxunanUserNesne= MyUser.fromMap(_readUserInfoMap);
    print("Oxunan user nesnesi:"+ _oxunanUserNesne.toString());
    return _oxunanUserNesne;
  }
  
}