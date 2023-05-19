import 'package:audioplayers/audioplayers.dart';
import 'package:ebsar/core/constants/app_string.dart';
import 'package:ebsar/features/home/data/models/book_model.dart';
import 'package:ebsar/features/home/data/models/category_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'command_state.dart';

class CommandCubit extends Cubit<CommandState> {
  CommandCubit() : super(CommandInitial());

  static CommandCubit get(context) => BlocProvider.of(context);

  SpeechToText speechToText = SpeechToText();
  AudioPlayer audioPlayer = AudioPlayer();
  var text = AppString.listen;
  bool isSearch = false;
  List<BookModel> books = [];
  List<CategoryModel> categories = [];
  BookModel? book;

  Future<List<BookModel>?> getBooks() async {
    emit(CommandBookLoading());
    try {
      Uri url = Uri.parse('https://ebsar.website/api/books');
      http.Response response = await http.get(url);
      var data = jsonDecode(response.body);
      data['data'].forEach((element) {
        books.add(BookModel.fromJson(element));
      });
      emit(CommandBookLoaded());

      print(
          '${books[0].name}-------------------------------------------------------------------');
      return books;
    } catch (error) {
      print('the $error');
    }
    return null;
  }

  void welcome() {
    emit(WelcomeStartState());
    audioPlayer.play(AssetSource('voices/welcome.mp3'));
    emit(WelcomeEndState());
  }

  FlutterTts tts = FlutterTts();

  Future<List<CategoryModel>?> getCategories() async {
    emit(CategoryLoadingState());
    categories = [];
    try {
      Uri url = Uri.parse('https://ebsar.website/api/categories');
      http.Response response = await http.get(url);
      var data = jsonDecode(response.body);
      data['data'].forEach((element) {
        categories.add(CategoryModel.fromJson(element));
      });
      print('the length of categories is ${categories.length}');
      emit(CategoryLoadedState());
      //print('${categories[0].name}-------------------------------------------------------------------');
      return categories;
    } catch (error) {
      //print('the $error');
      emit(CategoryErrorState(message: error.toString()));
    }
    return null;
  }

  Future<void> playCategoryVoice() async {
    emit(CategoryVoiceLoadingState());
    audioPlayer.play(AssetSource('voices/first.mp3'));
    Future.delayed(const Duration(seconds: 3));
    print(categories.length);
    for (int i = 0; i < categories.length; i++) {
      audioPlayer.play(UrlSource('${categories[i].categoryVoice}'));
      await Future.delayed(Duration(seconds: 3));
    }
    emit(CategoryVoiceLoadedState());
  }

  void listen() async {
    emit(CommandLoading());
    isSearch = true;
    audioPlayer.stop();
    var available = await speechToText.initialize();
    if (available) {
      isSearch = true;
      speechToText.listen(
        onResult: (result) {
          text = result.recognizedWords;
          if (text.isEmpty) {
            print("no book found");
          } else {
            print(text);
            searchOnBookList(text);
          }
          print(text);
          emit(CommandLoaded());
        },
        listenMode: ListenMode.search,
        localeId: 'ar_EG',
      );
    }
    emit(CommandLoaded());
  }

  Future<void> searchOnBookList(String text) async {
    // emit(CommandSearchLoading());
    // book = null;
    // book = books.firstWhere((element) => element.name!.contains(text));
    // print(book!.name);
    // emit(CommandSearchLoaded());

    try {
      emit(CommandSearchLoading());
      book = null;
      book = books.firstWhere((element) => element.name!.contains(text));
      print(book!.name);
      if (book!.name!.contains(text)) {
        emit(CommandSearchLoaded());
        play();
      } else {
        emit(CommandSearchError(message: 'لا يوجد كتاب بهذا الاسم'));
      }
      emit(CommandSearchLoaded());
    } catch (e) {
      print(e);
      emit(CommandSearchError(message: 'لا يوجد كتاب بهذا الاسم'));
    }
  }

  void play() {
    print('the book is ${book!.file!.bookFile}');
    if (text.isEmpty) {
      print('no book found');
    } else {
      audioPlayer.play(UrlSource('${book!.file!.bookFile}'));
    }
  }

  Future playTTS() async {
    try {
      await tts.setLanguage('ar-EG');
      await tts.setSpeechRate(0.5);
      await tts.setPitch(1.0);
      await tts.setVolume(1.0);
      await tts.speak('مرحبا بك في مكتبة إبصار');
      await tts.awaitSpeakCompletion(true);
      play();

    } catch (e) {
      print(e);
    }
  }

  void stop() {
    isSearch = false;
    speechToText.stop();
    //searchOnBookList(text);
    emit(CommandStopToSearch());
  }

  Future<void> speechError({required String error}) async {
    await tts.setLanguage('ar-EG');
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1.0);
    await tts.setVolume(1.0);
    await tts.speak(error);
    await tts.awaitSpeakCompletion(true);
  }

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   audioPlayer.dispose();
    // });
    audioPlayer.onPlayerStateChanged.listen((event) {
      isPlaying = event == PlayerState.playing;
    });
    audioPlayer.onDurationChanged.listen((event) {
      duration = event;
    });
    audioPlayer.onPositionChanged.listen((event) {
      position = event;
    });
  }

  void dispose() async {
    text = 'ابحث مرة اخرى';
    audioPlayer.stop();
    audioPlayer.dispose();
    await tts.stop();
    duration = Duration.zero;
    position = Duration.zero;
    isSearch = false;
    emit(CommandStop());
  }
}
