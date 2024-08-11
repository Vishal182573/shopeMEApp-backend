import 'dart:math';
import 'package:anaar_demo/model/catelogMode.dart';
import 'package:anaar_demo/model/postcard_model.dart';
import 'package:anaar_demo/providers/catelogProvider.dart';
import 'package:anaar_demo/providers/postProvider.dart';
import 'package:anaar_demo/screens/TrendingPage.dart';
import 'package:anaar_demo/widgets/GalleryPhotoViewer.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Catelog_Grid extends StatefulWidget {
  String? userid;

  Catelog_Grid({this.userid});

  @override
  State<Catelog_Grid> createState() => _Post_GridState();
}

class _Post_GridState extends State<Catelog_Grid> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostcardProvider>(context, listen: false)
          .getPostByuserId(widget.userid);
    });
  }

  // final List<String> imageUrls;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<Catelogmodel>>(
        future: Provider.of<CatelogProvider>(context, listen: false)
            .getPostByuserId(widget.userid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error in fetching catelog"),
            );
          } 
          else if(snapshot.data!.isEmpty){
              return const Center(child: Text('No Catelog Product found'),);
          }
          
          else {
            final catelogcardlist = snapshot.data!;
            final imageUrls = catelogcardlist
                .map((post) =>
                    post.images?.isNotEmpty == true ? post.images![0] : '')
                .toList();
            return GridView.builder(
              itemCount: catelogcardlist.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _dialogBuilder(context,catelogcardlist[index]),
                child: Container(
                  height: 20,
                  width: 20,
                  //color: Colors.amber,
                  child: Expanded(
                    child: Stack(children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                       
                          
                          child: Image(
                            image: NetworkImage(imageUrls[index] ?? ''),
                            fit: BoxFit.cover,
                          ),
                          //color: Colors.blue,
                        ),
                      ),

         const Positioned(
                          bottom: 5,
                           right: 5,
                          child: Icon(Icons.my_library_books_rounded,size: 20,color: Color.fromARGB(255, 207, 207, 207),))
                    

                    ]),
                  ),
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 1,
              ),
            );
          }
        });
  }
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
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: Colors.grey, width: 2, style: BorderStyle.solid),
                ),
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
                        pagination: const SwiperPagination(),
                        control: const SwiperControl(),
                      )
                    : const Center(child: Text("No images selected")),
              ),
              const SizedBox(height: 5,),
              const Divider(thickness: 2,),
              const SizedBox(height: 5,),
              const Text("Details:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              const SizedBox(height: 15),
               Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "ProductName :",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            catelogmodel.productName ?? '',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    const SizedBox(height: 15),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Category :",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            catelogmodel.category ?? '',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    const SizedBox(height: 15),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Price :",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            catelogmodel.price ?? '',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    const SizedBox(height: 15),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Description :",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          catelogmodel.description ?? '',
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
  ],
)

               
              //  const SizedBox(height: 10,),
              //  const Text("Category",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              //  const SizedBox(height: 5,),
              //  Text(catelogmodel.category??''),
              //  const SizedBox(height: 10,)
              // ,const Text("Price",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              // const SizedBox(height: 5,)
              // ,Text(catelogmodel.price??''),
              // const SizedBox(height: 10,),
              // const Text("Description",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              // const SizedBox(height: 5,),
              // Text(catelogmodel.description??'')
              
               

                   ],),
                        
              ),
            ),
           
          ),
        );
      },
    );

    
  }

