import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ValueNotifier(options[OptionType.vanilla]),
          ),
          Provider<AuthService>(
            create: (context) => MockAuthService(),
            dispose: (context, service) => service.dispose(),
          ),
        ],
        child: const MaterialApp(
          home: AuthFacadePage(),
        ),
      );
}

class AuthFacadePage extends StatelessWidget {
  const AuthFacadePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<AuthService>(context);

    return StreamBuilder(
      stream: service.onStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == null) {
          return OptionPage.create();
        }

        return const HomePage();
      },
    );
  }
}

class OptionPage extends StatelessWidget {
  const OptionPage({
    Key key,
    @required this.option,
  })  : assert(option != null),
        super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => ValueNotifier(options[OptionType.vanilla]),
        child: Consumer<ValueNotifier<Option>>(
          builder: (context, option, child) => OptionPage(option: option.value),
        ),
      );

  final Option option;

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (option.type) {
      case OptionType.vanilla:
        body = const SignInPageOfVanilla();
        break;
      case OptionType.setState:
        body = const SignInPageOfSetState();
        break;
      case OptionType.bloc:
        body = SignInPageOfBloc.create();
        break;
      case OptionType.valueNotifier:
        body = SignInPageOfValueNotifier.create();
        break;
      default:
        body = Container();
    }

    return Page(
      title: option.title,
      body: body,
    );
  }
}

class SignInPageOfVanilla extends StatelessWidget {
  const SignInPageOfVanilla({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: SignInButton(onPressed: () => _signIn(context)),
      );

  Future<void> _signIn(BuildContext context) async {
    try {
      final service = Provider.of<AuthService>(context, listen: false);
      await service.signIn();
    } on AuthServiceException catch (e) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

class SignInPageOfSetState extends StatefulWidget {
  const SignInPageOfSetState({Key key}) : super(key: key);

  @override
  _SignInPageOfSetStateState createState() => _SignInPageOfSetStateState();
}

class _SignInPageOfSetStateState extends State<SignInPageOfSetState> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) => Center(
        child: SignInButton(
          loading: _isLoading,
          onPressed: _isLoading ? null : () => _signIn(context),
        ),
      );

  Future<void> _signIn(BuildContext context) async {
    setState(() => _isLoading = true);
    try {
      final service = Provider.of<AuthService>(context, listen: false);
      await service.signIn();
    } on AuthServiceException catch (e) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

class SignInPageOfBloc extends StatelessWidget {
  const SignInPageOfBloc._({
    Key key,
    @required this.bloc,
  })  : assert(bloc != null),
        super(key: key);

  static Widget create() => Provider<SignInPageBloc>(
        create: (context) => SignInPageBloc(),
        dispose: (context, bloc) => bloc.dispose(),
        child: Consumer<SignInPageBloc>(
          builder: (context, bloc, child) => SignInPageOfBloc._(bloc: bloc),
        ),
      );

  final SignInPageBloc bloc;

  @override
  Widget build(BuildContext context) => Center(
        child: StreamBuilder<bool>(
          stream: bloc.isLoading,
          initialData: false,
          builder: (context, snapshot) {
            final isLoading = snapshot.data;

            return SignInButton(
              loading: isLoading,
              onPressed: isLoading ? null : () => _signIn(context),
            );
          },
        ),
      );

  Future<void> _signIn(BuildContext context) async {
    try {
      bloc.loading.add(true);
      final service = Provider.of<AuthService>(context, listen: false);
      await service.signIn();
    } on AuthServiceException catch (e) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      bloc.loading.add(false);
    }
  }
}

class SignInPageBloc {
  Stream<bool> get isLoading => _loadingController.stream;
  Sink<bool> get loading => _loadingController.sink;

  final _loadingController = StreamController<bool>();

  void dispose() => _loadingController.close();
}

class SignInPageOfValueNotifier extends StatelessWidget {
  const SignInPageOfValueNotifier._({
    Key key,
    @required this.loading,
  })  : assert(loading != null),
        super(key: key);

  static Widget create() => ChangeNotifierProvider<ValueNotifier<bool>>(
        create: (context) => ValueNotifier(false),
        child: Consumer<ValueNotifier<bool>>(
          builder: (context, loading, child) => SignInPageOfValueNotifier._(
            loading: loading,
          ),
        ),
      );

  final ValueNotifier<bool> loading;

  @override
  Widget build(BuildContext context) => Center(
        child: SignInButton(
          loading: loading.value,
          onPressed: loading.value ? null : () => _signIn(context),
        ),
      );

  Future<void> _signIn(BuildContext context) async {
    try {
      loading.value = true;
      final service = Provider.of<AuthService>(context, listen: false);
      await service.signIn();
    } on AuthServiceException catch (e) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      loading.value = false;
    }
  }
}

class Page extends StatelessWidget {
  const Page({
    Key key,
    @required this.title,
    @required this.body,
  })  : assert(title != null),
        assert(body != null),
        super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        drawer: const Drawer(
          child: SafeArea(child: OptionMenu(options: options)),
        ),
        body: SafeArea(child: body),
      );
}

class OptionMenu extends StatelessWidget {
  const OptionMenu({
    Key key,
    this.options,
  }) : super(key: key);

  final Map<OptionType, Option> options;

  @override
  Widget build(BuildContext context) => ListView(
        children: options.values
            .map((option) => OptionMenuTile(option: option))
            .toList(),
      );
}

class OptionMenuTile extends StatelessWidget {
  const OptionMenuTile({
    Key key,
    @required this.option,
  })  : assert(option != null),
        super(key: key);

  final Option option;

  @override
  Widget build(BuildContext context) => Consumer<ValueNotifier<Option>>(
        builder: (context, selected, child) {
          final isSelected = option.type == selected.value.type;

          return ListTile(
            leading: Icon(option.iconData),
            title: Text(option.title),
            trailing: isSelected ? const Icon(Icons.check) : null,
            onTap: () {
              if (!isSelected) {
                selected.value = option;
              }

              Navigator.pop(context);
            },
          );
        },
      );
}

const Map<OptionType, Option> options = {
  OptionType.vanilla: Option(
    type: OptionType.vanilla,
    iconData: Icons.check_box_outline_blank,
    title: 'vanilla',
  ),
  OptionType.setState: Option(
    type: OptionType.setState,
    iconData: Icons.adjust,
    title: 'setState',
  ),
  OptionType.bloc: Option(
    type: OptionType.bloc,
    iconData: Icons.block,
    title: 'BLoC',
  ),
  OptionType.valueNotifier: Option(
    type: OptionType.valueNotifier,
    iconData: Icons.notifications_none,
    title: 'ValueNotifier',
  ),
};

enum OptionType { vanilla, setState, bloc, valueNotifier }

class Option {
  const Option({
    @required this.type,
    @required this.iconData,
    @required this.title,
  });

  final OptionType type;
  final IconData iconData;
  final String title;
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key key,
    this.loading = false,
    this.onPressed,
  }) : super(key: key);

  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: onPressed ?? () {},
        color: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.onPrimary,
        child: loading ? const Text('...') : const Text('Sign In'),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => _signOut(context),
            )
          ],
        ),
      );

  Future<void> _signOut(BuildContext context) async {
    try {
      final service = Provider.of<AuthService>(context, listen: false);
      await service.signOut();
    } on AuthServiceException catch (e) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

class MockAuthService implements AuthService {
  MockAuthService({this.delay = const Duration(seconds: 2)}) {
    _add(null);
  }

  final StreamController<User> _stateStreamController = StreamController();

  final Duration delay;
  final Random _random = Random();

  @override
  Stream<User> get onStateChanged => _stateStreamController.stream;

  @override
  Future<User> signIn() async {
    await Future.delayed(delay);
    if (_random.nextBool()) {
      throw AuthServiceException();
    }

    final user = User(id: '${_random.nextInt(1000)}');
    _add(user);

    return user;
  }

  @override
  Future<void> signOut() async => _add(null);

  void _add(User user) => _stateStreamController.add(user);

  @override
  void dispose() => _stateStreamController.close();
}

abstract class AuthService {
  Stream<User> get onStateChanged;
  Future<User> signIn();
  Future<void> signOut();
  void dispose();
}

class AuthServiceException implements Exception {}

class User {
  const User({@required this.id}) : assert(id != null);

  final String id;
}
