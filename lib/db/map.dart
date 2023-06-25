import 'package:objectbox/objectbox.dart';

@Entity()
class CityEntity {
  @Id(assignable: true)
  int id = 0;

  String name = "";

  String state = "";
  String country = "";
  double lat = 0.0;
  double lon = 0.0;

}
