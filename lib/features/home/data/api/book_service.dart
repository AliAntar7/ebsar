import 'dart:convert';
import 'package:ebsar/features/home/data/models/book_model.dart';
import 'package:http/http.dart' as http;


class BookService {
  List<BookModel> books = [];

  Future<List<BookModel>> getBooks() async {
    try {
      Uri url = Uri.parse('https://absar01.000webhostapp.com/api/info');
      http.Response response = await http.get(url);
      print(response);
      List<dynamic> data = jsonDecode(response.body);
      for (var element in data) {
        books.add(BookModel.fromJson(element));
      }
      print(books);
    } catch (error) {
      print('the $error');
    }
    return books;
  }
}
