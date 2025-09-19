/*
import 'dart:io'; // For the File type
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart'; // For the camera

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  String? _selectedIssue;
  String? _selectedPriority;
  File? _imageFile;

  // This function opens the camera
  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Report Issue', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('What type of issue?'),
            _buildIssueTypeSelector(),
            const SizedBox(height: 24),
            _buildSectionTitle('Add Photos'),
            _buildAddPhotos(),
            const SizedBox(height: 24),
            _buildSectionTitle('Location'),
            _buildLocationCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 24),
            _buildSectionTitle('Priority Level'),
            _buildPrioritySelector(),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildAddPhotos() {
    return GestureDetector(
      onTap: _pickImageFromCamera, // Opens camera on tap
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 6],
        color: Colors.grey,
        strokeWidth: 1,
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _imageFile == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 40),
              const SizedBox(height: 8),
              Text('Tap to add photos', style: GoogleFonts.poppins(color: Colors.grey)),
            ],
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _imageFile!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // (The rest of the helper widgets are below and do not need to be changed)

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Help Improve Your City', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Report issues and make your community better for everyone', style: GoogleFonts.poppins()),
              ],
            ),
          ),
          const Icon(Icons.lightbulb_circle, color: Colors.blue, size: 36),
        ],
      ),
    );
  }

  Widget _buildIssueTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSelectableCard('Road Issue', Icons.remove_road, 'Road Issue'),
        _buildSelectableCard('Streetlight', Icons.lightbulb_outline, 'Streetlight'),
        _buildSelectableCard('Other', Icons.help_outline, 'Other'),
      ],
    );
  }

  Widget _buildSelectableCard(String title, IconData icon, String value) {
    final bool isSelected = _selectedIssue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIssue = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.blue.shade800 : Colors.grey.shade700),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location Access Denied', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.red.shade800)),
                Text('Tap to set manually', style: GoogleFonts.poppins()),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Update')),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Describe the issue in detail. What exactly is the problem? When did you notice it?',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      children: [
        _buildPriorityChip('Low', 'Low', Colors.green),
        _buildPriorityChip('Medium', 'Medium', Colors.orange),
        _buildPriorityChip('High', 'High', Colors.red),
      ],
    );
  }

  Widget _buildPriorityChip(String label, String value, Color color) {
    final bool isSelected = _selectedPriority == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? color : Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
              const SizedBox(width: 8),
              Text(label, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}*/
/*
import 'dart:io'; // For the File type
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart'; // For the camera

class IssueFormPage extends StatefulWidget {
  const IssueFormPage({Key? key}) : super(key: key);

  @override
  _IssueFormPageState createState() => _IssueFormPageState();
}

class _IssueFormPageState extends State<IssueFormPage> {
  String? _selectedIssue;
  String? _selectedPriority;
  File? _imageFile;

  // This function opens the camera
  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Report Issue', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('What type of issue?'),
            _buildIssueTypeSelector(),
            const SizedBox(height: 24),
            _buildSectionTitle('Add Photos'),
            _buildAddPhotos(),
            const SizedBox(height: 24),
            _buildSectionTitle('Location'),
            _buildLocationCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 24),
            _buildSectionTitle('Priority Level'),
            _buildPrioritySelector(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildAddPhotos() {
    return GestureDetector(
      onTap: _pickImageFromCamera, // Opens camera on tap
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 6],
        color: Colors.grey,
        strokeWidth: 1,
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _imageFile == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 40),
              const SizedBox(height: 8),
              Text('Tap to add photos', style: GoogleFonts.poppins(color: Colors.grey)),
            ],
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _imageFile!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF64B5F6), Color(0xFF2196F3)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Handle form submission here
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Issue reported successfully!')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          'Submit Report',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Help Improve Your City', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Report issues and make your community better for everyone', style: GoogleFonts.poppins()),
              ],
            ),
          ),
          const Icon(Icons.lightbulb_circle, color: Colors.blue, size: 36),
        ],
      ),
    );
  }

  Widget _buildIssueTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSelectableCard('Road Issue', Icons.remove_road, 'Road Issue'),
        _buildSelectableCard('Streetlight', Icons.lightbulb_outline, 'Streetlight'),
        _buildSelectableCard('Other', Icons.help_outline, 'Other'),
      ],
    );
  }

  Widget _buildSelectableCard(String title, IconData icon, String value) {
    final bool isSelected = _selectedIssue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIssue = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.blue.shade800 : Colors.grey.shade700),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location Access Denied', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.red.shade800)),
                Text('Tap to set manually', style: GoogleFonts.poppins()),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Update')),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Describe the issue in detail. What exactly is the problem? When did you notice it?',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      children: [
        _buildPriorityChip('Low', 'Low', Colors.green),
        _buildPriorityChip('Medium', 'Medium', Colors.orange),
        _buildPriorityChip('High', 'High', Colors.red),
      ],
    );
  }

  Widget _buildPriorityChip(String label, String value, Color color) {
    final bool isSelected = _selectedPriority == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? color : Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
              const SizedBox(width: 8),
              Text(label, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}*/
// lib/reportissue.dart

/*import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart'; // Import compressor
import 'package:path_provider/path_provider.dart'; // Import path provider

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  String? _selectedIssue;
  String? _selectedPriority;
  File? _imageFile;

  bool _isLoadingLocation = false;
  String _locationMessage = 'Tap "Update" to get location';

  // UPDATED: This function now compresses the image
  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80, // You can set initial quality here
    );

    if (pickedFile == null) return;

    // Get the path for the temporary directory
    final tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Compress the image file
    final XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
      pickedFile.path,
      targetPath,
      quality: 60, // Lower quality means smaller file size (0-100)
    );

    if (compressedXFile != null) {
      setState(() {
        _imageFile = File(compressedXFile.path);
      });
    }
  }


  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
      _locationMessage = 'Fetching location...';
    });

    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final city = data['city'];
        final region = data['regionName'];
        final country = data['country'];
        setState(() {
          _locationMessage = '$city, $region, $country';
        });
      } else {
        setState(() {
          _locationMessage = 'Could not fetch location. Try again.';
        });
      }
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: Check internet connection.';
      });
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Report Issue', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('What type of issue?'),
            _buildIssueTypeSelector(),
            const SizedBox(height: 24),
            _buildSectionTitle('Add Photos'),
            _buildAddPhotos(),
            const SizedBox(height: 24),
            _buildSectionTitle('Location'),
            _buildLocationCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 24),
            _buildSectionTitle('Priority Level'),
            _buildPrioritySelector(),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Submit Report',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Approximate Location',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.green.shade800),
                ),
                if (_isLoadingLocation)
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(strokeWidth: 2)),
                  )
                else
                  Text(_locationMessage, style: GoogleFonts.poppins()),
              ],
            ),
          ),
          TextButton(
            onPressed: _isLoadingLocation ? null : _getCurrentLocation,
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }


  Widget _buildAddPhotos() {
    return GestureDetector(
      onTap: _pickImageFromCamera,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 6],
        color: Colors.grey,
        strokeWidth: 1,
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _imageFile == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 40),
              const SizedBox(height: 8),
              Text('Tap to add photos', style: GoogleFonts.poppins(color: Colors.grey)),
            ],
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _imageFile!,
              fit: BoxFit.cover, // This makes the image fit the box
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Help Improve Your City', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Report issues and make your community better for everyone', style: GoogleFonts.poppins()),
              ],
            ),
          ),
          const Icon(Icons.lightbulb_circle, color: Colors.blue, size: 36),
        ],
      ),
    );
  }

  Widget _buildIssueTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSelectableCard('Road Issue', Icons.remove_road, 'Road Issue'),
        _buildSelectableCard('Streetlight', Icons.lightbulb_outline, 'Streetlight'),
        _buildSelectableCard('Other', Icons.help_outline, 'Other'),
      ],
    );
  }

  Widget _buildSelectableCard(String title, IconData icon, String value) {
    final bool isSelected = _selectedIssue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIssue = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.blue.shade800 : Colors.grey.shade700),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Describe the issue in detail. What exactly is the problem? When did you notice it?',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      children: [
        _buildPriorityChip('Low', 'Low', Colors.green),
        _buildPriorityChip('Medium', 'Medium', Colors.orange),
        _buildPriorityChip('High', 'High', Colors.red),
      ],
    );
  }

  Widget _buildPriorityChip(String label, String value, Color color) {
    final bool isSelected = _selectedPriority == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? color : Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
              const SizedBox(width: 8),
              Text(label, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}*/
// lib/issuepage.dart
/*

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  String? _selectedIssue;
  String? _selectedPriority;
  File? _imageFile;
  bool _isCompressingImage = false;

  bool _isLoadingLocation = false;
  String _locationMessage = 'Tap "Update" to get location';

  // Enhanced image compression function
  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85, // Initial quality
        maxWidth: 1920, // Max width to reduce file size
        maxHeight: 1920, // Max height to reduce file size
      );

      if (pickedFile == null) return;

      setState(() {
        _isCompressingImage = true;
      });

      // Get the path for the temporary directory
      final tempDir = await getTemporaryDirectory();
      final targetPath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Compress the image file
      final XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
        pickedFile.path,
        targetPath,
        quality: 70, // Compress to 70% quality
        minWidth: 800, // Minimum width
        minHeight: 600, // Minimum height
        format: CompressFormat.jpeg,
      );

      if (compressedXFile != null) {
        setState(() {
          _imageFile = File(compressedXFile.path);
          _isCompressingImage = false;
        });

        // Show compression success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image compressed and ready!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          _isCompressingImage = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to compress image'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isCompressingImage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
      _locationMessage = 'Fetching location...';
    });

    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final city = data['city'];
        final region = data['regionName'];
        final country = data['country'];
        setState(() {
          _locationMessage = '$city, $region, $country';
        });
      } else {
        setState(() {
          _locationMessage = 'Could not fetch location. Try again.';
        });
      }
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: Check internet connection.';
      });
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Report Issue', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('What type of issue?'),
            _buildIssueTypeSelector(),
            const SizedBox(height: 24),
            _buildSectionTitle('Add Photos'),
            _buildAddPhotos(),
            const SizedBox(height: 24),
            _buildSectionTitle('Location'),
            _buildLocationCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 24),
            _buildSectionTitle('Priority Level'),
            _buildPrioritySelector(),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Issue reported successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Submit Report',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildAddPhotos() {
    return GestureDetector(
      onTap: _isCompressingImage ? null : _pickImageFromCamera,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 6],
        color: _imageFile != null ? Colors.green : Colors.grey,
        strokeWidth: 2,
        child: Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _imageFile != null ? Colors.green.shade50 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _isCompressingImage
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.blue),
              const SizedBox(height: 12),
              Text(
                'Compressing image...',
                style: GoogleFonts.poppins(color: Colors.blue, fontWeight: FontWeight.w500),
              ),
            ],
          )
              : _imageFile == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 48),
              const SizedBox(height: 12),
              Text(
                'Tap to add photos',
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Images will be automatically compressed',
                style: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          )
              : Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              // Success indicator
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
              // Retake option
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _imageFile = null;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Retake',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Approximate Location',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.green.shade800),
                ),
                if (_isLoadingLocation)
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(strokeWidth: 2)),
                  )
                else
                  Text(_locationMessage, style: GoogleFonts.poppins()),
              ],
            ),
          ),
          TextButton(
            onPressed: _isLoadingLocation ? null : _getCurrentLocation,
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Help Improve Your City', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Report issues and make your community better for everyone', style: GoogleFonts.poppins()),
              ],
            ),
          ),
          const Icon(Icons.lightbulb_circle, color: Colors.blue, size: 36),
        ],
      ),
    );
  }

  Widget _buildIssueTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSelectableCard('Road Issue', Icons.remove_road, 'Road Issue'),
        _buildSelectableCard('Streetlight', Icons.lightbulb_outline, 'Streetlight'),
        _buildSelectableCard('Other', Icons.help_outline, 'Other'),
      ],
    );
  }

  Widget _buildSelectableCard(String title, IconData icon, String value) {
    final bool isSelected = _selectedIssue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIssue = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.blue.shade800 : Colors.grey.shade700),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Describe the issue in detail. What exactly is the problem? When did you notice it?',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      children: [
        _buildPriorityChip('Low', 'Low', Colors.green),
        _buildPriorityChip('Medium', 'Medium', Colors.orange),
        _buildPriorityChip('High', 'High', Colors.red),
      ],
    );
  }

  Widget _buildPriorityChip(String label, String value, Color color) {
    final bool isSelected = _selectedPriority == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? color : Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
              const SizedBox(width: 8),
              Text(label, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}*/
// Add these dependencies to your pubspec.yaml:
// geolocator: ^10.1.0
// geocoding: ^2.1.1

import 'dart:io';
import 'package:civic_connect/supabase_service.dart';

import 'services/supabase_service.dart'; // adjust path if you put it in lib/services/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  String? _selectedIssue;
  String? _selectedPriority;
  File? _imageFile;
  bool _isProcessingImage = false;

  bool _isLoadingLocation = false;
  String _locationMessage = 'Tap "Update" to get location';
  Position? _currentPosition;

  // Enhanced landmark detection for Pune area
  final Map<String, Map<String, dynamic>> _puneAreas = {
    'karve_nagar': {
      'name': 'Karve Nagar',
      'keywords': ['karve', 'kothrud', 'warje'],
      'bounds': {'lat': 18.5074, 'lng': 73.8077, 'radius': 2.0}
    },
    'marathwada_mitramandal': {
      'name': 'near Marathwada Mitramandal College',
      'keywords': ['pune university', 'university road', 'ganeshkhind', 'pune univ'],
      'bounds': {'lat': 18.5421, 'lng': 73.8267, 'radius': 1.5}
    },
    'camp': {
      'name': 'Camp Area',
      'keywords': ['camp', 'mg road', 'main guard'],
      'bounds': {'lat': 18.5158, 'lng': 73.8567, 'radius': 1.0}
    },
    'shivajinagar': {
      'name': 'Shivajinagar',
      'keywords': ['shivajinagar', 'jm road', 'deccan'],
      'bounds': {'lat': 18.5304, 'lng': 73.8431, 'radius': 1.5}
    },
    'koregaon_park': {
      'name': 'Koregaon Park',
      'keywords': ['koregaon', 'north main road', 'kalyani nagar'],
      'bounds': {'lat': 18.5362, 'lng': 73.8840, 'radius': 2.0}
    },
    'pimpri': {
      'name': 'Pimpri-Chinchwad',
      'keywords': ['pimpri', 'chinchwad', 'pcmc'],
      'bounds': {'lat': 18.6298, 'lng': 73.7997, 'radius': 3.0}
    }
  };

  // Calculate distance between two points
  double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    return Geolocator.distanceBetween(lat1, lng1, lat2, lng2) / 1000; // in km
  }

  // Enhanced location detection with landmark recognition
  String _identifyLandmarkArea(Position position, List<Placemark> placemarks) {
    double lat = position.latitude;
    double lng = position.longitude;

    // Check for nearby landmarks
    for (var area in _puneAreas.entries) {
      double distance = _calculateDistance(
          lat, lng,
          area.value['bounds']['lat'],
          area.value['bounds']['lng']
      );

      if (distance <= area.value['bounds']['radius']) {
        return area.value['name'];
      }
    }

    // Check placemark data for keyword matches
    if (placemarks.isNotEmpty) {
      String fullAddress = placemarks.map((p) =>
      '${p.street ?? ''} ${p.locality ?? ''} ${p.subLocality ?? ''} ${p.administrativeArea ?? ''}'
      ).join(' ').toLowerCase();

      for (var area in _puneAreas.entries) {
        for (String keyword in area.value['keywords']) {
          if (fullAddress.contains(keyword.toLowerCase())) {
            return area.value['name'];
          }
        }
      }
    }

    return '';
  }

  // Enhanced GPS location detection
  Future<void> _getCurrentLocationGPS() async {
    setState(() {
      _isLoadingLocation = true;
      _locationMessage = 'Getting precise location...';
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationMessage = 'Location services disabled. Please enable GPS.';
          _isLoadingLocation = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationMessage = 'Location permission denied.';
            _isLoadingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationMessage = 'Location permission permanently denied. Please enable in settings.';
          _isLoadingLocation = false;
        });
        return;
      }

      // Get high-accuracy position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: Duration(seconds: 15),
      );

      _currentPosition = position;

      // Convert coordinates to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Identify landmark area
      String landmark = _identifyLandmarkArea(position, placemarks);

      String locationText = '';
      if (landmark.isNotEmpty) {
        locationText = landmark;
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          String street = place.street ?? '';
          if (street.isNotEmpty && !landmark.toLowerCase().contains(street.toLowerCase())) {
            locationText = '$street, $landmark';
          }
        }
      } else if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        List<String> addressParts = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea
        ].where((part) => part != null && part.isNotEmpty).cast<String>().toList();

        locationText = addressParts.take(3).join(', ');
      } else {
        locationText = 'Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}';
      }

      setState(() {
        _locationMessage = locationText;
      });

      // Show success message with accuracy
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location detected with ${position.accuracy.round()}m accuracy'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

    } catch (e) {
      setState(() {
        _locationMessage = 'Error getting location: ${e.toString()}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get location. Try IP-based location instead.'),
          backgroundColor: Colors.orange,
          action: SnackBarAction(
            label: 'Try Again',
            onPressed: _getCurrentLocationIP,
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  // Enhanced IP-based location with Pune-specific handling
  Future<void> _getCurrentLocationIP() async {
    setState(() {
      _isLoadingLocation = true;
      _locationMessage = 'Getting approximate location...';
    });

    try {
      final response = await http.get(
        Uri.parse('http://ip-api.com/json?fields=status,city,regionName,country,lat,lon'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          String city = data['city'] ?? '';
          String region = data['regionName'] ?? '';
          String country = data['country'] ?? '';
          double lat = data['lat']?.toDouble() ?? 0.0;
          double lng = data['lon']?.toDouble() ?? 0.0;

          // Create a dummy position for landmark detection
          Position dummyPosition = Position(
            latitude: lat,
            longitude: lng,
            timestamp: DateTime.now(),
            accuracy: 1000.0, // IP-based is less accurate
            altitude: 0.0,
            altitudeAccuracy: 0.0,
            heading: 0.0,
            headingAccuracy: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
          );

          // Check for landmark areas in Pune
          String landmark = '';
          if (city.toLowerCase().contains('pune') || region.toLowerCase().contains('maharashtra')) {
            landmark = _identifyLandmarkArea(dummyPosition, []);
          }

          String locationText = '';
          if (landmark.isNotEmpty) {
            locationText = '$landmark, $city (Approximate)';
          } else {
            locationText = '$city, $region, $country (Approximate)';
          }

          setState(() {
            _locationMessage = locationText;
          });
        } else {
          setState(() {
            _locationMessage = 'Could not determine location from IP.';
          });
        }
      } else {
        setState(() {
          _locationMessage = 'Network error. Check internet connection.';
        });
      }
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  // Show enhanced location options
  void _showLocationOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Location Method', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'We can detect landmarks like "near Marathwada Mitramandal College" or "Karve Nagar" for better location accuracy.',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.blue.shade800),
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.gps_fixed, color: Colors.green),
                title: Text('Precise GPS Location', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                subtitle: Text('Best accuracy, detects nearby landmarks'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getCurrentLocationGPS();
                },
              ),
              ListTile(
                leading: Icon(Icons.wifi, color: Colors.orange),
                title: Text('Approximate Location', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                subtitle: Text('Based on internet connection'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getCurrentLocationIP();
                },
              ),
              ListTile(
                leading: Icon(Icons.edit_location, color: Colors.blue),
                title: Text('Enter Manually', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                subtitle: Text('Type your location or landmark'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showManualLocationDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Enhanced manual location input with suggestions
  void _showManualLocationDialog() {
    TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Location', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'e.g., near Marathwada Mitramandal College, Karve Nagar, FC Road',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 12),
              Text('Popular areas:', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _puneAreas.values.map((area) {
                  return GestureDetector(
                    onTap: () {
                      locationController.text = area['name'];
                    },
                    child: Chip(
                      label: Text(
                        area['name'],
                        style: GoogleFonts.poppins(fontSize: 10),
                      ),
                      backgroundColor: Colors.blue.shade100,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (locationController.text.isNotEmpty) {
                  setState(() {
                    _locationMessage = locationController.text.trim();
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Image processing method (keeping your existing implementation)
  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();

    try {
      setState(() {
        _isProcessingImage = true;
      });

      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
        maxWidth: 1200,
        maxHeight: 1200,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile == null) {
        setState(() {
          _isProcessingImage = false;
        });
        return;
      }

      final imageFile = File(pickedFile.path);

      setState(() {
        _imageFile = imageFile;
        _isProcessingImage = false;
      });

      final fileSize = await imageFile.length();
      final fileSizeKB = (fileSize / 1024).round();

      // ========= Supabase Upload =========
      try {
        final supa = SupabaseService.instance;

        final ext = pickedFile.path.split('.').last;
        final filename = '${DateTime.now().millisecondsSinceEpoch}.$ext';
        final destPath = 'uploads/$filename';

        // Upload to bucket
        final uploadedPath = await supa.uploadImage(
          file: imageFile,
          bucketName: 'sih_images',
        );

        // Get public URL
        final publicUrl = supa.getPublicUrl(
          path: uploadedPath,
          bucketName: 'sih_images',
        );

        // Insert metadata in DB
        await supa.insertImageRecord(
          path: uploadedPath,
          filename: filename,
          bucketName: 'sih_images',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Uploaded! URL: $publicUrl\nSize: ${fileSizeKB}KB'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      // ========= End Supabase Upload =========

    } catch (e) {
      setState(() {
        _isProcessingImage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error capturing image: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Report Issue', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('What type of issue?'),
            _buildIssueTypeSelector(),
            const SizedBox(height: 24),
            _buildSectionTitle('Add Photos'),
            _buildAddPhotos(),
            const SizedBox(height: 24),
            _buildSectionTitle('Location'),
            _buildLocationCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 24),
            _buildSectionTitle('Priority Level'),
            _buildPrioritySelector(),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Issue reported successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Submit Report',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _currentPosition != null ? Colors.green : Colors.green.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _currentPosition != null ? Colors.green : Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _currentPosition != null ? Icons.location_on : Icons.location_off,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentPosition != null ? 'GPS Location Detected' : 'Location',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: _currentPosition != null ? Colors.green.shade800 : Colors.orange.shade800,
                        fontSize: 16,
                      ),
                    ),
                    if (_isLoadingLocation)
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 8),
                          Text('Loading...', style: GoogleFonts.poppins(fontSize: 12)),
                        ],
                      )
                    else
                      Text(
                        _locationMessage,
                        style: GoogleFonts.poppins(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _isLoadingLocation ? null : _showLocationOptions,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Update', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          if (_currentPosition != null)
            Container(
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 16, color: Colors.green.shade700),
                  SizedBox(width: 4),
                  Text(
                    'Accuracy: ±${_currentPosition!.accuracy.round()}m',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Keep all your existing widget methods below
  Widget _buildAddPhotos() {
    return GestureDetector(
      onTap: _isProcessingImage ? null : _pickImageFromCamera,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 6],
        color: _imageFile != null ? Colors.green : Colors.grey,
        strokeWidth: 2,
        child: Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _imageFile != null ? Colors.green.shade50 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _isProcessingImage
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.blue),
              const SizedBox(height: 12),
              Text(
                'Processing image...',
                style: GoogleFonts.poppins(color: Colors.blue, fontWeight: FontWeight.w500),
              ),
            ],
          )
              : _imageFile == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 48),
              const SizedBox(height: 12),
              Text(
                'Tap to add photos',
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Images will be automatically optimized',
                style: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          )
              : Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _imageFile = null;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Retake',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Help Improve Your City', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Report issues and make your community better for everyone', style: GoogleFonts.poppins()),
              ],
            ),
          ),
          const Icon(Icons.lightbulb_circle, color: Colors.blue, size: 36),
        ],
      ),
    );
  }

  Widget _buildIssueTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSelectableCard('Road Issue', Icons.remove_road, 'Road Issue'),
        _buildSelectableCard('Streetlight', Icons.lightbulb_outline, 'Streetlight'),
        _buildSelectableCard('Other', Icons.help_outline, 'Other'),
      ],
    );
  }

  Widget _buildSelectableCard(String title, IconData icon, String value) {
    final bool isSelected = _selectedIssue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIssue = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.blue.shade800 : Colors.grey.shade700),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Describe the issue in detail. What exactly is the problem? When did you notice it?',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      children: [
        _buildPriorityChip('Low', 'Low', Colors.green),
        _buildPriorityChip('Medium', 'Medium', Colors.orange),
        _buildPriorityChip('High', 'High', Colors.red),
      ],
    );
  }

  Widget _buildPriorityChip(String label, String value, Color color) {
    final bool isSelected = _selectedPriority == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? color : Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
              const SizedBox(width: 8),
              Text(label, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}