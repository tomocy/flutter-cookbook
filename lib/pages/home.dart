import 'package:cookbook/blocs/video_fetcher_bloc.dart';
import 'package:cookbook/blocs/video_liker_bloc.dart';
import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/domain/resources/video_fetcher.dart';
import 'package:cookbook/domain/resources/video_liker.dart';
import 'package:cookbook/pages/widgets/action_button.dart';
import 'package:cookbook/pages/widgets/follow_button.dart';
import 'package:cookbook/pages/widgets/like_video_button.dart';
import 'package:cookbook/pages/widgets/tik_tok_button.dart';
import 'package:cookbook/pages/widgets/video_description.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<VideoFetcherBloc>(
            create: (_) => VideoFetcherBloc(Provider.of<VideoFetcher>(
              context,
              listen: false,
            )),
            dispose: (_, bloc) => bloc.dispose(),
          ),
          Provider<VideoLikerBloc>(
            create: (_) => VideoLikerBloc(Provider.of<VideoLiker>(
              context,
              listen: false,
            )),
            dispose: (_, bloc) => bloc.dispose(),
          ),
        ],
        child: Scaffold(
          body: Consumer<VideoFetcherBloc>(
            builder: (_, bloc, child) => StreamBuilder<Video>(
              stream: bloc.video,
              builder: (context, snapshot) {
                if (!snapshot.hasData && !snapshot.hasError) {
                  bloc.fetch.add('Video');
                  return child;
                }
                if (snapshot.hasError) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => Scaffold.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content: Text(snapshot.error.toString()),
                        )));
                  return child;
                }

                return _buildOverlaidImage(
                  context,
                  image: Image.asset(
                    snapshot.data.uri,
                    fit: BoxFit.cover,
                  ),
                  child: SafeArea(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: VideoDescription(
                                          color: _onSurfaceColor(context),
                                          video: snapshot.data,
                                        ),
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
                                      child: _buildSocialActionButtons(
                                        context,
                                        snapshot.data,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            child: Icon(
              Icons.more_horiz,
              color: _onSurfaceColor(context),
            ),
          ),
          extendBody: true,
          bottomNavigationBar: SizedBox(
            height: 80,
            child: _buildTabActionButtons(context),
          ),
        ),
      );

  Widget _buildOverlaidImage(
    BuildContext context, {
    @required Image image,
    Widget child,
  }) =>
      Stack(
        fit: StackFit.expand,
        children: [
          image,
          child,
        ],
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

  Widget _buildSocialActionButtons(BuildContext context, Video video) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FollowButton(onPressed: () {}),
          ActionButton(
            onPressed: () {},
            color: _onSurfaceColor(context),
            iconData: Icons.android,
            label: '3.2m',
          ),
          LikeVideoButton(
            color: _onSurfaceColor(context),
            video: video,
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
          TikTokButton(onPressed: () {}),
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
