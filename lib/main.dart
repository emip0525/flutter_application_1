
import 'package:flutter/material.dart';

void main() {
  runApp(const LearningDashboardApp());
}

// ============================================================
// IDENTITAS MAHASISWA
// ============================================================

const String studentName = 'Miftah Fadilatus Sakhila';
const String studentId = '2415051011';

// ============================================================
// MODEL COURSE
// ============================================================

class Course {
  final String code;
  final String title;
  final int credits;
  final String status;
  final String description;
  bool isFavorite;

  Course({
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
    required this.description,
    this.isFavorite = false,
  });
}

// ============================================================
// DATA COURSE
// ============================================================

final List<Course> courseList = [
  Course(
    code: 'MOB01',
    title: 'Git & GitHub',
    credits: 2,
    status: 'Done',
    description:
        'Mempelajari repository, commit, branch, dan kolaborasi '
        'menggunakan Git dan GitHub.',
  ),
  Course(
    code: 'MOB02',
    title: 'Dart Fundamentals',
    credits: 2,
    status: 'Done',
    description:
        'Mempelajari variabel, fungsi, class, collection, dan '
        'dasar pemrograman menggunakan Dart.',
  ),
  Course(
    code: 'MOB03',
    title: 'Flutter UI Fundamentals',
    credits: 3,
    status: 'Active',
    description:
        'Mempelajari widget, layout, tema, dan pembuatan '
        'antarmuka aplikasi menggunakan Flutter.',
  ),
  Course(
    code: 'MOB04',
    title: 'Responsive Layout',
    credits: 3,
    status: 'Active',
    description:
        'Mempelajari LayoutBuilder, Expanded, Flexible, GridView, '
        'dan tampilan responsif.',
  ),
  Course(
    code: 'MOB05',
    title: 'Navigation',
    credits: 2,
    status: 'Planned',
    description:
        'Mempelajari navigasi antarhalaman dan passing data '
        'menggunakan constructor.',
  ),
  Course(
    code: 'MOB06',
    title: 'Interaction',
    credits: 2,
    status: 'Planned',
    description:
        'Mempelajari favorite, tombol, Dialog, SnackBar, dan '
        'validasi form.',
  ),
];

// ============================================================
// APLIKASI UTAMA
// ============================================================

class LearningDashboardApp extends StatelessWidget {
  const LearningDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer - Debugging Challenge',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F8F4),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E7D32),
          foregroundColor: Colors.white,
        ),
      ),
      home: const ResponsiveShell(),
    );
  }
}

// ============================================================
// RESPONSIVE SHELL
// NavigationBar untuk compact/medium,
// NavigationRail untuk expanded.
// ============================================================

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    CoursesPage(),
    ProfilePage(),
    DebuggingPage(),
  ];

  final List<String> titles = const [
    'Course Explorer',
    'Explore Courses',
    'Profil Mahasiswa',
    'Debugging Challenge',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isExpanded = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(
            title: Text(titles[selectedIndex]),
          ),
          body: Row(
            children: [
              if (isExpanded)
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: const Color(0xFFE8F5E9),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bug_report_outlined),
                      selectedIcon: Icon(Icons.bug_report),
                      label: Text('Debugging'),
                    ),
                  ],
                ),
              if (isExpanded)
                const VerticalDivider(width: 1),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: pages,
                ),
              ),
            ],
          ),
          bottomNavigationBar: isExpanded
              ? null
              : NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: 'Courses',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.bug_report_outlined),
                      selectedIcon: Icon(Icons.bug_report),
                      label: 'Debugging',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

// ============================================================
// REUSABLE WIDGET: IDENTITAS MAHASISWA
// ============================================================

class StudentIdentityCard extends StatelessWidget {
  const StudentIdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(
                Icons.school,
                color: Color(0xFF2E7D32),
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studentName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('NIM: $studentId'),
                  SizedBox(height: 4),
                  Text(
                    'Mahasiswa',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final totalCredits = courseList.fold<int>(
      0,
      (sum, course) => sum + course.credits,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.explore,
                      size: 40,
                      color: Color(0xFF2E7D32),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome to Course Explorer!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Jelajahi mata kuliah dan pelajari '
                      'contoh perbaikan error layout Flutter.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const StudentIdentityCard(),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns =
                      constraints.maxWidth >= 600 ? 3 : 2;

                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: [
                      SummaryCard(
                        title: 'Mata Kuliah',
                        value: '${courseList.length}',
                        icon: Icons.menu_book,
                      ),
                      SummaryCard(
                        title: 'Total SKS',
                        value: '$totalCredits',
                        icon: Icons.school,
                      ),
                      SummaryCard(
                        title: 'Favorit',
                        value:
                            '${courseList.where((c) => c.isFavorite).length}',
                        icon: Icons.favorite,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Contoh teks panjang — Kasus A',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const OverflowFixedRow(),
              const SizedBox(height: 20),
              const Text(
                'Mata Kuliah Pilihan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...courseList.take(3).map(
                    (course) => CourseCard(course: course),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// REUSABLE WIDGET: SUMMARY CARD
// ============================================================

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 27,
              color: const Color(0xFF2E7D32),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// KASUS A: RENDERFLEX OVERFLOW
// Expanded memberi batas lebar untuk teks.
// ============================================================

class OverflowFixedRow extends StatelessWidget {
  const OverflowFixedRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info_outline,
              color: Color(0xFF2E7D32),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                '$studentId - $studentName - teks sangat panjang '
                'untuk menguji perbaikan RenderFlex overflow pada '
                'Row di Flutter.',
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// COURSES PAGE
// Kasus B: ListView diberi batas tinggi melalui Expanded.
// ============================================================

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final TextEditingController searchController =
      TextEditingController();

  String searchText = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCourses = courseList.where((course) {
      final query = searchText.toLowerCase();

      return course.title.toLowerCase().contains(query) ||
          course.code.toLowerCase().contains(query) ||
          course.status.toLowerCase().contains(query);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Cari mata kuliah...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${filteredCourses.length} mata kuliah ditemukan',
            ),
          ),
          const SizedBox(height: 8),

          // FIX KASUS B:
          // Expanded memberikan tinggi terbatas kepada ListView.
          Expanded(
            child: filteredCourses.isEmpty
                ? const Center(
                    child: Text('Mata kuliah tidak ditemukan.'),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final columns =
                          constraints.maxWidth >= 840
                              ? 3
                              : constraints.maxWidth >= 600
                                  ? 2
                                  : 1;

                      return GridView.builder(
                        itemCount: filteredCourses.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          mainAxisExtent: 155,
                        ),
                        itemBuilder: (context, index) {
                          return CourseCard(
                            course: filteredCourses[index],
                            onFavoriteChanged: () {
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// COURSE CARD DAN PENCEGAHAN NAVIGASI GANDA
// ============================================================

class CourseCard extends StatefulWidget {
  final Course course;
  final VoidCallback? onFavoriteChanged;

  const CourseCard({
    super.key,
    required this.course,
    this.onFavoriteChanged,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  // KASUS D: mencegah navigasi detail dipanggil berulang.
  bool _isOpening = false;

  Future<void> _openDetail() async {
    if (_isOpening) return;

    setState(() {
      _isOpening = true;
    });

    try {
      await Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (context) => CourseDetailPage(
            course: widget.course,
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isOpening = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _isOpening ? null : _openDetail,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(
                  Icons.menu_book,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${course.code} • ${course.credits} SKS',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      course.status,
                      style: const TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Favorit',
                    onPressed: () {
                      setState(() {
                        course.isFavorite = !course.isFavorite;
                      });

                      widget.onFavoriteChanged?.call();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            course.isFavorite
                                ? '${course.title} ditambahkan ke favorit.'
                                : '${course.title} dihapus dari favorit.',
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      course.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: course.isFavorite
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                  if (_isOpening)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// COURSE DETAIL PAGE: PASSING DATA MELALUI CONSTRUCTOR
// ============================================================

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentIdentityCard(),
                const SizedBox(height: 20),
                const Icon(
                  Icons.menu_book,
                  size: 55,
                  color: Color(0xFF2E7D32),
                ),
                const SizedBox(height: 16),
                Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(course.description),
                const SizedBox(height: 20),
                DetailRow(
                  label: 'Kode',
                  value: course.code,
                ),
                DetailRow(
                  label: 'SKS',
                  value: '${course.credits}',
                ),
                DetailRow(
                  label: 'Status',
                  value: course.status,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () {
                    course.isFavorite = !course.isFavorite;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          course.isFavorite
                              ? 'Course ditambahkan ke favorit.'
                              : 'Course dihapus dari favorit.',
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    course.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  label: Text(
                    course.isFavorite
                        ? 'Hapus dari Favorit'
                        : 'Tambah ke Favorit',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE PAGE DAN FORM FEEDBACK
// KASUS C: FORM DAPAT DI-SCROLL SAAT KEYBOARD MUNCUL.
// ============================================================

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();

  final nameController =
      TextEditingController(text: studentName);

  final nimController =
      TextEditingController(text: studentId);

  final feedbackController = TextEditingController();

  bool isLoading = false;
  String? submittedFeedback;

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  Future<void> submitFeedback() async {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Periksa kembali form feedback.'),
        ),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text(
            'Apakah kamu yakin ingin mengirim feedback?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) return;

    setState(() {
      isLoading = true;
      submittedFeedback = null;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      isLoading = false;
      submittedFeedback = feedbackController.text.trim();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback berhasil dikirim!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // KASUS C:
      // Scaffold mengubah ukuran body saat keyboard muncul.
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          // Memberi ruang tambahan saat keyboard terbuka.
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StudentIdentityCard(),
                  const SizedBox(height: 20),
                  const Text(
                    'Feedback Form',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nama dan NIM digunakan untuk identitas '
                    'pengirim feedback.',
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              enabled: !isLoading,
                              decoration: const InputDecoration(
                                labelText: 'Nama Mahasiswa',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'Nama wajib diisi.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: nimController,
                              enabled: !isLoading,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'NIM',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.badge),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'NIM wajib diisi.';
                                }

                                if (!RegExp(r'^\d+$')
                                    .hasMatch(value.trim())) {
                                  return 'NIM harus berupa angka.';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: feedbackController,
                              enabled: !isLoading,
                              minLines: 3,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              decoration: const InputDecoration(
                                labelText: 'Feedback',
                                hintText: 'Tulis feedback di sini...',
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'Feedback wajib diisi.';
                                }

                                if (value.trim().length < 5) {
                                  return 'Minimal 5 karakter.';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: isLoading
                                    ? null
                                    : submitFeedback,
                                icon: isLoading
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.send),
                                label: Text(
                                  isLoading
                                      ? 'Mengirim...'
                                      : 'Kirim Feedback',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (submittedFeedback != null) ...[
                    const SizedBox(height: 16),
                    Card(
                      color: const Color(0xFFE8F5E9),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Feedback Terkirim',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(submittedFeedback!),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN DEMO DEBUGGING
// ============================================================

class DebuggingPage extends StatelessWidget {
  const DebuggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StudentIdentityCard(),
              const SizedBox(height: 20),
              const Text(
                'Tahap 16: Debugging Challenge',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const DebugCaseCard(
                title: 'Kasus A - RenderFlex overflow',
                description:
                    'Teks panjang diletakkan di dalam Expanded '
                    'agar Row mengetahui batas lebar teks.',
                icon: Icons.text_fields,
              ),
              const DebugCaseCard(
                title: 'Kasus B - Unbounded height',
                description:
                    'ListView diletakkan di dalam Expanded '
                    'agar mendapatkan batas tinggi yang jelas.',
                icon: Icons.view_list,
              ),
              const DebugCaseCard(
                title: 'Kasus C - Keyboard overflow',
                description:
                    'Form menggunakan SingleChildScrollView, '
                    'SafeArea, dan resizeToAvoidBottomInset.',
                icon: Icons.keyboard,
              ),
              const DebugCaseCard(
                title: 'Kasus D - Navigasi ganda',
                description:
                    'Flag _isOpening mencegah pengguna memulai '
                    'navigasi detail berulang sebelum route selesai.',
                icon: Icons.navigation,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Debugging Challenge berhasil diuji.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Uji SnackBar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DebugCaseCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const DebugCaseCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: const Color(0xFF2E7D32),
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}