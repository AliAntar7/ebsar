import 'package:equatable/equatable.dart';

//{
//       "id": 2,
//       "name": "تاريخ",
//       "category_voice": "https://ebsar.website/public/uploads/category_voices/welcome.mp3"
// },
class CategoryModel extends Equatable{
  int? id;
  String? name;
  String? categoryVoice;

  CategoryModel({
    this.id,
    this.name,
    this.categoryVoice,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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