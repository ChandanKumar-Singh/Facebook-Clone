import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/post_model.dart';
import 'package:flutter_facebook_responsive_ui/widgets/circle_button.dart';
import 'package:flutter_facebook_responsive_ui/widgets/contact_list.dart';
import 'package:flutter_facebook_responsive_ui/widgets/create_post_container.dart';
import 'package:flutter_facebook_responsive_ui/widgets/more_options_list.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_container.dart';
import 'package:flutter_facebook_responsive_ui/widgets/responsive.dart';
import 'package:flutter_facebook_responsive_ui/widgets/rooms.dart';
import 'package:flutter_facebook_responsive_ui/widgets/stories.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();


  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
              _HomeScreenMobile(scrollController: _trackingScrollController),
          tablet:
              _HomeScreenMobile(scrollController: _trackingScrollController),
          desktop:
              _HomeScreenDesktop(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  _HomeScreenMobile({Key? key, required this.scrollController})
      : super(key: key);

  final TrackingScrollController scrollController;
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        // Responsive.isDesktop(context) ?null:
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: const Text(
            'facebook',
            style: TextStyle(
              color: Palette.facebookBlue,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          floating: true,
          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30,
              onPressed: () {},
            ),
            const SizedBox(
              width: 10,
            ),
            CircleButton(
              icon: MdiIcons.facebookMessenger,
              iconSize: 30,
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: CreatePostContainer(currentUser: currentUser),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 5),
          sliver: SliverToBoxAdapter(
            child: Rooms(onlineUsers: onlineUsers),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 5),
          sliver: SliverToBoxAdapter(
            child: Stories(
              currentUser: currentUser,
              stories: stories,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Post post = posts[index];
              return PostContainer(
                post: post,
              );
            },
            childCount: posts.length,
          ),
        )
      ],
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  const _HomeScreenDesktop({Key? key, required this.scrollController})
      : super(key: key);
  final TrackingScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: MoreOptionsList(
                  currentUser: currentUser,
                ),
              ),
            )),
        SizedBox(
          width: 600,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 20, 0, 10),
                sliver: SliverToBoxAdapter(
                  child: Stories(
                    currentUser: currentUser,
                    stories: stories,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CreatePostContainer(currentUser: currentUser),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 5),
                sliver: SliverToBoxAdapter(
                  child: Rooms(onlineUsers: onlineUsers),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final Post post = posts[index];
                    return PostContainer(
                      post: post,
                    );
                  },
                  childCount: posts.length,
                ),
              )
            ],
          ),
        ),
        const Spacer(),
        Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ContactList(
                  users: onlineUsers,
                  scrollController: scrollController,
                ),
              ),
            )),
      ],
    );
  }
}
