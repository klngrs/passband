import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:harpy/core/api/network_error_handler.dart';
import 'package:harpy/core/api/request_lock_mixin.dart';
import 'package:harpy/core/api/twitter/handle_tweets.dart';
import 'package:harpy/core/api/twitter/tweet_data.dart';
import 'package:harpy/core/logger_mixin.dart';
import 'package:harpy/core/service_locator.dart';

part 'likes_timeline_event.dart';
part 'likes_timeline_state.dart';

class LikesTimelineBloc extends Bloc<LikesTimelineEvent, LikesTimelineState>
    with RequestLock {
  LikesTimelineBloc({
    @required this.screenName,
  }) : super(const LikesTimelineInitial()) {
    add(const RequestLikesTimeline());
  }

  final String screenName;

  final TweetService tweetService = app<TwitterApi>().tweetService;

  /// Completes when older tweets for the timeline have been requested using
  /// [RequestOlderLikesTimeline].
  Completer<void> requestOlderCompleter = Completer<void>();

  @override
  Stream<LikesTimelineState> mapEventToState(
    LikesTimelineEvent event,
  ) async* {
    yield* event.applyAsync(currentState: state, bloc: this);
  }
}