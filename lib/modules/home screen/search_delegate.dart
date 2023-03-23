import 'package:flutter/material.dart';

import '../add buses data screen/adminBuses.dart';
import '../add drivers data screen/adminDrivers.dart';
import '../add students data screen/adminStudents.dart';

class Search extends SearchDelegate{
  Search({
    required this.mainData,
    required this.pageNum,
    this.subData,
  });
  final List mainData;
  final int pageNum;
  final List? subData;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (){
            query = '';
          },
          icon: Icon(
            Icons.close,
          )
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, null);
        },
        icon: Icon(
          Icons.arrow_back,
        )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List searchResult = mainData.where((element) =>
        element.contains(query)
    ).toList();
    return ListView.builder(
        itemCount: query==''?mainData.length:searchResult.length,
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              List<Widget> pages = [
                AdminStudentsData(name: query=='' ? mainData[index]:searchResult[index],),
                AdminDriversData(name: query=='' ? mainData[index]:searchResult[index],),
                AdminBusesData(id: query=='' ? mainData[index]:searchResult[index],),
              ];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>pages[pageNum],
                  )
              );
            },
            child: ListTile(
              title: Text(
                query=='' ? mainData[index]:searchResult[index],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              /*subtitle: Text(
                query==''? subData![index]:null,
                style: TextStyle(
                  fontSize: 18,
                ),
              )*/
            ),
          );
        }
    );
  }

}