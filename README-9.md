# Tugas 9 PBP Gasal 2022/2023

Mayfa Shadrina Siddi
2106634616
PBP F

## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?

Ya, hal tersebut dapat dilakukan. Terkadang, ketika kita mau mengambil data yang membutuhkan JSON response yang kompleks, cukup sulit pagi programmer untuk membuat model yang dapat men-support pengambilan data tersebut sehingga pembuatan model tidak dilakukan. 

Namun, hal tersebut tidak lebih baik daripada membuat model karena dengan membuat model, kita dapat menggunakan model tersebut sebagai class sehingga data yang diambil dapat memiliki struktur yang lebih baik dan mudah untuk digunakan atau di-olah. Dengan kata lain, pembuatan model sebelum melakukan pengambilan data JSON lebih baik jika dibandingkan dengan tidak membuat model.

## Widget Tugas 8

### Terdapat di Tugas 7 & 8
1. Text = Untuk menampilkan text
2. FloatingActionButton = Untuk menampilkan button yang terletak paling depan dibandingkan elemen-elemen lainnya (float on the screen)
3. Row = Untuk mengatur agar elemen-elemen dapat terkumpul dalam satu row/baris (horizontal array)
4. Column = Untuk mengatur agar elemen-elemen dapat terkumpul dalam satu column/kolom (vertikal array)
5. Padding = Untuk memberikan jarak/whitespace antara widget dengan ujung screen atau antara widget dengan widget lain
6. Center = Untuk memposisikan agar elemen berada di tengah
7. AppBar = Untuk membuat komponen pada suatu app yang berada di paling atas atau paling bawah, yang biasanya berisikan toolbar, text, atau action button lainnya
8. Drawer = Untuk membuat drawer/hamburger menu yang akan menjadi sumber navigasi ke screen lainnya
9. ListTile = Untuk membuat widget yang berbentuk list dan biasa digunakan untuk membuat Vertical Tabs, Checkboxes, atau Radio Buttons

### Terdapat di Tugas 9

10. FutureBuilder = Untuk membuat widget yang akan digunakan ketika kita mengambil data secara asynchronous
11. SizedBox = Untuk membuat sebuha box (kotak) dengan ukuran yang spesifik
12. ElevatedButton = Untuk membuat button yang terkesan "mengambang" atau terelevasi
13. Navigator = Untuk mengimplementasikan stack pada screen aplikasi sehingga dapat berpindah-pindah screen dengan terstruktur

## Implementasi Tugas 8

### Menambahkan Drawer

1. Menambahkan widget ListTile pada widget Drawer pada halaman drawer.dart untuk mengarahkan page ke halaman My Watchlist

```shell
    ListTile(
        title: const Text('My Watchlist'),
        onTap: () {
            // Route menu ke halaman to do
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ToDoPage()),
            );
        },
    ),
```

### Membuat Model MyWatchlist

1. Membuat file baru yang menyimpan model MyWatchlist yaitu watchlist.dart
2. Menggunakan https://app.quicktype.io/ untuk menyesuaikan data JSON pada model yang digunakan dalam Dart
3. Menyalin kode yang telah digenerate oleh link ke file watchlist.dart

```shell
    import 'dart:convert';

    List<WatchList> watchListFromJson(String str) =>
        List<WatchList>.from(json.decode(str).map((x) => WatchList.fromJson(x)));

    String watchListToJson(List<WatchList> data) =>
        json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

    class WatchList {
    bool watched;
    String title;
    int rating;
    String releaseDate;
    String review;

    WatchList({
        required this.watched,
        required this.title,
        required this.rating,
        required this.releaseDate,
        required this.review,
    });

    factory WatchList.fromJson(Map<String, dynamic> json) => WatchList(
        watched: json["fields"]["watched"],
        title: json["fields"]["title"],
        rating: json["fields"]["rating"],
        releaseDate: json["fields"]["release_date"],
        review: json["fields"]["review"]);

    Map<String, dynamic> toJson() => {
            "watched": watched,
            "title": title,
            "rating": rating,
            "releaseDate": releaseDate,
            "review": review
        };
    }
```

4. Melakukan perintah `flutter pub add http` pada terminal
5. Menambahkan kode `<uses-permission android:name="android.permission.INTERNET" />` pada Android file `android/app/src/main/AndroidManifest.xml`

### Menampilkan Data Pada Page

1. Membuat file dart baru yang bernama watchlist_page.dart
2. Mengimport file-file dart yang dibutuhkan

```shell
    import 'package:counter_7/page/watchlist_details.dart';
    import 'package:http/http.dart' as http;
    import 'dart:convert';
    import 'package:counter_7/model/watchlist.dart';
    import 'package:flutter/material.dart';
    import 'package:counter_7/page/drawer.dart';
```

3. Menambahkan kode pada file watchlist_page.dart untuk mengambil data dari file JSOn yang telah dipublish pada Tugas 3 dan menampilkan judul film-nya pada page tersebut

```shell
    class ToDoPage extends StatefulWidget {
    const ToDoPage({Key? key}) : super(key: key);

    @override
    _ToDoPageState createState() => _ToDoPageState();
    }

    class _ToDoPageState extends State<ToDoPage> {
    Future<List<WatchList>> fetchToDo() async {
        var url = Uri.parse('https://tugas2-mayfa.herokuapp.com/mywatchlist/json/');
        var response = await http.get(
        url,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
        },
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object ToDo
        List<WatchList> listToDo = [];
        for (var d in data) {
        if (d != null) {
            listToDo.add(WatchList.fromJson(d));
        }
        }

        return listToDo;
    }

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return Scaffold(
            appBar: AppBar(
            title: const Text('My Watchlist'),
            ),
            drawer: makeDrawer(context),
            body: FutureBuilder(
                future: fetchToDo(),
                builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return Column(
                        children: const [
                        Text(
                            "Tidak ada watchlist :(",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                    } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 2.0)
                                    ]),
                                child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 7),
                                child: ListTile(
                                    title: Text("${snapshot.data![index].title}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    onTap: () {
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WatchlistDetail(
                                                    watchList:
                                                        snapshot.data![index],
                                                )),
                                        );
                                    }),
                                ),
                            ));
                    }
                }
                }));
    }
    }
```

4. Membuat file dart watchlist_details.dart untuk menampilakn halaman detail film
5. Melakukan import model dan file-file lain yang dibutuhkan

```shell
    import 'package:flutter/material.dart';
    import 'package:counter_7/page/drawer.dart';
    import 'package:counter_7/model/watchlist.dart';
```

6. Menambahkan widget-widget yang dibutuhkan, sesuai dengan tampilan yang diinginkan

```shell
    class WatchlistDetail extends StatelessWidget {
    final WatchList watchList;
    const WatchlistDetail({super.key, required this.watchList});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
            title: const Text('My Watchlist'),
            ),
            drawer: makeDrawer(context),
            body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
                children: [
                Center(
                    child: Text(
                    watchList.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                ),
                const SizedBox(
                    height: 8,
                ),
                Row(
                    children: [
                    const Text(
                        "Release Date:  ",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        watchList.releaseDate,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                    )
                    ],
                ),
                const SizedBox(
                    height: 8,
                ),
                Row(
                    children: [
                    const Text(
                        "Rating:  ",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        watchList.rating.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                    )
                    ],
                ),
                const SizedBox(
                    height: 8,
                ),
                Row(
                    children: [
                    const Text(
                        "Status:  ",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        watchList.watched ? "Watched" : "Not Watched Yet",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                    )
                    ],
                ),
                const SizedBox(
                    height: 8,
                ),
                Row(
                    children: [
                    const Text(
                        "Review:  ",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        watchList.review,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                    )
                    ],
                ),
                const Spacer(),
                TextButton(
                    child: const Text(
                    "Kembali",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                    Navigator.pop(context);
                    },
                ),
                ],
            ),
            ));
    }
    }
```

7. Menambahkan kode onTap pada card yang dibuat agar screen dapat berubah menjadi screen detail film

```shell
    title: Text("${snapshot.data![index].title}",
        ...
    onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WatchlistDetail(
                    watchList:
                        snapshot.data![index],
                )),
        );
    }),
    ...
```

8. Menambahkan button Kembali dari halaman detail ke halaman list My Watchlist

```shell
    TextButton(
        child: const Text(
            "Kembali",
            style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: () {
            Navigator.pop(context);
        },
    ),
```

## Referensi

- [Website PBP Ganjil 22/23](https://pbp-fasilkom-ui.github.io/ganjil-2023/)
- [Fetch data from the internet - Flutter Docs](https://docs.flutter.dev/cookbook/networking/fetch-data)
- [Fetch data dynamically - Dart Docs](https://dart.dev/tutorials/web/fetch-data)
- [FutureBuilder<T> class - Flutter Docs](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
- [Future<T> class - Flutter Docs](https://api.flutter.dev/flutter/dart-async/Future-class.html)
- [SizedBox class - Flutter Docs](https://api.flutter.dev/flutter/widgets/SizedBox-class.html)
- [Navigator class - Flutter Docs](https://api.flutter.dev/flutter/widgets/Navigator-class.html#:~:text=Using%20the%20Navigator%20API&text=In%20Flutter%20these%20elements%20are,push%20and%20Navigator.)
- [ElevatedButton class - Flutter Docs](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)