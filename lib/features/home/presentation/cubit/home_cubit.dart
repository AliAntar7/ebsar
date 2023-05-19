// import 'package:audioplayers/audioplayers.dart';
// import 'package:ebsar/features/home/data/models/book_model.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// part 'home_state.dart';
//
// class HomeCubit extends Cubit<HomeState> {
//   static HomeCubit get(context) => BlocProvider.of(context);
//   HomeCubit() : super(HomeInitial());
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   List<BookModel> books = [];
//   BookModel? book;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   String text = '';
//
//   void initState() {
//     Future.delayed(Duration.zero, () async {
//       audioPlayer.dispose();
//       book = books.firstWhere((element) => element.name == text);
//       await audioPlayer.play(UrlSource(book!.file!.bookFile!));
//     });
//     audioPlayer.onPlayerStateChanged.listen((event) {
//       isPlaying = event == PlayerState.playing;
//     });
//     audioPlayer.onDurationChanged.listen((event) {
//       duration = event;
//     });
//     audioPlayer.onPositionChanged.listen((event) {
//       position = event;
//     });
//   }
//
//
//   void dispose() {
//     audioPlayer.dispose();
//   }
// }
