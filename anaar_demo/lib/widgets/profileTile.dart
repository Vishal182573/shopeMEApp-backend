import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/reseller_model.dart';
import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/userProvider.dart';
import 'package:anaar_demo/screens/resellerShowProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Profiletile extends StatefulWidget {
  final String ProfileName;
  final String Location;
  final String Imagepath;
  final Reseller usermodel;
  String? loggedInUserId;

  Profiletile({
    required this.Location,
    required this.ProfileName,
    required this.Imagepath,
    required this.usermodel,
     this.loggedInUserId,
  });

  @override
  State<Profiletile> createState() => _ProfiletileState();
}

class _ProfiletileState extends State<Profiletile> {
 String? logUserId;
 bool isConnected=false;

 bool isSameUser=false;
 
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserid();
   // final userProvider = Provider.of<UserProvider>(context);
  }
void getuserid()async{
  logUserId=await Helperfunction.getUserId();
  setState(() {
    final Listofconnection=widget.usermodel.connections;
     isConnected=Listofconnection?.any((connections)=>connections.userId==logUserId)??false;
     isSameUser = logUserId == widget.usermodel.id;
    
  });

}

  @override
  Widget build(BuildContext context) {
  
      

    
    final userProvider=Provider.of<UserProvider>(context);
   // final bool isConnected = userProvider.connections.contains(usermodel.id);
    
    print('${isConnected}.........................connect hai ya nhiiiiiiii');

    return ListTile(
      style: ListTileStyle.drawer,
      //style: ListTileStyle.list,
      onTap: () => Get.to(() => ResellerShowprofile(usermodel: widget.usermodel,loggedInUserId: widget.loggedInUserId,)),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.Imagepath),
      ),
      title: Text(widget.ProfileName),
      subtitle: Row(
        children: [
          Text('Manufacturer'),
          SizedBox(width:2),
          Text('Delhi',
      overflow: TextOverflow.ellipsis,
        
          
          ),
        ],
      ),
      trailing: isSameUser
          ? null
          : TextButton(
              onPressed: () async {
                if (!isConnected) {
                  print(" connected function hitted.......................");
                  await userProvider.connectUser(widget.loggedInUserId, widget.usermodel.id,widget.usermodel.type);
                setState(() {
                  
                });
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
    );
  }
}
