import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_decorations.dart';
import '../../config/app_text_styles.dart';

class FormCenterPage extends StatefulWidget {
  const FormCenterPage({super.key});

  @override
  State<FormCenterPage> createState() => _FormCenterPageState();
}

class _FormCenterPageState extends State<FormCenterPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _experienceType = '用車心得';

  static const List<String> _experienceTypes = [
    '用車心得',
    '維修經驗',
    '省油技巧',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('感謝分享！', style: AppTextStyles.body),
        backgroundColor: AppColors.statusSafe,
        behavior: SnackBarBehavior.floating,
      ),
    );
    setState(() {
      _experienceType = _experienceTypes.first;
      _titleController.clear();
      _contentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('表單中心', style: AppTextStyles.h2),
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: AppDecorations.neuCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('分享經驗', style: AppTextStyles.h4),
                  const SizedBox(height: 20),
                  Text('經驗類型', style: AppTextStyles.bodyBold),
                  const SizedBox(height: 8),
                  Container(
                    decoration: AppDecorations.neuCard,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _experienceType,
                        isExpanded: true,
                        items: _experienceTypes
                            .map((e) => DropdownMenuItem(value: e, child: Text(e, style: AppTextStyles.body)))
                            .toList(),
                        onChanged: (v) => setState(() => _experienceType = v ?? _experienceTypes.first),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('標題', style: AppTextStyles.bodyBold),
                  const SizedBox(height: 8),
                  _NeuTextField(
                    controller: _titleController,
                    hint: '請輸入標題',
                    maxLines: 1,
                    validator: (v) => (v == null || v.trim().isEmpty) ? '請填寫標題' : null,
                  ),
                  const SizedBox(height: 16),
                  Text('內容', style: AppTextStyles.bodyBold),
                  const SizedBox(height: 8),
                  _NeuTextField(
                    controller: _contentController,
                    hint: '分享你的經驗...',
                    maxLines: 5,
                    validator: (v) => (v == null || v.trim().isEmpty) ? '請填寫內容' : null,
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _submit,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      alignment: Alignment.center,
                      decoration: AppDecorations.neuButton(),
                      child: Text('送出', style: AppTextStyles.button),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NeuTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final String? Function(String?)? validator;

  const _NeuTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.neuCard,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
        style: AppTextStyles.body,
        validator: validator,
      ),
    );
  }
}
