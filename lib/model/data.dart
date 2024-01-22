import 'package:hive/hive.dart';
part 'data.g.dart';

@HiveType(typeId: 0)
class Model extends HiveObject{

  @HiveField(0)
  // ID for each kagga - Have MK for Mankutimmana Kagga & MM for Marula Muniya
  final String id;

  @HiveField(1)
  // The Kagga in Kannada
  final String kaggaKannada;

  @HiveField(2)
  // English Transliteration
  String? kaggaEnglish;

  @HiveField(3)
  // Kannada Meaning of the Kagga
  String? meaningKannada;

  @HiveField(4)
  // English translation of the meaning
  String? meaningEnglish;

  @HiveField(5)
  String? vyakhyana;

  @HiveField(6)
  String? tatparya;

  Model(this.id, this.kaggaKannada);
}