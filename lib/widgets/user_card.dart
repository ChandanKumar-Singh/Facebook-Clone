import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/profile_avtar.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.user}) : super(key: key);
  final Users user;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print('User Profile Desktop'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(imageUrl: user.imageUrl),
          const SizedBox(
            width: 6,
          ),
          Flexible(
              child: Text(
            user.name,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          )),
        ],
      ),
    );
  }
}
