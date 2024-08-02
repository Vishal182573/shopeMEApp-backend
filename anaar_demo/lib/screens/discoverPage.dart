import 'package:anaar_demo/providers/catelogProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:anaar_demo/model/catelogMode.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final catelogProvider = Provider.of<CatelogProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Catalog'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _isSearching = true;
                  });
                  catelogProvider.searchCatalog(value).then((_) {
                    setState(() {
                      _isSearching = false;
                    });
                  });
                } else {
                  setState(() {
                    _isSearching = false;
                  });
                  catelogProvider.searchResults.clear();
                }
              },
              decoration: InputDecoration(
                hintText: 'Search for products...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: _isSearching
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: catelogProvider.searchResults.length,
              itemBuilder: (context, index) {
                final catalog = catelogProvider.searchResults[index];
                return Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.network(catalog.images.isNotEmpty
                            ? catalog.images[0]??''
                            : ''),
                      ),
                      Text(catalog.productName ?? 'No Name'),
                      Text(catalog.description ?? 'No Description'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
