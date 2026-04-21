import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final Color _bgColor = const Color(0xFF116171);
  final Color _cardColor = const Color(0xFFE4EBEC);
  final Color _fieldTeal = const Color(0xFF176B7C);
  final Color _fieldDisabled = const Color(0xFF7A7978);

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Adan");
    _emailController = TextEditingController(text: "adan.s@foundora.com");
    _phoneController = TextEditingController(text: "+92 (300) 123-4567");
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.md),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
            ),
            onPressed: () => context.pop(),
          ),
        ),
        title: const Text("Personal Information", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile updated"))),
            child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Image
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 110, height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey.shade300,
                              border: Border.all(color: Colors.black87, width: 1.5),
                              image: _profileImage != null ? DecorationImage(image: FileImage(_profileImage!), fit: BoxFit.cover) : null,
                            ),
                            child: _profileImage == null ? const Icon(Icons.person_outline_rounded, size: 70, color: Colors.black87) : null,
                          ),
                          Positioned(bottom: 0, right: 0, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle, border: Border.all(color: Colors.black87, width: 1.5)), child: const Icon(Icons.edit, size: 16, color: Colors.black87))),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextButton.icon(onPressed: _pickImage, icon: const Icon(Icons.edit, size: 16, color: Colors.white), label: const Text("Edit Profile Picture", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Account Details
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(color: _cardColor, borderRadius: BorderRadius.circular(AppRadius.lg)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Account Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: AppSpacing.md),
                    const Text("Full Name", style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
                    TextField(controller: _nameController, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500), decoration: InputDecoration(filled: true, fillColor: _fieldTeal, suffixIcon: const Icon(Icons.edit, color: Colors.white70, size: 18), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                    const SizedBox(height: AppSpacing.md),
                    TextField(controller: _emailController, enabled: false, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600), decoration: InputDecoration(filled: true, fillColor: _fieldDisabled, prefixIcon: const Icon(Icons.lock_rounded, color: Colors.black54, size: 18), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                    const Text("Primary email cannot be changed here.", style: TextStyle(fontSize: 11, color: Colors.black87)),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Contact Information
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(color: _cardColor, borderRadius: BorderRadius.circular(AppRadius.lg)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Contact Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: AppSpacing.md),
                    const Text("Verified Phone Number", style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
                    TextField(controller: _phoneController, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500), decoration: InputDecoration(filled: true, fillColor: _fieldTeal, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Color(0xFFE4EBEC), border: Border(top: BorderSide(color: Colors.black12, width: 1))),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, elevation: 0,
          selectedItemColor: _fieldTeal, unselectedItemColor: Colors.black87,
          currentIndex: 2,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI Match'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}