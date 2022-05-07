part of 'search_history_cubit.dart';

@immutable
abstract class SearchHistoryState {}

class SearchHistoryInitial extends SearchHistoryState {}

class SearchHistoryCreatedatabaseState extends SearchHistoryState {}

class SearchHistoryInsertdatabaseState extends SearchHistoryState {}

class SearchHistoryDeletedatabaseState extends SearchHistoryState {}

class SearchHistoryGetdatabaseState extends SearchHistoryState {}

class SearchHistoryLoadingDatafromDatabase extends SearchHistoryState {}

class SearchHistoryDeleteTablecontentDatabase extends SearchHistoryState {}
