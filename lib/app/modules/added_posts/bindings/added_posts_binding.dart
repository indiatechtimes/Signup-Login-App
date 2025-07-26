import 'package:get/get.dart';

import '../controllers/added_posts_controller.dart';

class AddedPostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddedPostsController>(
      () => AddedPostsController(),
    );
  }
}
