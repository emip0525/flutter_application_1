// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseFormScreen extends StatefulWidget {
  const CourseFormScreen({super.key});

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _code = '';
  int _credits = 3;

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final newCourse = Course(
          code: _code,
          title: _title,
          credits: _credits,
          status: 'active',
        );

        await Provider.of<CourseProvider>(context, listen: false)
            .createCourse(newCourse);

        if (!mounted) return;
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Course')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (provider.error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(provider.error,
                      style: const TextStyle(color: Colors.red)),
                ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Judul Course'),
                validator: (value) =>
                    value!.isEmpty ? 'Judul tidak boleh kosong' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Kode Course'),
                validator: (value) =>
                    value!.isEmpty ? 'Kode tidak boleh kosong' : null,
                onSaved: (value) => _code = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'SKS'),
                keyboardType: TextInputType.number,
                initialValue: '3',
                onSaved: (value) => _credits = int.parse(value ?? '3'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: provider.isSaving ? null : _saveForm,
                child: provider.isSaving
                    ? const CircularProgressIndicator()
                    : const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}