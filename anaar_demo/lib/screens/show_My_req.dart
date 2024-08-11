import 'package:anaar_demo/model/Requirement_model.dart';
import 'package:anaar_demo/providers/RequirementProvider.dart';
import 'package:anaar_demo/widgets/GalleryPhotoViewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MY_requirements extends StatefulWidget {
  final String? loggedInUserId;

  MY_requirements({required this.loggedInUserId});

  @override
  State<MY_requirements> createState() => _MY_requirementsState();
}

class _MY_requirementsState extends State<MY_requirements> {
  Future<void> _refresh() async {
    await Provider.of<RequirementcardProvider>(context, listen: false)
        .fetchrequirementByuserid(widget.loggedInUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        
        backgroundColor: Colors.red,
        title: const Text(
          "My Requirements",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
        color: Colors.white, // Change this to the color you want for the leading icon
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Requirement>>(
          future: Provider.of<RequirementcardProvider>(context, listen: false)
              .fetchrequirementByuserid(widget.loggedInUserId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("An error occurred"));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text("No requirement available"));
            } else {
              final req = snapshot.data!;
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: req.length,
                itemBuilder: (context, index) {
                  return _RequirementCard(
                    requirement: req[index],
                    onDelete: () => _refresh(), // Trigger refresh after deletion
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class _RequirementCard extends StatefulWidget {
  final Requirement requirement;
  final VoidCallback onDelete;

  _RequirementCard({required this.requirement, required this.onDelete});

  @override
  State<_RequirementCard> createState() => _RequirementCardState();
}

class _RequirementCardState extends State<_RequirementCard> {
  void _openPhotoViewer(BuildContext context, int initialIndex) {
    Get.to(() => PhotoViewer(
          imageUrls: widget.requirement.images,
          initialIndex: initialIndex,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final requiremcard =
        Provider.of<RequirementcardProvider>(context, listen: false);

    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Product Details:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Delete'),
                      content: const Text('Do you want to delete this post?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context, 'OK');
                            await requiremcard
                                .deleteRequirement(widget.requirement.sId!)
                                .then((_) {
                              widget.onDelete(); // Trigger the refresh after successful deletion
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString())));
                            });
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
<<<<<<< HEAD
            SizedBox(height: 8.0),
            Text("Product Name: ${widget.requirement.productName}"),
            Text('Category: ${widget.requirement.category}'),
            Text('QTY: ${widget.requirement.quantity}'),
            Text('Total Price: ${widget.requirement.totalPrice}'),
            SizedBox(height: 8.0),
            Text('More Details:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(widget.requirement.details ?? ''),
            SizedBox(height: 8.0),
            Text('Attached Images:',
=======
            const SizedBox(height: 8.0),
            Text("Product Name: ${widget.requirement?.productName}"),
            Text('Category: ${widget.requirement?.category}'),
            Text('QTY: ${widget.requirement?.quantity}'),
            Text('Total Price: ${widget.requirement?.totalPrice}'),
            const SizedBox(height: 8.0),
            const Text('More Details:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(widget.requirement?.details ?? ''),
            const SizedBox(height: 8.0),
            const Text('Attached Images:',
>>>>>>> 02b72ab12c2d074b1f76e447584f925e833dccd8
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.requirement.images.map((image) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () => _openPhotoViewer(
                              context, widget.requirement.images.indexOf(image)),
                          child: Image.network(
                            image??'',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
