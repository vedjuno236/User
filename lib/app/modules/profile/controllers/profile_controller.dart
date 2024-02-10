import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  RxString imageUrl = ''.obs;

  Future<void> fetchImageUrl(String documentId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Passengers')
          .doc(documentId)
          .get();

      // print("doc image url:${documentSnapshot['name']}");

      // print("id card image:${documentSnapshot['id_card_image_url']}");

      print("doc image url:${documentSnapshot['profile_image_url']}");
      if (documentSnapshot.exists) {
        imageUrl.value = documentSnapshot['profile_image_url'];
      } else {
        imageUrl.value = '';
      }
      print('img val: ${imageUrl.value}');
    } catch (e) {
      print('Error fetching image URL: $e');
      imageUrl.value = '';
    }
  }
}
