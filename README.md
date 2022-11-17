# Tugas 8 PBP Gasal 2022/2023

Mayfa Shadrina Siddi
2106634616
PBP F

## Navigator.push & Navigator.pushReplacement

Navigator merupakan widget yang berfungsi untuk melakukan perubahan dari satu screen ke screen lainnya. Navigator mengatur perubahan screen dengan juga menyimpan history perpindahan screen sebelumnya.

### Navigator.push
- Navigator.push berfungsi untuk mengubah tampilan screen dengan menambahkan screen (route) baru ke atas stack navigation
- Navigator.push akan membuat jumlah routing pada stack akan bertambah ketika melakukan push()

### Navigator.pushReplacement
- Navigator.pushReplacement berfungsi untuk melakukan pop() pada route sebelumnya dan melakukan push() pada route baru yang ingin dituju selanjutnya (dilakukan replacement/penggantian screen)

## Widget Tugas 8

### Terdapat di Tugas 7
1. Text = Untuk menampilkan text
2. FloatingActionButton = Untuk menampilkan button yang terletak paling depan dibandingkan elemen-elemen lainnya (float on the screen)
3. Row = Untuk mengatur agar elemen-elemen dapat terkumpul dalam satu row/baris (horizontal array)
4. Column = Untuk mengatur agar elemen-elemen dapat terkumpul dalam satu column/kolom (vertikal array)
5. Padding = Untuk memberikan jarak/whitespace antara widget dengan ujung screen atau antara widget dengan widget lain
6. Center = Untuk memposisikan agar elemen berada di tengah
7. AppBar = Untuk membuat komponen pada suatu app yang berada di paling atas atau paling bawah, yang biasanya berisikan toolbar, text, atau action button lainnya
8. Icon = Untuk menampilkan gambar icon pada suatu elemen (Contoh: button)

### Terdapat di Tugas 8
9. Drawer = Untuk membuat drawer/hamburger menu yang akan menjadi sumber navigasi ke screen lainnya
10. ListTile = Untuk membuat widget yang berbentuk list dan biasa digunakan untuk membuat Vertical Tabs, Checkboxes, atau Radio Buttons
11. Form = Untuk membuat widget berupa container yang akan menampung widget-widget pembentuk form (TextFormField, DropdownButton)
12. TextFormField = Untuk membuat widget pembentuk form yang menerima input Text Field
13. DropdownButton = Untuk membuat widget pembentuk form yang menerima input berdasarkan list item yang sudah ditetapkan dalam bentuk dropdown
14. ListView = Untuk membuat widget yang dapat menampung dan menampilkan widget-widget child-nya yang biasanya digunakan untuk scrolling widget.


## Event

1. onTap = Akan terpanggil ketika user melakukan tap terhadap suatu widget
2. onChanged = Akan terpanggil ketika terdapat perubahan pada value TextField, yaitu ketika dilakukan penambahan/penghapusan text
3. onSaved = Akan terpanggil ketika value final pada widget pembuat form tersimpan melalui FormState.save
4. onPressed = Akan terpanggil ketika user melakukan pressed terhadap suatu widget, biasanya sebuah TextButton

## Cara Kerja Navigator

Pada Flutter, screens atau pages yang dikenal sebagai full-screen elements biasa disebut sebagai routes yang diatur oleh widget Navigator. Navigator akan mengatur stack yang berisikan objek-objek route (halaman yang diakses user) dan menyediakan dua cara pengaturan, yaitu dengan:
1. Declarative API (Navigator.pages)
2. Imperative API (Navigator.push & Navigator.pop)

Navigator akan menampilkan halaman/router yang berada di paling atas stack setelah melakukan Navigator.push (navigasi ke halaman baru). Dengan penggunaan stack, maka user yang ingin kembali ke halaman sebelumnya akan dengan mudah dipenuhi permintaannya oleh program dengan melakukan Navigator.pop karena history dari perpindahan route disimpan oleh widget Navigator. Pada beberapa program akan tersedia button kembali yang akan mempermudah user untuk kembali ke halaman sebelumnya. Namun, di beberapa program juga dapat menggunakan AppBar (Scaffold.appBar yang juga digunakan pada program ini) yang dapat menyedikan button kembali secara automatis untuk navigasi user

## Implementasi Tugas 8

### Menambahkan Drawer

1. Menambahkan widget Drawer pada widget Scaffold pada halaman main
2. Menambahkan tiga tombol navigasi dengan widget ListTile yang akan mengarahkan ke tiga halaman/route berbeda: counter_7 (halaman Counter), Tambah Budget (halaman Form), Data Budget (halaman tampilan data)

```shell
    ...
    drawer: Drawer(
        child: Column(
          children: [
            // Menambahkan clickable menu
            ListTile(
              title: const Text('counter_7'),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Tambah Budget'),
              onTap: () {
                // Route menu ke halaman form
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyFormPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Data Budget'),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyDataPage()),
                );
              },
            ),
          ],
        ),
      ),
    ...
```

### Menambahkan Halaman Form

1. Membuat file baru yang bernama form.dart
2. Menambahkan drawer yang sama dengan file main.dart
3. Menambahkan class Budget dan ListBudget yang akan dipakai untuk penyimpanan data Budget yang diinput

```shell
    ...
    class Budget {
        String judul = "";
        int nominal = 0;
        String jenis = "";

        Budget(String _judul, int _nominal, String _jenis) {
            judul = _judul;
            nominal = _nominal;
            jenis = _jenis;
        }
    }

    class ListBudget {
        static List<Budget> list = [];
    }
    ...
```

4. Menambahkan variabel untuk melakukan penyimpanan data

```shell
    final _formKey = GlobalKey<FormState>();
    String _judul = "";
    int _nominal = 0;
    String _jenisBudget = 'Pengeluaran';
    List<String> listJenisBudget = ['Pengeluaran', 'Pemasukan'];
    ListBudget listBudget = new ListBudget();
```

5. Menambahkan elemen input dengan tipe data String sebagai judul budget

```shell
    Padding(
        // Menggunakan padding sebesar 8 pixels
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            decoration: InputDecoration(
                hintText: "Contoh: Token Listrik",
                labelText: "Judul",
                // Menambahkan circular border agar lebih rapi
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                ),
            ),
            // Menambahkan behavior saat nama diketik
            onChanged: (String? value) {
                setState(() {
                _judul = value!;
                });
            },
            // Menambahkan behavior saat data disimpan
            onSaved: (String? value) {
                setState(() {
                _judul = value!;
                });
            },
            // Validator sebagai validasi form
            validator: (String? value) {
                if (value == null || value.isEmpty) {
                return 'Judul tidak boleh kosong!';
                }
                return null;
            },
        ),
    ),
```

6. Menambahkan elemen input dengan tipe data int sebagai nominal budget

```shell
    Padding(
        // Menggunakan padding sebesar 8 pixels
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            decoration: InputDecoration(
                hintText: "Contoh: 15000",
                labelText: "Nominal",
                // Menambahkan circular border agar lebih rapi
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                ),
            ),
            // Menambahkan behavior saat nama diketik
            onChanged: (String? value) {
                setState(() {
                _nominal = int.parse(value!);
                });
            },
            // Menambahkan behavior saat data disimpan
            onSaved: (String? value) {
                setState(() {
                _nominal = int.parse(value!);
                });
            },
            // Validator sebagai validasi form
            validator: (String? value) {
                if (value == null || value.isEmpty) {
                return 'Nominal tidak boleh kosong!';
                }
                return null;
            },
        ),
    ),
```

7. Menambahkan elemen dropdown dengan tipe budget sebagai dengan pilihan Pemasukan dan Pengeluaran

```shell
    ListTile(
        leading: const Icon(Icons.class_),
        title: const Text(
        'Jenis Budget',
        ),
        trailing: DropdownButton(
        value: _jenisBudget,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: listJenisBudget.map((String items) {
            return DropdownMenuItem(
            value: items,
            child: Text(items),
            );
        }).toList(),
        onChanged: (String? newValue) {
            setState(() {
            _jenisBudget = newValue!;
            });
        },
        ),
    ),
```

8. Menembahkan button untuk menyimpan budget

```shell
    TextButton(
        child: const Text(
        "Simpan",
        style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: () {
        if (_formKey.currentState!.validate()) {
            Budget newBudget =
                new Budget(_judul, _nominal, _jenisBudget);
            ListBudget.list.add(newBudget);
            showDialog(
            context: context,
            builder: (context) {
                return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                ),
                elevation: 15,
                child: Container(
                    child: ListView(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 20),
                    shrinkWrap: true,
                    children: <Widget>[
                        Center(child: const Text('Informasi Data')),
                        SizedBox(height: 20),
                        // TODO: Munculkan informasi yang didapat dari form
                        Center(
                            child:
                                Text('Budget berhasil ditambahkan!')),
                        TextButton(
                        onPressed: () {
                            Navigator.pop(context);
                        },
                        child: Text('Kembali'),
                        ),
                    ],
                    ),
                ),
                );
            },
            );
        }
        },
    ),
```

### Menambahkan Halaman Data Budget

1. Membuat file baru yang bernama data.dart
2. Membuat tampilan card yang berisikan data-data budget dengan widget ListView.builder

```shell
    body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        ListBudget.list[index].judul,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ListBudget.list[index].nominal.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        ListBudget.list[index].jenis,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: ListBudget.list.length,
      ),
```

### Bonus: Membuat file Drawer.dart

1. Membuat file drawer.dart pada folder lib
2. Membuat function Drawer yang akan mereturn drawer yang telah dibuat sebelumnya

```shell
    Drawer makeDrawer(BuildContext context) {
    return Drawer(
        child: Column(
        children: [
            // Menambahkan clickable menu
            ListTile(
            title: const Text('counter_7'),
            onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
            },
            ),
            ListTile(
            title: const Text('Tambah Budget'),
            onTap: () {
                // Route menu ke halaman form
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyFormPage()),
                );
            },
            ),
            ListTile(
            title: const Text('Data Budget'),
            onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyDataPage()),
                );
            },
            ),
        ],
        ),
    );
    }
```

3. Mengubah kode drawer pada file main, form, dan data menjadi makeDrawer(context)

## Referensi

- [Webiste PBP Ganjil 22/23](https://pbp-fasilkom-ui.github.io/ganjil-2023/)
- [ListTile class - Flutter Docs](https://api.flutter.dev/flutter/material/ListTile-class.html)
- [Form class - Flutter Docs](https://api.flutter.dev/flutter/widgets/Form-class.html)
- [ListView class - Flutter Docs](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [onSaved property - Flutter Docs](https://api.flutter.dev/flutter/widgets/FormField/onSaved.html)
- [onPressed property - Flutter Docs](https://api.flutter.dev/flutter/material/TappableChipAttributes/onPressed.html)
- [Navigator class - Flutter Docs](https://api.flutter.dev/flutter/widgets/Navigator-class.html#:~:text=Using%20the%20Navigator%20API&text=In%20Flutter%20these%20elements%20are,push%20and%20Navigator.)