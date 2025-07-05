import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/feature/OCR/presentation/widgets/image_picker_bottom_sheet.dart';

class ImageToTextPage extends StatefulWidget {
  const ImageToTextPage({super.key});

  @override
  State<ImageToTextPage> createState() => _ImageToTextPageState();
}

class _ImageToTextPageState extends State<ImageToTextPage> {
  File? _selectedImage;
  String _scannedText = '';
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return;

    setState(() {
      _selectedImage = File(pickedFile.path);
      _scannedText = '';
    });
  }

  Future<void> _scanText() async {
    if (_selectedImage == null) return;

    setState(() => _isLoading = true);
    final inputImage = InputImage.fromFile(_selectedImage!);
    final textRecognizer = TextRecognizer();

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );
      setState(() {
        if (recognizedText.text.trim().isEmpty) {
          _scannedText = 'No text';
          Fluttertoast.showToast(
            msg: "No readable text found",
            gravity: ToastGravity.TOP,
          );
        } else {
          _scannedText = recognizedText.text;
        }
      });
    } catch (e) {
      setState(() => _scannedText = 'Error reading text');
    } finally {
      textRecognizer.close();
      setState(() => _isLoading = false);
    }
  }

  void _copyText() {
    if (_scannedText.isEmpty || _scannedText == 'No text') return;
    Clipboard.setData(ClipboardData(text: _scannedText));
    Fluttertoast.showToast(msg: "Text copied", gravity: ToastGravity.TOP);
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => ImagePickerBottomSheet(
        onCameraTap: () {
          Navigator.pop(context);
          _pickImage(ImageSource.camera);
        },
        onGalleryTap: () {
          Navigator.pop(context);
          _pickImage(ImageSource.gallery);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          children: [
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Image to Text",
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy, size: 24.sp),
                  onPressed: _copyText,
                ),
              ],
            ),
            36.verticalSpace,

            // Image Container
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(32.r),
              ),
              alignment: Alignment.center,
              child: _selectedImage == null
                  ? Text(
                      "Upload an image \nusing the '+' \nbutton",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(32.r),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        height: 250.h,
                        width: double.infinity,
                      ),
                    ),
            ),
            24.verticalSpace,

            // Text Output Container
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(32.r),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(12.w),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : SingleChildScrollView(
                      child: Text(
                        _scannedText.isEmpty
                            ? "Click the 'Scan Image' \nbutton to perform scan"
                            : _scannedText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            ),
            24.verticalSpace,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => setState(() {
                    _selectedImage = null;
                    _scannedText = '';
                  }),
                  child: Text(
                    "Clear Image",
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: _scanText,
                  child: Text(
                    "Scan Image",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 70.w,
                  height: 70.h,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.primary,
                    shape: const CircleBorder(),
                    onPressed: _showImagePickerOptions,
                    child: Icon(Icons.add, size: 36.sp, color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
