import 'package:cloud_firestore/cloud_firestore.dart';
import '../../app/user_type_cubit/user_type_cubit.dart';
import '../models/product.dart';

class FireStoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void storeUserByType(String type, String uid) async {
    try {
      await _firestore.collection(type).doc(uid).set({"type": type});
    } catch (er) {
      print(er);
    }
  }

  void createProduct(
      {required String uid,
      required String brand,
      required String productName,
      required double price,
      required String category}) async {
    // TODO : check if the user is a seller or not
    try {
      final responseData = await _firestore.collection('Products').add({
        "uid": uid,
        "productName": productName,
        "brand": brand,
        "price": price,
        "category": category,
      });
      print("DATA GOT INSERTED" + responseData.id);
    } catch (er) {
      print("<><>createProductsExceptionThrow<><> " + er.toString());
    }
  }

  // void createCategory(String categoryName) async {
  //   try {
  //     _firestore.collection('Categories').add({"category": categoryName});
  //   } catch (er) {
  //     print(er);
  //   }
  // }
}
