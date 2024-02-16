import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/routes/routes.dart';
import 'package:lets_buy/features/auth/Providers/auth_state_provider.dart';
import 'package:lets_buy/features/posts/providers/posts_provider.dart';
import 'package:lets_buy/features/search/data_provider.dart';
import 'package:lets_buy/features/search/search_provider.dart';
import 'package:provider/provider.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class App extends StatelessWidget {
  // final StreamChatClient client;
  const App({
    Key? key,
    // required this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthSataProvider>(
          create: (_) => AuthSataProvider(),
        ),
        ChangeNotifierProvider<DataProvider>(
          create: (_) => DataProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider<UserInfoProvider>(
          create: (_) => UserInfoProvider(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        supportedLocales: const [
          Locale("ar", "AE"),
        ],
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: purple,
            scaffoldBackgroundColor: dark,
            appBarTheme: const AppBarTheme(backgroundColor: purple),
            // colorScheme: ColorScheme(background: dark)
            fontFamily: font),
        // builder: (context, child) {
        //   return StreamChat(
        //     streamChatThemeData: streamChatTheme,
        //     client: client,
        //     child: ChannelsBloc(
        //       child: UsersBloc(
        //         child: child!,
        //       ),
        //     ),
        //   );
        // },
        initialRoute: '/',
      ),
    );
  }
}
