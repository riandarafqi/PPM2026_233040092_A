import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Catatan {
  final String judul;
  final String isi;
  final String kategori;
  final DateTime dibuatPada;

  Catatan({
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.dibuatPada,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catatan Mahasiswa',
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffe91e63),
        ),

        scaffoldBackgroundColor: const Color(0xfffff0f5),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffe91e63),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tambah':
            return MaterialPageRoute(
              builder: (_) => const TambahCatatanPage(),
            );

          case '/detail':
            final catatan = settings.arguments as Catatan;

            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(
                catatan: catatan,
              ),
            );
        }

        return null;
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Catatan> _catatan = [
    Catatan(
      judul: 'Belajar Flutter',
      isi:
      'Mempelajari StatefulWidget, Form, Navigation, dan Passing Data.',
      kategori: 'Kuliah',
      dibuatPada: DateTime.now(),
    ),
  ];

  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(
      context,
      '/tambah',
    );

    if (hasil is Catatan) {
      setState(() {
        _catatan.add(hasil);
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xffe91e63),
          content: Text(
            'Catatan "${hasil.judul}" berhasil ditambahkan',
          ),
        ),
      );
    }
  }

  void _hapusCatatan(int index) {
    setState(() {
      _catatan.removeAt(index);
    });
  }

  String _formatTanggal(DateTime tanggal) {
    return '${tanggal.day}/${tanggal.month}/${tanggal.year}';
  }

  Color _warnaKategori(String kategori) {
    switch (kategori) {
      case 'Kuliah':
        return Colors.pink;
      case 'Tugas':
        return Colors.deepPurple;
      case 'Pribadi':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Mahasiswa'),
      ),
      body: _catatan.isEmpty
          ? const Center(
        child: Text(
          'Belum ada catatan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: _catatan.length,
        itemBuilder: (context, index) {
          final c = _catatan[index];

          return Container(
            margin: const EdgeInsets.only(
              bottom: 16,
            ),
            child: Material(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(24),
              elevation: 4,
              shadowColor:
              Colors.pink.withOpacity(0.2),
              child: InkWell(
                borderRadius:
                BorderRadius.circular(24),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: c,
                  );
                },
                child: Padding(
                  padding:
                  const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              c.judul,
                              style:
                              const TextStyle(
                                fontSize: 20,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: Color(
                                  0xffc2185b,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                _hapusCatatan(
                                    index),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: _warnaKategori(
                            c.kategori,
                          ).withOpacity(0.15),
                          borderRadius:
                          BorderRadius
                              .circular(30),
                        ),
                        child: Text(
                          c.kategori,
                          style: TextStyle(
                            color:
                            _warnaKategori(
                              c.kategori,
                            ),
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        c.isi,
                        maxLines: 2,
                        overflow:
                        TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                          Colors.grey[700],
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color:
                            Colors.pink[300],
                            size: 18,
                          ),
                          const SizedBox(
                              width: 6),
                          Text(
                            _formatTanggal(
                              c.dibuatPada,
                            ),
                            style: TextStyle(
                              color:
                              Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffe91e63),
        foregroundColor: Colors.white,
        onPressed: _bukaTambahCatatan,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahCatatanPage extends StatefulWidget {
  const TambahCatatanPage({super.key});

  @override
  State<TambahCatatanPage> createState() =>
      _TambahCatatanPageState();
}

class _TambahCatatanPageState
    extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();

  final _judulCtrl = TextEditingController();
  final _isiCtrl = TextEditingController();

  String _kategori = 'Kuliah';

  final List<String> _kategoriList = [
    'Kuliah',
    'Tugas',
    'Pribadi',
    'Lainnya',
  ];

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final catatanBaru = Catatan(
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      dibuatPada: DateTime.now(),
    );

    Navigator.pop(context, catatanBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Catatan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  color:
                  Colors.pink.withOpacity(0.12),
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Tambah Catatan Baru',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[700],
                    ),
                  ),

                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _judulCtrl,
                    decoration: InputDecoration(
                      labelText: 'Judul Catatan',
                      prefixIcon:
                      const Icon(Icons.title),
                      filled: true,
                      fillColor:
                      const Color(0xfffff5f8),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Judul wajib diisi';
                      }

                      if (value.trim().length < 3) {
                        return 'Minimal 3 karakter';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  DropdownButtonFormField<String>(
                    value: _kategori,
                    decoration: InputDecoration(
                      labelText: 'Kategori',
                      prefixIcon: const Icon(
                        Icons.category,
                      ),
                      filled: true,
                      fillColor:
                      const Color(0xfffff5f8),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items:
                    _kategoriList.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _kategori = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 18),

                  TextFormField(
                    controller: _isiCtrl,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Isi Catatan',
                      alignLabelWithHint: true,
                      prefixIcon:
                      const Icon(Icons.notes),
                      filled: true,
                      fillColor:
                      const Color(0xfffff5f8),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Isi wajib diisi';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton.icon(
                      style:
                      FilledButton.styleFrom(
                        backgroundColor:
                        const Color(
                          0xffe91e63,
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),
                      onPressed: _simpan,
                      icon:
                      const Icon(Icons.save),
                      label: const Text(
                        'Simpan Catatan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;

  const DetailCatatanPage({
    super.key,
    required this.catatan,
  });

  Color _warnaKategori(String kategori) {
    switch (kategori) {
      case 'Kuliah':
        return Colors.pink;
      case 'Tugas':
        return Colors.deepPurple;
      case 'Pribadi':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  color:
                  Colors.pink.withOpacity(0.12),
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  catatan.judul,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffc2185b),
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _warnaKategori(
                      catatan.kategori,
                    ).withOpacity(0.15),
                    borderRadius:
                    BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: Text(
                    catatan.kategori,
                    style: TextStyle(
                      color: _warnaKategori(
                        catatan.kategori,
                      ),
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Text(
                  catatan.isi,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.8,
                    color: Colors.grey[800],
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: FilledButton.icon(
                    style:
                    FilledButton.styleFrom(
                      backgroundColor:
                      const Color(
                        0xffe91e63,
                      ),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    label: const Text(
                      'Kembali',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}