import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/catelogMode.dart';
import 'package:anaar_demo/providers/catelogProvider.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/chatScreen.dart';
import 'package:anaar_demo/screens/profiles/ResellerProfilepage.dart';
import 'package:anaar_demo/screens/requirement_page.dart';
import 'package:anaar_demo/screens/resellerShowProfile.dart';
import 'package:anaar_demo/widgets/GalleryPhotoViewer.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// class ProductScreen extends StatefulWidget {
// Catelogmodel catelog;
// ProductScreen({required this.catelog});

//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var imageUrls=widget.catelog.images;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 300.0,
//                     enlargeCenterPage: true,
//                     autoPlay: true,
//                     aspectRatio: 16 / 9,
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     enableInfiniteScroll: true,
//                     autoPlayAnimationDuration: Duration(milliseconds: 800),
//                     viewportFraction: 0.8,
//                   ),
//                   items: imageUrls.map((url) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return 
//                         url!=null?
//                         Image.network(
//                           url,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ):SizedBox();
//                       },
//                     );
//                   }).toList(),
//                 ),
//                 Positioned(
//                   top: 40,
//                   left: 16,
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
             
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Product details:',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 widget.catelog.description??'',
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: NetworkImage('https://example.com/seller-profile-image.jpg'), // Replace with seller profile image URL
//                     radius: 30,
//                   ),
//                   SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Vijay sarees',
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       Text('Manufacturers, Dellhi'),
//                     ],
//                   ),
//                   Spacer(),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Handle connect button pressed
//                     },
//                     child: Text('Connect'),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   // Handle chat button pressed
//                 },
//                 icon: Icon(Icons.chat),
//                 label: Text('Initiate Conversion now .....'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'More Product like this',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: GridView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 8,
//                   mainAxisSpacing: 8,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemCount: 4, // Replace with the actual number of similar products
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       // Handle product tap
//                     },
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Image.network(
//                             'https://example.com/similar-product-image.jpg', // Replace with similar product image URL
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text('Product name'),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class ProductScreen extends StatefulWidget {

Catelogmodel catelog;
ProductScreen({required this.catelog});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String? userid;
  bool isConnected=false;
   
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Provider.of<UserProvider>(context, listen: false).fetchResellerinfo_post(widget.catelog.userId);
 _loaduserid();
  }


void _loaduserid()async{
  userid=await Helperfunction.getUserId();
   

}

  // final List<String> imageUrls = [
  @override
  Widget build(BuildContext context) {
    var imageUrls=widget.catelog.images;
    final userProvider = Provider.of<UserProvider>(context);
    final Listofconnection=userProvider.reseller?.connections;
   // final bool isConnected = userProvider.connections.contains(usermodel.id);
    final bool isConnected=Listofconnection?.any((connections)=>connections.userId==userid)??false;
        final bool isSameUser = userid == widget.catelog.userId;

    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return userProvider.isloading
              ? ShimmerLoadingCard()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 300.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                            ),
                            items: imageUrls.map((url) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return 
                                  url!=null?
                                  Image.network(
                                    url,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ):SizedBox();
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                            top: 40,
                            left: 16,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                         
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Product details:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '${widget.catelog.description}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                        child: Row(children: [Text('Product Name :',style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w500
                        
                        ),),Text(' ${widget.catelog.productName}',
                        style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w400
                        
                        ),
                        )],),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                        child: Row(children: [Text('Category :',style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w500
                        
                        ),),Text(' ${widget.catelog.category}',
                        style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w400
                        
                        ),
                        )],),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                        child: Row(children: [Text('Price :',style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w500
                        
                        ),),Text(' ${widget.catelog.price}',
                        style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w400
                        
                        ),
                        )],),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: ()=>Get.to(()=>ResellerShowprofile(usermodel: userProvider?.reseller)),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(userProvider.reseller?.image ?? ''),
                                radius: 30,
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProvider.reseller?.businessName??'',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Text(userProvider.reseller?.city ?? ''),
                                ],
                              ),
                              Spacer(),
                             isSameUser
                                    ? SizedBox()
                                    : TextButton(
                                        onPressed: () async {
                                          if (!isConnected) {
                                            print(" connected function hitted.......................");
                                            await userProvider.connectUser(userid, widget.catelog.userId,userProvider.reseller?.type);
                                          }
                                        },
                                        child: Text(
                                          isConnected ? 'Connected' : 'Connect',
                                          style: TextStyle(
                                            color: isConnected ? Colors.red : Colors.blue,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                            ],
                          ),
                        ),
                      ),
                    
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'More Product From this Supplier',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child:showCatelog(userid: userProvider.reseller?.id)
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300.0,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150.0,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(height: 8.0),
                Container(
                  width: 200.0,
                  height: 16.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.0,
                      height: 16.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: 150.0,
                      height: 16.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              height: 16.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 200.0,
              height: 16.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150.0,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(height: 8.0),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class showCatelog extends StatefulWidget{
  String? userid;
  showCatelog({required this.userid});
  @override
  State<showCatelog> createState() => _showCatelogState();
}

class _showCatelogState extends State<showCatelog> {
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<Catelogmodel>>(
        future: Provider.of<CatelogProvider>(context, listen: false)
            .getPostByuserId(widget.userid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error in fetching catelog"),
            );
          } 
          else if(snapshot.data!.isEmpty){
              return Center(child: Text('No Catelog Product found'),);
          }
          
          else {
            final cateloglist=snapshot.data!;
            final imageUrls = cateloglist
                .map((post) =>
                    post.images?.isNotEmpty == true ? post.images![0] : '')
                .toList();

return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: cateloglist.length, // Replace with the actual number of similar products
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _dialogBuilder(context,cateloglist[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(elevation: 10,
                                color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            imageUrls[index]??'', // Replace with similar product image URL
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 8),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Row(
                                            children: [
                                              Text("Product Name : ",style: TextStyle(fontWeight: FontWeight.w400),),
                                              Text(cateloglist[index].productName??'',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );



          }}
          
          );










  }

Future<void> _dialogBuilder(BuildContext context,Catelogmodel catelogmodel) {


  void _openPhotoViewer(BuildContext context, int initialIndex) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PhotoViewer(
    //       imageUrls: imageUrls,
    //       initialIndex: initialIndex,
    //     ),
    //   ),
    // );

    Get.to(()=>PhotoViewer(imageUrls: catelogmodel.images, initialIndex: initialIndex));
  }

    return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            
            title:  Text(catelogmodel.productName??''),
            content:  Expanded(
              child: Container(
                
                  // color: Colors.black,
                   height: MediaQuery.of(context).size.height/1.2,
                   width: MediaQuery.of(context).size.width,
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   Container(
                child: 
                catelogmodel.images.isNotEmpty
                    ? Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          // return Image.file(
                          //   _imageFiles[index],
                          //   fit: BoxFit.cover,
                          // );
                        return Expanded(child: GestureDetector(
                          onTap: ()=>_openPhotoViewer(context, 0),
                          child: Image(image: NetworkImage(catelogmodel.images[index]??''),fit: BoxFit.cover,)));
                        
                        },
                        itemCount: catelogmodel.images.length,
                        pagination: SwiperPagination(),
                        control: SwiperControl(),
                      )
                    : Center(child: Text("No images selected")),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: Colors.grey, width: 2, style: BorderStyle.solid),
                ),
              ),
              SizedBox(height: 5,),
              Divider(thickness: 2,),
              SizedBox(height: 5,),
               Text("Details:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
               SizedBox(height: 10,),
               Text("ProductName",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
               SizedBox(height: 10,),
               Text(catelogmodel.productName??''),
               SizedBox(height: 10,),
               Text("Category",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
               SizedBox(height: 5,),
               Text(catelogmodel.category??''),
               SizedBox(height: 10,)
              ,Text("Price",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              SizedBox(height: 5,)
              ,Text(catelogmodel.price??''),
              SizedBox(height: 10,),
              Text("Description",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              SizedBox(height: 5,),
              Text(catelogmodel.description??'')
              
               

                   ],),
                        
              ),
            ),
           
          ),
        );
      },
    );

    
  }




}