abstract class HomeEvent {}

final class GetDataHomeEvent extends HomeEvent {}
final class SearchPostsEvent extends HomeEvent {
  final String title;
  SearchPostsEvent({required this.title});

}
