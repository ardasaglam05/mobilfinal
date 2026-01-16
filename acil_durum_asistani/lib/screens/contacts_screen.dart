// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../services/contacts_service.dart';

/// Yakınlar ekranı - Telefon numarası ekleme/listeleme
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final ContactsService _contactsService = ContactsService();
  final TextEditingController _phoneController = TextEditingController();
  List<Map<String, dynamic>> _contacts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  /// Yakınları yükle
  Future<void> _loadContacts() async {
    setState(() => _isLoading = true);
    
    final contacts = await _contactsService.getContacts();
    
    setState(() {
      _contacts = contacts;
      _isLoading = false;
    });
  }

  /// Telefon numarası ekle
  Future<void> _addContact() async {
    final phone = _phoneController.text.trim();
    
    if (phone.isEmpty) {
      _showMessage('Lütfen bir telefon numarası girin', isError: true);
      return;
    }
    
    // Basit validasyon
    if (phone.length < 10) {
      _showMessage('Geçerli bir telefon numarası girin', isError: true);
      return;
    }
    
    await _contactsService.addContact(phone);
    _phoneController.clear();
    
    _showMessage('✓ Yakın eklendi');
    _loadContacts();
  }

  /// Telefon numarası sil
  Future<void> _removeContact(int id) async {
    await _contactsService.removeContact(id);
    _showMessage('Yakın silindi');
    _loadContacts();
  }

  /// Mesaj göster
  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Yakınlarım',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Üst kısım - Numara ekleme
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Acil durumda bilgilendirilecek kişiler',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Telefon numarası input
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Telefon numarası (örn: 05551234567)',
                    prefixIcon: const Icon(Icons.phone, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Ekle butonu
                ElevatedButton.icon(
                  onPressed: _addContact,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'EKLE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Alt kısım - Numara listesi
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _contacts.isEmpty
                    ? _buildEmptyState()
                    : _buildContactsList(),
          ),
        ],
      ),
    );
  }

  /// Boş durum widget'ı
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz yakın eklenmedi',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Yukarıdan telefon numarası ekleyin',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  /// Yakınlar listesi
  Widget _buildContactsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        final phone = contact['phone'] as String;
        final id = contact['id'] as int;
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Icon(
                Icons.person,
                color: Colors.blue.shade700,
              ),
            ),
            title: Text(
              phone,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteDialog(id, phone),
            ),
          ),
        );
      },
    );
  }

  /// Silme onay dialogu
  void _showDeleteDialog(int id, String phone) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yakını Sil'),
        content: Text('$phone numarasını silmek istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İPTAL'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeContact(id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('SİL'),
          ),
        ],
      ),
    );
  }
}
