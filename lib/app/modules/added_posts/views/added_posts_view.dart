import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../../widgets/round_button.dart';
import '../controllers/added_posts_controller.dart';

class AddedPostsView extends GetView<AddedPostsController> {
  const AddedPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isloading = false.obs;
    final databaseref = FirebaseDatabase.instance.ref('Post');
    final postcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('AddingPosts'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: postcontroller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What is in your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50),
            Obx(
              () =>
                  isloading.value
                      ? CircularProgressIndicator()
                      : RoundButton(
                        title: 'Add',
                        onTap: () {
                          isloading.value = true;
                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          databaseref
                              .child(id)
                              .set({
                                'title': postcontroller.text.toString(),
                                'id': id,
                              })
                              .then((value) {
                                isloading.value = false;
                                utils().toastMessage(
                                  "Post added successfully ! ",
                                );
                              })
                              .onError((error, stackTrace) {
                                isloading.value = false;
                                utils().toastMessage(error.toString());
                              });
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

}
