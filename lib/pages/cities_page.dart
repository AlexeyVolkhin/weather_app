import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/db/city.dart';
import 'package:weather_app/models/db_model.dart';
import 'package:weather_app/models/http_model.dart';
import '../widgets/search_bar.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage ({super.key});

  @override
  Widget build(BuildContext context) {

    final model = context.watch<DataBaseModel>();
    final httpModel = context.watch<RequestModel>();

    List<dynamic> citiesData = model.citiesData;
    List<CityEntity> citiesListFromDB = model.citiesFromDB();

    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black.withOpacity(0.5)),
              onPressed: (){
                context.pop();
              },
              child: const Text('Назад')),
            TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black.withOpacity(0.5)),
                onPressed: (){
                  context.go('/citiesManager');
                },
                child: const Text('Добавить город')),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,

        body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
                ))),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
              child: Column(
                  children: [
                SearchField(model.searchString, (val) => model.search(val)),
                Expanded(
                  child: MasonryGridView.builder(
                      gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      cacheExtent: 1.0,
                      itemCount: citiesListFromDB.length,
                      addAutomaticKeepAlives: false,
                      itemBuilder: (context, index) {
                        var city = citiesListFromDB[index];
                        Widget widget = const Text('no data');
                        if (citiesData.length == citiesListFromDB.length){
                          widget = Wrap(
                            children: [
                              Text('${citiesData[index]['weather'][0]['main']},  ',
                                  style: const TextStyle(fontWeight: FontWeight.w700)),
                              Text('${citiesData[index]['main']['temp']} °C,  ',
                                  style: const TextStyle(fontWeight: FontWeight.w700)),
                              Text('${citiesData[index]['main']['pressure']} мм рт. ст',
                                  style: const TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          );
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 3),
                          child: ListTile(
                            onTap: (){
                              if (citiesData.isNotEmpty) {
                              httpModel.response = citiesData[index];
                              context.go('/fullInfo');}
                            },
                            trailing: IconButton(
                                onPressed: (){
                                  model.dbDelete(citiesListFromDB[index].id);
                                  model.citiesData.removeWhere((element) => element['id'] == citiesListFromDB[index].id);
                                },
                                icon: const Icon(Icons.cancel)),
                            title: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(city.name,
                                    style: const TextStyle(fontWeight: FontWeight.w700)),
                                widget,
                                Text(city.country,
                                    style: const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ]),
            ),
          ),
      ],
    ));
  }
}