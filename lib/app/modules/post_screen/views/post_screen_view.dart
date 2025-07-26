import 'package:firebase1/app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_screen_controller.dart';

final editController = TextEditingController();
final ref = FirebaseDatabase.instance.ref('Post');

class PostScreenView extends GetView<PostScreenController> {
  const PostScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchfilter = TextEditingController();

    final isLoading = false.obs;
    final auth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref('Post');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: Colors.purple,
        title: const Text('Post'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth
                  .signOut()
                  .then((value) {
                    Get.toNamed('/login-screen');
                  })
                  .onError((error, stackTrack) {
                    utils().toString();
                  });
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchfilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                final id=snapshot.child('id').value.toString();
                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.edit),
                              title: Text("Edit"),
                              onTap: (){
                                Get.back();
                                showMyDialog(title,id);
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.delete),
                              title: Text("Delete"),
                              onTap: (){
                                Get.back();
                                ref.child(id).remove();
                              },
                            ),
                          ),
                        ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/added-posts');
        },
        child: Icon(Icons.add_circle_outlined),
      ),
    );
  }

  Future<void> showMyDialog(String title,String id) async {
    editController.text = title;
    Get.defaultDialog(
      title: "Edit",
      content: TextField(
        controller: editController,
        decoration: InputDecoration(
          hintText: "edit",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
        ),
      ),
      actions: [
        // Add your action buttons here, e.g.:
        TextButton(onPressed: () => Get.back(), child: Text("Close")),
        SizedBox(width: 50),
        TextButton(
          child: Text("Save"),
          onPressed: (){
            Get.back();
            ref.child(id).update({
              'title':editController.text.toString(),
            }).then((value){
              utils().toastMessage("Post updated");
            }).onError((error,stackTrace){
              utils().toastMessage(error.toString());
            });
          },
        ),
      ],
    );
  }
}
