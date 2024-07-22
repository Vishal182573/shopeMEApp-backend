import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FileUploadScreen(),
//     );
//   }
// }

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _file;
  bool showSpinner = false;
  String _uploadStatus = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    if (_file == null) {
      setState(() {
        showSpinner = false;
        _uploadStatus = 'No file selected';
      });
      return;
    }

    var uri = Uri.parse('http://192.168.0.107:3000/api/image/upload');

    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', _file!.path));

    var response = await request.send();
    var responseData = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(responseData.body);
      print(jsonResponse['imageUrl']);
      setState(() {
        showSpinner = false;
        _uploadStatus = 'Upload successful! URL: ${jsonResponse['imageUrl']}';
      });
    } else {
      setState(() {
        showSpinner = false;
        _uploadStatus = 'Failed: ${responseData.body}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _file == null ? Text('No file selected.') : Image.file(_file!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showSpinner ? null : uploadImage,
              child: showSpinner
                  ? CircularProgressIndicator()
                  : Text('Upload File'),
            ),
            SizedBox(height: 20),
            Text(_uploadStatus),
          ],
        ),
      ),
    );
  }
}
