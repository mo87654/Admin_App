import 'package:flutter/material.dart';

import '../add buses data screen/adminBuses.dart';
import '../add drivers data screen/adminDrivers.dart';
import '../add students data screen/adminStudents.dart';

class Search extends SearchDelegate{
  Search({
    required this.data,
    required this.pageNum,
  });
  final List <String> data;
  final int pageNum;
  List<Widget> pages = [
    AdminStudentsData(),
    AdminDriversData(),
    AdminBusesData(),
  ];

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
    return null!;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List searchResult = data.where((element) =>
        element.contains(query)
    ).toList();
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>pages[pageNum]
            )
        );
      },
      child: ListView.builder(
          itemCount: query==''?data.length:searchResult.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(
                query=='' ? data[index]:searchResult[index],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            );
          }
      ),
    );
  }

}