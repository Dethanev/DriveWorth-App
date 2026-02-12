import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../shared/widgets/primary_button.dart';

class InputSection extends StatelessWidget {
  final int tabIndex;
  final TextEditingController controller;
  final bool isAnalyzing;
  final VoidCallback onStartAnalysis;

  const InputSection({
    super.key,
    required this.tabIndex,
    required this.controller,
    required this.isAnalyzing,
    required this.onStartAnalysis,
  });

  _InputConfig _getConfig() {
    switch (tabIndex) {
      case 0:
        return _InputConfig(
          hintText: '輸入電話號碼…',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        );
      case 1:
        return _InputConfig(
          hintText: '輸入網址…',
          icon: Icons.link_outlined,
          keyboardType: TextInputType.url,
        );
      case 2:
        return _InputConfig(
          hintText: '貼上簡訊或對話內容…',
          icon: Icons.chat_bubble_outline,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
        );
      case 3:
      default:
        return _InputConfig(
          hintText: '描述圖片內容(點一下就有！)',
          icon: Icons.image_outlined,
          keyboardType: TextInputType.text,
          isImagePicker: true,
        );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // TODO: 處理圖片上傳或分析
      controller.text = '已選擇圖片：${image.name}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = _getConfig();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          maxLines: config.maxLines,
          keyboardType: config.keyboardType,
          readOnly: config.isImagePicker,
          onTap: config.isImagePicker ? _pickImage : null,
          decoration: InputDecoration(
            hintText: config.hintText,
            prefixIcon: config.maxLines == 1 ? Icon(config.icon) : null,
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          text: '開始分析',
          isLoading: isAnalyzing,
          onPressed: onStartAnalysis,
        ),
      ],
    );
  }
}

class _InputConfig {
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;
  final bool isImagePicker;

  _InputConfig({
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.isImagePicker = false,
  });
}
