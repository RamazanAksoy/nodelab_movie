import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodelab_movie/core/extension/context_extension.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  File? selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void _onContinue() {
    if (selectedImage != null) {
      Navigator.pop(context, selectedImage!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildTopBar(),
              const SizedBox(height: 32),
              _buildTitle(),
              const SizedBox(height: 32),
              _buildImagePicker(),
              const Spacer(),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: context.theme.colorScheme.onBackground),
        ),
        const SizedBox(width: 16),
        Text(
          'profile.title'.tr(),
          style: TextStyle(color: context.theme.colorScheme.onBackground, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'profile.add_photo_detail'.tr(),
          style: TextStyle(color: context.theme.colorScheme.onBackground, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Resources out incentivize\nrelaxation floor loss cc.',
          style: TextStyle(color: context.theme.colorScheme.onBackground.withOpacity(0.7)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(24),
          image: selectedImage != null ? DecorationImage(image: FileImage(selectedImage!), fit: BoxFit.cover) : null,
        ),
        child: selectedImage == null
            ? Center(child: Icon(Icons.add, color: context.theme.colorScheme.onBackground.withOpacity(0.5), size: 32))
            : null,
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.theme.colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          'profile.continue'.tr(),
          style: TextStyle(color: context.theme.colorScheme.onBackground, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
