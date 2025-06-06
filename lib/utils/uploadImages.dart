import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImage(File imageFile, String storagePath) async {
  try {
    // ✅ Ensure file exists
    if (!imageFile.existsSync()) {
      print("⚠️ Error: File does not exist at ${imageFile.path}");
      return null;
    }

    // 🔼 Upload to Firebase Storage
    final ref = FirebaseStorage.instance
        .ref()
        .child("$storagePath/${DateTime.now().microsecondsSinceEpoch}");
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;

    // ✅ Return download URL
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print("❌ Error uploading image: $e");
    return null;
  }
}
