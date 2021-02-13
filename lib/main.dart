import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list_app/bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: BlocProvider(
          create: (context) => PostBloc(httpClient: http.Client())
            ..add(
              PostFetched(),
            ),
          child: HomePage(),
        ),
      ),
    );
  }
}
