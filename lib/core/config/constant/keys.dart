import 'package:flutter/material.dart';

const streamKey = 'zcu6jhmsqn2m';

class Keys {
  static Key postsStreamKey = Key(DateTime.now().toString());

  static genratePostsStreamKey() {
    postsStreamKey = Key(DateTime.now().toString() + DateTime.now().microsecond.toString());
  }
}
