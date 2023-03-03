import 'package:admin_app/modules/my%20account%20screen/My_account.dart';
import 'package:flutter/material.dart';
import '../../../shared/component/colors.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Create a text controller to handle the text input
  final TextEditingController _searchController = TextEditingController();

  // Create a list to store the search results
  List<String> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color(),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(
              Icons.arrow_back,
            )
        ),
        title: Text(
            "Students"
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>MyAccount()
                )
            );
          },
              icon: Icon(
                Icons.account_circle,
                size: 40,
              )
          ),
          Text('    ')
        ],
      ),
      body: Column(
        children: <Widget>[
          // Create a text field for the search input
          Container(
            margin: EdgeInsetsDirectional.only(
              start: 15,
              end: 15,
              top: 10,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search ...",
                contentPadding: EdgeInsetsDirectional.only(
                  start: 10,
                ),
                suffixIcon: Icon(
                  Icons.search,
                )
              ),
              onChanged: (text) {
                // Call the search function when the text changes
                _search(text);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              // Use the search results as the data source for the ListView
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _search(String text) async {
    // Clear the previous search results
    _searchResults.clear();

    // Add logic here to search your data source and add the results to the _searchResults list
    // Here is a simple example that searches a hard-coded list of items
    var data = ['item1', 'item2', 'item3'];
    for (var item in data) {
      if (item.contains(text)) {
        _searchResults.add(item);
      }
    }

    // Notify the framework that the state of the app has changed
    setState(() {});
  }
}
