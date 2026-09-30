import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const LearningDashboardApp());
}

class LearningDashboardApp extends StatelessWidget {
  const LearningDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Dashboard - Debugging',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

// -------------------------------------------------------------------
// FUNCTION PEMBACA JSON
// -------------------------------------------------------------------
Future<Map<String, dynamic>> loadStudentData({bool simulateError = false}) async {
  await Future.delayed(const Duration(milliseconds: 600));

  // Jalur file JSON
  final String path = simulateError
      ? 'assets/data/salah.json'
      : 'assets/data/student_data.json';

  final jsonString = await rootBundle.loadString(path);
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

// -------------------------------------------------------------------
// WIDGET UTAMA
// -------------------------------------------------------------------
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;
  bool isErrorSimulated = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    setState(() {
      studentFuture = loadStudentData(simulateError: isErrorSimulated);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Dashboard & Debugging'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Panel Simulasi Debugging
            Container(
              color: Colors.amber.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Uji Kasus C (Simulasi Error JSON):',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        value: isErrorSimulated,
                        activeColor: Colors.red,
                        onChanged: (val) {
                          setState(() {
                            isErrorSimulated = val;
                            _fetchData();
                          });
                        },
                      ),
                    ],
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(Icons.info, size: 16, color: Colors.green),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Saya: 2415051011 - Miftah Fadilatus Sakhila - suka bermain musik tradisional maupun modern.',
                          style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // FutureBuilder Dashboard Utama
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: studentFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Colors.green),
                          SizedBox(height: 12),
                          Text('Memuat Learning Dashboard...'),
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 48),
                            const SizedBox(height: 12),
                            Text(
                              'Pesan Error State (Kasus C):\n${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final data = snapshot.data!;
                  final student = data['student'] as Map<String, dynamic>;
                  final courses = data['courses'] as List<dynamic>;

                  final int totalCourses = courses.length;
                  final int totalCredits = courses.fold<int>(
                    0,
                    (sum, item) => sum + ((item['credits'] as num?)?.toInt() ?? 0),
                  );

                  return Column(
                    children: [
                      ProfileCardWidget(student: student),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: SummaryCardWidget(
                                title: 'Total Topik',
                                value: '$totalCourses Kursus',
                                icon: Icons.book_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SummaryCardWidget(
                                title: 'Total SKS',
                                value: '$totalCredits Kredit',
                                icon: Icons.credit_score_outlined,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Daftar Topik Pembelajaran:',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index] as Map<String, dynamic>;
                            return CourseItemCard(course: course);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCardWidget extends StatelessWidget {
  final Map<String, dynamic> student;
  const ProfileCardWidget({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student['name'] as String,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 2),
                  Text('NIM: ${student['nim']}', style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 2),
                  Text(student['semester'] as String? ?? 'Mahasiswa', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseItemCard extends StatelessWidget {
  final Map<String, dynamic> course;
  const CourseItemCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final String status = course['status'] as String? ?? 'planned';
    final String grade = course['grade'] as String? ?? '-';

    Color badgeColor;
    Color textColor;
    IconData statusIcon;

    if (status == 'done') {
      badgeColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
      statusIcon = Icons.check_circle;
    } else if (status == 'active') {
      badgeColor = Colors.orange.shade100;
      textColor = Colors.orange.shade800;
      statusIcon = Icons.play_circle_fill;
    } else {
      badgeColor = Colors.grey.shade200;
      textColor = Colors.grey.shade700;
      statusIcon = Icons.schedule;
    }

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(statusIcon, color: textColor, size: 28),
        title: Text(course['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text('Kode: ${course['code']} • ${course['credits']} SKS • Nilai: $grade', style: const TextStyle(fontSize: 12)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(12)),
          child: Text(status.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor)),
        ),
      ),
    );
  }
}