import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list_app/bloc/bloc.dart';

import 'bottom_loader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PostFailure) {
        return Center(
          child: Text('Failed to fetch posts'),
        );
      } else if (state is PostSuccess) {
        if (state.posts.isEmpty) {
          return Center(
            child: Text('No posts'),
          );
        }
        return ListView.builder(itemBuilder: (context, index) {
          return index >= state.posts.length
              ? BottomLoader()
              : PostWidget(post: state.posts[index]);
        });
      }
      return Center();
    });
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(PostFetched());
    }
  }
}
