# Tugas 7 PBP Gasal 2022/2023

Mayfa Shadrina Siddi
2106634616
PBP F

## Stateless & Stateful Widget

State merupakan informasi yang dimiliki oleh sebuah widget yang juga merupakan properti (parameter) dari widget tersebut. State dari sebuah widget dapat berubah, contohnya ketika sebuah RaisedButton yang berubah ketika kita melakukan pressed.

### Stateless Widget
- Stateless Widget merupakan widget yang tidak dapat berubah (immutable), yaitu tampilan dan properti yang dimiliki tidak akan berubah selama widget tersebut digunakan di kondisi apapun.
- Untuk membuat Stateless Widget, kita perlu melakukan override dari method build()
- Contoh: Icon, IconButton, dan Text

### Stateful Widget
- Stateful Widget merupakan widget yang mengubah properti yang dimiliki selama widget tersebut dijalankan. Widget ini bersifat dinamis, mutable, dan dapat berubah berkali-kali selama widget tersebut digunakan.
- Stateful widget dapat mengubah tampilannya berdasarkan event yang dilakukan oleh pengguna, contohnya ketika sebuah widget di-hover atau di-pressed
- Untuk membuat Statedul Widget, kita perlu melakukan override dari method createState(), yang akan me-return state dari widget
- Contoh: Checkbox, Radio Button, Slider, Form, TextField

## Widget Tugas 7
1. Text = Untuk menampilkan text
2. FloatingActionButton = Untuk menampilkan button yang terletak paling depan dibandingkan elemen-elemen lainnya (float on the screen)
3. Row = Untuk mengatur agar elemen-elemen dapat terkumpul dalam satu row/baris (horizontal array)
4. Column = Untuk mengatur agar elemen-elemen dapat terkumpul dalam satu column/kolom (vertikal array)
5. Padding = Untuk memberikan jarak/whitespace antara widget dengan ujung screen atau antara widget dengan widget lain
6. Center = Untuk memposisikan agar elemen berada di tengah
7. AppBar = Untuk membuat komponen pada suatu app yang berada di paling atas atau paling bawah, yang biasanya berisikan toolbar, text, atau action button lainnya
8. Icon = Untuk menampilkan gambar icon pada suatu elemen (Contoh: button)


## Fungsi dari setState()

Method setState() mempunyai fungsi untuk menginformasikan framework FLutter bahwa terdapat perubahan yang dilakukan terhadap properti yang dimiliki sebuah Stateful Widget. Untuk menjalankan perubahan ini, build() method perlu dijalankan ulang sehingga tampilan aplikasi akan berubah. Jika kita tidak menjalankan method setState() ketika mengubah state (contohnya hanya mengubah value dari sebuah variable saja), maka build() method tidaka kan dipanggil dan perubahan tampilan tidak akan dilakukan.

## Perbedaan Antara Const & Final

Walaupun keduanya merupakan modifier yang digunakan untuk membuat value yang konstan terhadap suatu variable, terdapat sedikit perbedaan di antaranya, yaitu berhubungan dengan alokasi memori yang digunakan pada masing-masing modifier.

Pada final variable, memori dialokasikan pada saat runtime, sedangkan pada const variable, memori dialokasikan pada saat compile-time. Karena sebagian besar program kemungkinan memiliki potongan kode yang tidak dijalankan pada kondisi tertentu, maka modifier final pun lebih sering digunakan agar penggunaan memori menjadi lebih kecil (dibandingkan menggunakan modifier const).

Modifier const juga menetapkan semua properti yang dimiliki sebuah object pada saat compile-time, sehingga object akan menjadi "frozen" dan immutable. Selain itu, value yang ditetapkan pada variable const juga tidak bisa sembarangan. Sebuah object const tidak dapat memiliki value yang bisa didapatkan pada saat run-time, sedangkan object final bisa. Contoh: 1 + 2 adalah value object const yang valid, sedangkan DateTime.now() tidak valid.

## Implementasi Tugas 7

### Pembuatan Program Baru counter_7

1. Membuat direktori baru dan menjalankan "flutter create tugas-mae"
2. Membuat repositori baru yang bernama "pbp-flutter-tugas"
3. Membuka file tugas-mae/lib/main.dart

### Implementasi Decrement & Text Ganjil-Genap

1. Menambahkan potongan kode berupa method decrementCounter dengan logic untuk mengurangi jumlah pada counter yang sudah dibuat pada default program

```shell
    void _decrementCounter() {
        setState(() {
        if (_counter > 0) {
            _counter--;
        }
        });
    }
```

2. Mengubah text yang sudah disediakan dengan if-else statement untuk menentukan apakah angka merupakan huruf Ganjil atau Genap

```shell
    children: <Widget>[
    (_counter % 2 == 0)
        ? const Text(
            'GENAP',
            style: TextStyle(color: Colors.red),
            )
        : const Text(
            'GANJIL',
            style: TextStyle(color: Colors.blue),
            ),
    Text(
        '$_counter',
        style: Theme.of(context).textTheme.headline4,
    ),
    ],
```

### Implementasi Tampilan + Bonus

1. Mengubah tampilan button dengan menggunakan widget floatingActionButton, Padding, dan Row dengan propertinya masing-masing. Selain itu, dibuatkan pula if-else statement yang akan memunculkan kedua button (increment & decrement) jika nilai pada counter > 0 dan hanya memunculkan satu button (increment) jika nilai pada counter == 0

```shell
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: (_counter > 0)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    FloatingActionButton(
                    onPressed: _decrementCounter,
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                    ),
                    FloatingActionButton(
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                    ),
                ])
            : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
                ),
            ])),
    ;
```