import 'package:objectbox/objectbox.dart';

@Entity()
class Point {
  @Id()
  int id = 0;

  String image = ""; // название файла иконки, без пути. Пример: "1.png"
  String name = "";
  String description = "";

  double lat = 0.0;
  double lon = 0.0;

  bool hidden = false; // Отображать ли точку на карте
  int createTime = 0; // Unix timestamp в мс, когда точка была создана
}
