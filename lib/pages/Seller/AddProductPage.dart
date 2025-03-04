import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/API_SERVICE/api_service.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  final User seller;
  const AddProductPage({super.key, required this.seller});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _api = ApiService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Hàm chọn hình ảnh
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Chuẩn bị dữ liệu sản phẩm
      Map<String, dynamic> productData = {
        "name": _nameController.text,
        "price": double.parse(_priceController.text),
        "quantity": int.parse(_quantityController.text),
        "description": _descriptionController.text,
        "category": _categoryController.text,
        "img": "",
        "sold": 0,
        "address": {
          "number": _numberController.text,
          "street": _streetController.text,
          "city": _cityController.text,
          "country": _countryController.text,
        },
      };

      await _api.addProduct(widget.seller.id, productData);

      // Hiển thị thông báo hoặc quay lại màn hình trước
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thêm sản phẩm thành công!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 65, 164, 245),
              const Color.fromARGB(255, 119, 238, 218),
              const Color.fromARGB(255, 231, 212, 212)
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
              ),
            ),
            Positioned(
              top: 80,
              left: 20,
              child: Container(
                  height: 40,
                  width: 350,
                  child: Row(
                    children: [
                      BigText(
                        '',
                        text: 'Hãy thêm sản phẩm mới',
                        color: Colors.black,
                        size: 25,
                      ),
                    ],
                  )),
            ),
            Positioned(
              top: 130,
              left: 20,
              right: 20,
              bottom: 10,
              child: SingleChildScrollView(
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _image == null
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey[700],
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _image!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: Icon(Icons.upload_file),
                            label: Text('Chọn ảnh'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _nameController,
                              label: 'Tên sản phẩm',
                              hint: 'Nhập tên sản phẩm',
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _priceController,
                              label: 'Giá sản phẩm',
                              hint: 'Nhập giá sản phẩm',
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _quantityController,
                              label: 'Số lượng',
                              hint: 'Nhập số lượng',
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _descriptionController,
                              label: 'Mô tả sản phẩm',
                              hint: 'Nhập mô tả sản phẩm',
                              maxLines: 3,
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _categoryController,
                              label: 'Danh mục',
                              hint: 'Nhập danh mục sản phẩm',
                            ),
                            SizedBox(height: 16),
                            // Địa chỉ sản phẩm
                            Text(
                              'Địa chỉ sản phẩm:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            _buildTextField(
                              controller: _numberController,
                              label: 'Số nhà',
                              hint: 'Nhập số nhà',
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _streetController,
                              label: 'Tên đường',
                              hint: 'Nhập tên đường',
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _cityController,
                              label: 'Thành phố',
                              hint: 'Nhập thành phố',
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              controller: _countryController,
                              label: 'Quốc gia',
                              hint: 'Nhập quốc gia',
                            ),
                            SizedBox(height: 24),
                            // Nút lưu sản phẩm
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _submitForm();
                                },
                                child: Text(
                                  'Lưu sản phẩm',
                                  style: TextStyle(fontSize: 16),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    keyboardType: keyboardType,
    maxLines: maxLines,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Vui lòng nhập $label';
      }
      return null;
    },
  );
}
