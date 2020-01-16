import 'package:cookbook/pages/widgets/action_button.dart';
import 'package:cookbook/pages/widgets/follow_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 100,
                child: _buildPreferenceActionButtons(context),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              child: _buildVideoDescription(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 400,
                            child: _buildSocialActionButtons(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                child: _buildTabActionButtons(context),
              ),
            ],
          ),
        ),
      );

  Widget _buildPreferenceActionButtons(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () {},
            child: Text(
              'Following',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          const SizedBox(width: 20),
          FlatButton(
            onPressed: () {},
            child: Text(
              'For you',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );

  Widget _buildVideoDescription(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '@tomocy',
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: _onSurfaceColor(context),
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            'Video title',
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: _onSurfaceColor(context),
                ),
          ),
          Text(
            'Song title',
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: _onSurfaceColor(context),
                ),
          ),
        ],
      );

  Widget _buildSocialActionButtons(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FollowButton(onPressed: () {}),
          ActionButton(
            onPressed: () {},
            color: _onSurfaceColor(context),
            iconData: Icons.android,
            label: '3.2m',
          ),
          ActionButton(
            onPressed: () {},
            color: _onSurfaceColor(context),
            iconData: Icons.thumb_up,
            label: '16.4k',
          ),
          ActionButton(
            onPressed: () {},
            color: _onSurfaceColor(context),
            iconData: Icons.share,
            label: 'Share',
          ),
        ],
      );

  Widget _buildTabActionButtons(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.home,
              color: _onSurfaceColor(context),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: _onSurfaceColor(context),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat),
            color: _onSurfaceColor(context),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_outline),
            color: _onSurfaceColor(context),
          ),
        ],
      );

  Color _onSurfaceColor(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;
}
