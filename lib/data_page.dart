// import 'dart:html' as html;
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:typed_data'; // make sure to import this




// class ProductUploadPage extends StatefulWidget {
//   @override
//   _ProductUploadPageState createState() => _ProductUploadPageState();
// }

// class _ProductUploadPageState extends State<ProductUploadPage> {
//   final _firestore = FirebaseFirestore.instance;
//   final _storage = FirebaseStorage.instance;

//   // Controllers
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _typeController = TextEditingController();
//   final _brandController = TextEditingController();

//   // For sizes array input
//   List<String> sizes = [];
//   final _sizeController = TextEditingController();

//   // For images
//   List<html.File> selectedFiles = [];
//   List<String> uploadedImageUrls = [];

//   bool isUploading = false;

//   // Pick multiple images (web)
//   void pickImages() {
//     html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//     uploadInput.multiple = true;
//     uploadInput.accept = 'image/*';
//     uploadInput.click();

//     uploadInput.onChange.listen((event) {
//       final files = uploadInput.files;
//       if (files != null) {
//         setState(() {
//           selectedFiles.addAll(files);
//         });
//       }
//     });
//   }

//   // Upload images to Firebase Storage and get URLs

//   Future<void> uploadImages(id) async {
//     uploadedImageUrls.clear();
//     for (var file in selectedFiles) {
//       final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
// final ref = _storage.ref().child('productsImages/$id/$fileName');

//       final reader = html.FileReader();
//       reader.readAsArrayBuffer(file);
//       await reader.onLoad.first;

//       final result = reader.result;

//       Uint8List uint8list;
//       if (result is ByteBuffer) {
//         uint8list = Uint8List.view(result);
//       } else if (result is Uint8List) {
//         uint8list = result;
//       } else {
//         throw Exception('Unexpected FileReader result type: ${result.runtimeType}');
//       }

//       final uploadTask = ref.putData(uint8list);
//       final snapshot = await uploadTask.whenComplete(() => null);
//       final url = await snapshot.ref.getDownloadURL();
//       uploadedImageUrls.add(url);
//     }
//   }

//   // Add a size to the sizes list
//   void addSize() {
//     final text = _sizeController.text.trim();
//     if (text.isNotEmpty && !sizes.contains(text)) {
//       setState(() {
//         sizes.add(text);
//         _sizeController.clear();
//       });
//     }
//   }

//   // Generate Product ID: time-based string
//   String generateProductId() {
//     return DateTime.now().millisecondsSinceEpoch.toString();
//   }

//   // Upload all data to Firestore
//   Future<void> uploadProduct() async {
//     final name = _nameController.text.trim();
//     final description = _descriptionController.text.trim();
//     final priceText = _priceController.text.trim();
//     final type = _typeController.text.trim();
//     final brand = _brandController.text.trim();

//     if (name.isEmpty ||
//         description.isEmpty ||
//         priceText.isEmpty ||
//         type.isEmpty ||
//         brand.isEmpty ||
//         sizes.isEmpty ||
//         selectedFiles.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please fill all fields and select images')));
//       return;
//     }

//     double? price = double.tryParse(priceText);
//     if (price == null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Enter a valid price')));
//       return;
//     }

//     setState(() {
//       isUploading = true;
//     });

//     try {
//       final productId = generateProductId();
//       await uploadImages(productId);

//       await _firestore.collection('MedCareProducts').doc(productId).set({
//         'ProductId': productId,
//         'name': name,
//         'description': description,
//         'price': price,
//         'type': type,
//         'brand': brand,
//         'sizes': sizes,
//         'reviews': [],
//         'images': uploadedImageUrls,
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Product uploaded successfully')));

//       // Clear form
//       _nameController.clear();
//       _descriptionController.clear();
//       _priceController.clear();
//       _typeController.clear();
//       _brandController.clear();
//       _sizeController.clear();
//       sizes.clear();
//       selectedFiles.clear();
//       uploadedImageUrls.clear();
//       setState(() {});
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Upload failed: $e')));
//     }

//     setState(() {
//       isUploading = false;
//     });
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     _priceController.dispose();
//     _typeController.dispose();
//     _brandController.dispose();
//     _sizeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Upload Product'), backgroundColor: Colors.teal),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Product Name'),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Product Description'),
//               maxLines: 3,
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _priceController,
//               decoration: InputDecoration(labelText: 'Product Price'),
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _typeController,
//               decoration: InputDecoration(labelText: 'Product Type'),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _brandController,
//               decoration: InputDecoration(labelText: 'Product Brand'),
//             ),
//             SizedBox(height: 20),

//             // Sizes input
//             Text('Sizes (Add one by one)'),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _sizeController,
//                     decoration: InputDecoration(hintText: 'Enter size (e.g., M, L, XL)'),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: addSize,
//                   child: Text('Add Size'),
//                 )
//               ],
//             ),
//             Wrap(
//               spacing: 8,
//               children: sizes
//                   .map((s) => Chip(
//                 label: Text(s),
//                 onDeleted: () {
//                   setState(() {
//                     sizes.remove(s);
//                   });
//                 },
//               ))
//                   .toList(),
//             ),

//             SizedBox(height: 20),

//             // Images picker
//             Text('Product Images (multiple)'),
//             ElevatedButton(
//               onPressed: pickImages,
//               child: Text('Pick Images'),
//             ),
//             SizedBox(height: 10),

//             // Show selected images file names
//             if (selectedFiles.isNotEmpty)
//               Container(
//                 height: 100,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: selectedFiles.length,
//                   itemBuilder: (context, index) {
//                     final file = selectedFiles[index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Column(
//                         children: [
//                           Icon(Icons.image, size: 50, color: Colors.teal),
//                           SizedBox(height: 4),
//                           SizedBox(
//                             width: 80,
//                             child: Text(
//                               file.name,
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),

//             SizedBox(height: 30),

//             Center(
//               child: ElevatedButton(
//                 onPressed: isUploading ? null : uploadProduct,
//                 child: isUploading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text('Upload Product'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(200, 50),
//                   backgroundColor: Colors.teal,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductUploadPage extends StatefulWidget {
  const ProductUploadPage({super.key});

  @override
  _ProductUploadPageState createState() => _ProductUploadPageState();
}

class _ProductUploadPageState extends State<ProductUploadPage> {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // Controllers
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _typeController = TextEditingController();
  final _brandController = TextEditingController();
  final _sizeController = TextEditingController();

  // Data
  List<String> sizes = [];
  List<PlatformFile> selectedFiles = [];
  List<String> uploadedImageUrls = [];

  bool isUploading = false;

  // ✅ Pick multiple images (cross-platform)
  Future<void> pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true, // get bytes directly
    );

    if (result != null) {
      setState(() {
        selectedFiles = result.files;
      });
    }
  }

  // ✅ Upload images to Firebase Storage and return URLs
  Future<void> uploadImages(String id) async {
    uploadedImageUrls.clear();
    for (var file in selectedFiles) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
      final ref = _storage.ref().child('productsImages/$id/$fileName');

      if (file.bytes != null) {
        final uploadTask = ref.putData(file.bytes!);
        final snapshot = await uploadTask.whenComplete(() {});
        final url = await snapshot.ref.getDownloadURL();
        uploadedImageUrls.add(url);
      }
    }
  }

  // Add a size to the list
  void addSize() {
    final text = _sizeController.text.trim();
    if (text.isNotEmpty && !sizes.contains(text)) {
      setState(() {
        sizes.add(text);
        _sizeController.clear();
      });
    }
  }

  // Generate Product ID
  String generateProductId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // ✅ Upload product data to Firestore
  Future<void> uploadProduct() async {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final priceText = _priceController.text.trim();
    final type = _typeController.text.trim();
    final brand = _brandController.text.trim();

    if (name.isEmpty ||
        description.isEmpty ||
        priceText.isEmpty ||
        type.isEmpty ||
        brand.isEmpty ||
        sizes.isEmpty ||
        selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select images')),
      );
      return;
    }

    double? price = double.tryParse(priceText);
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid price')),
      );
      return;
    }

    setState(() => isUploading = true);

    try {
      final productId = generateProductId();

      // Upload images first
      await uploadImages(productId);

      // Upload product data
      await _firestore.collection('MedCareProducts').doc(productId).set({
        'ProductId': productId,
        'name': name,
        'description': description,
        'price': price,
        'type': type,
        'brand': brand,
        'sizes': sizes,
        'reviews': [],
        'images': uploadedImageUrls,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product uploaded successfully')),
      );

      // Clear form
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _typeController.clear();
      _brandController.clear();
      _sizeController.clear();
      sizes.clear();
      selectedFiles.clear();
      uploadedImageUrls.clear();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }

    setState(() => isUploading = false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _typeController.dispose();
    _brandController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Product'), backgroundColor: Colors.teal),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Product Name')),
            const SizedBox(height: 10),
            TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Product Description'), maxLines: 3),
            const SizedBox(height: 10),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Product Price'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
            const SizedBox(height: 10),
            TextField(controller: _typeController, decoration: const InputDecoration(labelText: 'Product Type')),
            const SizedBox(height: 10),
            TextField(controller: _brandController, decoration: const InputDecoration(labelText: 'Product Brand')),
            const SizedBox(height: 20),

            const Text('Sizes (Add one by one)'),
            Row(
              children: [
                Expanded(
                  child: TextField(controller: _sizeController, decoration: const InputDecoration(hintText: 'Enter size (e.g., M, L, XL)')),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: addSize, child: const Text('Add Size'))
              ],
            ),
            Wrap(
              spacing: 8,
              children: sizes.map((s) => Chip(
                label: Text(s),
                onDeleted: () => setState(() => sizes.remove(s)),
              )).toList(),
            ),

            const SizedBox(height: 20),

            const Text('Product Images (multiple)'),
            ElevatedButton(onPressed: pickImages, child: const Text('Pick Images')),
            const SizedBox(height: 10),

            if (selectedFiles.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedFiles.length,
                  itemBuilder: (context, index) {
                    final file = selectedFiles[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          const Icon(Icons.image, size: 50, color: Colors.teal),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 80,
                            child: Text(file.name, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: isUploading ? null : uploadProduct,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.teal,
                ),
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload Product'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

