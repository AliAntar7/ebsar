import 'package:equatable/equatable.dart';
//{
//       "id": 2,
//       "name": "كتاب قوة العادات",
//       "category": {
//         "id": 6,
//         "name": "تنمية بشرية",
//         "category_voice": "https://ebsar.website/public/uploads/category_voices/tnmi.mp3"
//       },
//       "Image": {
//         "id": 5,
//         "name": "qwt_eladatt",
//         "book_image": "https://ebsar.website/public/uploads/books_images/qwt_eladatt.jpg"
//       },
//       "File": {
//         "id": 7,
//         "name": "qwt_eladatt",
//         "book_file": "https://ebsar.website/public/uploads/books_files/qwt_eladatt.mp3"
//       },
//       "Voice": {
//         "id": 2,
//         "name": "qwt_eladatt",
//         "book_voice": "https://ebsar.website/public/uploads/books_voices/qwt_eladatt.mp3"
//       }
//     },
class BookModel extends Equatable {
  int? id;
  String? name;
  Category? category;
  Image? image;
  File? file;
  Voice? voice;

  BookModel({
    this.id,
    this.name,
    this.category,
    this.image,
    this.file,
    this.voice,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    id: json["id"],
    name: json["name"],
    category: Category.fromJson(json["category"]),
    image: Image.fromJson(json["Image"]),
    file: File.fromJson(json["File"]),
    voice: Voice.fromJson(json["Voice"]),
  );


  @override
  List<Object?> get props => [
    id,
    name,
    category,
    image,
    file,
    voice,
  ];


}

class Category extends Equatable {
  int? id;
  String? name;
  String? categoryVoice;

  Category({
    this.id,
    this.name,
    this.categoryVoice,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    categoryVoice: json["category_voice"],
  );


  @override

  List<Object?> get props => [
    id,
    name,
    categoryVoice,
  ];
}

class Image extends Equatable {
  int? id;
  String? name;
  String? bookImage;

  Image({
    this.id,
    this.name,
    this.bookImage,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    name: json["name"],
    bookImage: json["book_image"],
  );


  @override

  List<Object?> get props => [
    id,
    name,
    bookImage,
  ];
}

class File extends Equatable {
  int? id;
  String? name;
  String? bookFile;

  File({
    this.id,
    this.name,
    this.bookFile,
  });

  factory File.fromJson(Map<String, dynamic> json) => File(
    id: json["id"],
    name: json["name"],
    bookFile: json["book_file"],
  );


  @override

  List<Object?> get props => [
    id,
    name,
    bookFile,
  ];

}

class Voice extends Equatable {
  int? id;
  String? name;
  String? bookVoice;

  Voice({
    this.id,
    this.name,
    this.bookVoice,
  });

  factory Voice.fromJson(Map<String, dynamic> json) => Voice(
    id: json["id"],
    name: json["name"],
    bookVoice: json["book_voice"],
  );


  @override


  List<Object?> get props => [
    id,
    name,
    bookVoice,
  ];

}
