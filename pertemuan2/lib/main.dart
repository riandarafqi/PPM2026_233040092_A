import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TUGAS 2: Ubah theme color Scaffold menjadi warna soft [cite: 1018]
      backgroundColor: const Color(0xFFF4F6F9),

      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text('Beranda')),
            const ListTile(leading: Icon(Icons.person), title: Text('Profil')),
            // TUGAS 5: Saat "Pengaturan" ditekan, tampilkan AlertDialog [cite: 1021]
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer dulu
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text('Menu pengaturan sedang dalam perbaikan.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // === HEADER PROFIL ===
            Center(
              child: Column(
                children: [
                  // TUGAS 1: Ganti CircleAvatar agar menampilkan foto (pakai NetworkImage) [cite: 1017]
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/9919?v=4'), // Ganti link foto ini!
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Rafqi', // Ganti namamu
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mahasiswa Teknik Informatika',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // === BARIS STATISTIK ===
            const Row(
              children: [
                Expanded(child: StatBox(label: 'Post', value: '12')),
                Expanded(child: StatBox(label: 'Teman', value: '128')),
                Expanded(child: StatBox(label: 'Like', value: '1.2K')),
              ],
            ),
            const SizedBox(height: 24),

            // === SECTION CARD ===
            const SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content: 'Saya suka belajar hal baru, terutama yang berkaitan dengan teknologi dan pengembangan aplikasi mobile.',
            ),
            const SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: 'Universitas XYZ - Semester 5\nIPK: 3.75',
            ),

            // TUGAS 3: Tambahkan Section Card ke-5 berjudul "Skills" dengan isi Wrap 5 Chip [cite: 1019]
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.blue, size: 28),
                        SizedBox(width: 16),
                        Text(
                          'Skills',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        Chip(label: Text('Flutter')),
                        Chip(label: Text('Dart')),
                        Chip(label: Text('Java')),
                        Chip(label: Text('UI/UX')),
                        Chip(label: Text('Problem Solving')),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80), // Ruang agar FAB tidak nutupi konten
          ],
        ),
      ),

      // TUGAS 4: Saat FAB ditekan, tampilkan SnackBar [cite: 1020]
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Edit profil belum tersedia')),
          );
        },
        child: const Icon(Icons.edit),
      ),

      // TUGAS 6 (BONUS): Ganti BottomNavigationBar menjadi NavigationBar [cite: 1022]
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (int index) {
          // Logika navigasi nanti ditambahkan di pertemuan selanjutnya
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.message), label: 'Pesan'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}

// === HELPER WIDGETS ===
class StatBox extends StatelessWidget {
  final String label;
  final String value;

  const StatBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const SectionCard({super.key, required this.icon, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(content, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}