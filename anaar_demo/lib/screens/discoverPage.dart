// import 'package:anaar_demo/providers/catelogProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:anaar_demo/model/catelogMode.dart';

// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final _searchController = TextEditingController();
//   bool _isSearching = false;

//   @override
//   Widget build(BuildContext context) {
//     final catelogProvider = Provider.of<CatelogProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Catalog'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(50.0),
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) {
//                 if (value.isNotEmpty) {
//                   setState(() {
//                     _isSearching = true;
//                   });
//                   catelogProvider.searchCatalog(value).then((_) {
//                     setState(() {
//                       _isSearching = false;
//                     });
//                   });
//                 } else {
//                   setState(() {
//                     _isSearching = false;
//                   });
//                   catelogProvider.searchResults.clear();
//                 }
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search for products...',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: _isSearching
//           ? Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//               ),
//               itemCount: catelogProvider.searchResults.length,
//               itemBuilder: (context, index) {
//                 final catalog = catelogProvider.searchResults[index];
//                 return Card(
//                   child: Column(
//                     children: <Widget>[
//                       Expanded(
//                         child: Image.network(catalog.images.isNotEmpty
//                             ? catalog.images[0]??''
//                             : ''),
//                       ),
//                       Text(catalog.productName ?? 'No Name'),
//                       Text(catalog.description ?? 'No Description'),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }


import 'package:anaar_demo/model/catelogMode.dart';
import 'package:anaar_demo/providers/catelogProvider.dart';
import 'package:anaar_demo/screens/showProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchCatalogScreen extends StatefulWidget {
  @override
  _SearchCatalogScreenState createState() => _SearchCatalogScreenState();
}

class _SearchCatalogScreenState extends State<SearchCatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchHistory = [];
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = prefs.getStringList('searchHistory') ?? [];
    });
  }

  Future<void> _addToSearchHistory(String searchTerm) async {
    if (!_searchHistory.contains(searchTerm)) {
      setState(() {
        _searchHistory.add(searchTerm);
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('searchHistory', _searchHistory);
    }
  }

  Future<void> _removeFromSearchHistory(String searchTerm) async {
    setState(() {
      _searchHistory.remove(searchTerm);
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', _searchHistory);
  }

  @override
  Widget build(BuildContext context) {
    final catalogProvider = Provider.of<CatelogProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        if (_showResults) {
          setState(() {
            _showResults = false;
            _searchController.clear();
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Search Catalog', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (jake){
                  final searchTerm = _searchController.text;
                      if (searchTerm.isNotEmpty) {
                        _addToSearchHistory(searchTerm);
                        catalogProvider.searchCatalog(searchTerm);
                        setState(() {
                          _showResults = true;
                        });
                      }
                },
                decoration: InputDecoration(
                  hintText: "Search....",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      final searchTerm = _searchController.text;
                      if (searchTerm.isNotEmpty) {
                        _addToSearchHistory(searchTerm);
                        catalogProvider.searchCatalog(searchTerm);
                        setState(() {
                          _showResults = true;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            if (!_showResults && _searchHistory.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  spacing: 8.0,
                  children: _searchHistory.map((term) {
                    return InputChip(
                      label: Text(term),
                      deleteIcon: Icon(Icons.close),
                      onDeleted: () {
                        _removeFromSearchHistory(term);
                      },
                      onPressed: () {
                        _searchController.text = term;
                        catalogProvider.searchCatalog(term);
                        setState(() {
                          _showResults = true;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            if (catalogProvider.isLoading)
              Expanded(child: Center(child: CircularProgressIndicator()))
            else if (_showResults && _searchController.text.isNotEmpty && catalogProvider.searchResults.isEmpty)
              Expanded(child: Center(child: Text('No results found')))
            else if (_showResults)
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 320,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: catalogProvider.searchResults.length,
                  itemBuilder: (ctx, i) => CatalogItem(catalogProvider.searchResults[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Catelogmodel catalog;

  CatalogItem(this.catalog);

  @override
  Widget build(BuildContext context) {
    final images = catalog.images;
    return GestureDetector(
      onTap: (){
        Get.to(()=>ProductScreen(catelog: catalog,));
      },
      child: Card(
        color: Colors.white
    ,
        
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: Image.network(
                   images[0] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text("Product Name:", style: TextStyle(fontWeight: FontWeight.w400)),
                    Text(
                      catalog.productName ?? '',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text('Price:'),
                    Text(
                      catalog.price ?? '',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
