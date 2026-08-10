import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

double hitungTotal(int jumlah, double harga){
  return jumlah * harga;
}
double hitungHargaAkhir(double total, double persenPotongan){
  return total - (total * persenPotongan / 100);
}
double hitungHarga(bool anggota, double hAnggota, double hUmum) {
  return anggota ? hAnggota : hUmum;
}
// Logika lebih terpusat disatu tempat, jika nanti perlu pembaruan kode
// cukup bagian ini saja yamg diganti dan juga mencegah kesalahan kode yang ditulis
// berulang seperti percabangan if-else.
double bayarAkhir(int jumlah, double harga, double persenPotongan){
  double totalAwal = hitungTotal(jumlah, harga);
  return hitungHargaAkhir(totalAwal, persenPotongan);
}
class Barang {
  // Atribut
  String nama;
  double harga;
  int stok;
  // Konstruktor
  Barang({
    required this.nama,
    required this.harga,
    required this.stok,
  });
  // Method 1
  double hitungTotalNilaiStok(){
    return harga * stok;
  }
  // Method 2
  bool isStokMenipis(){
    return stok < 5;
  }
  // Method 3
  void tampilkan(){
    debugPrint('=====Kartu Data Barang=====');
    debugPrint('Nama  : $nama');
    debugPrint('Harga : $harga');
    debugPrint('Stok  : $stok');
  }
}
void main() {
  // Memformat mata uang rupiah indonesia pemisah ribuan yaitu titik 
  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',  // Menggunakan standar pemisah ribuan di Indonesia
    symbol: 'Rp. ',   // Digunakan sebagi simbol mata uang dan ditampilkan sebelum angka
    decimalDigits: 2, // Digunakan untuk menampilkan angka desimal
  );

  // LOGIKA DATA BARANG & PERHITUNGAN TRANSAKSI
  String kategori = "makanan";
  String namaBarang;
  String lokasiRak;

  switch (kategori.toLowerCase()) {
  case "atk":
    namaBarang = "Buku Tulis";
    lokasiRak = "Rak 1";
    break;

  case "makanan":
    namaBarang = "Roti";
    lokasiRak = "Rak 2";
    break;

  case "minuman":
    namaBarang = "Es Teh";
    lokasiRak = "Rak 3";
    break;
  default:
    namaBarang = "Barang Umum";
    lokasiRak = "Rak Lain";
  }
  // Switch disini lebih rapi daripada if-else karena memang hanya
  // dikhususkan untuk memerikasa nilai pasti. Misal disini saya ingin menampilkan
  // minuman, maka program akan langsung pergi ke case yang sesuai tanpa perlu cek
  // satu persatu seperti saat menggunakan if-else.  

  double hargaAnggota = 10000.00;
  double hargaUmum = 10500.00;

  int stok = 3;
  // Transaksi Pembelian
  int jumlahBeli = 1 ;
  
  if(jumlahBeli <= 0){
    debugPrint("Jumlah Pembelian Tidak Boleh Kurang Dari 0!");
    return;
  }
  if(jumlahBeli > stok ){
    debugPrint("Stok Tidak Cukup! Jumlah Pembelian : $jumlahBeli, Stok : $stok");
    return;
  }

  debugPrint('====Informasi stok penjualan====');
  while (stok >= jumlahBeli){
    stok--;
    debugPrint('Terjual 1, sisa stok : $stok');
  }
  bool isTersedia = stok > 0;

  // Bila kondisi berhenti pada while keliru bisa menyebabkan
  // perulangan yang tak berhenti. Solusinya adalah mengatur 
  // kembali kondisi perulangan while menjadi jika stok
  // lebih dari sama dengan jumlah beli, maka perulangan
  // bisa dilakukan. Namun jika jumlah beli yang lebih
  // banyak maka perulangan tidak akan dilakukan.

  bool isAnggota = true ; //Bisa diganti false untuk hargaUmum
  double hargaSatuan = hitungHarga(isAnggota, hargaAnggota, hargaUmum);
  //if (isAnggota) {
  //  hargaSatuan = hargaAnggota;
  //} else {
  //  hargaSatuan = hargaUmum;
  //}

  // Perhitungan
  double totalAwal = hitungTotal(jumlahBeli, hargaSatuan);

  double persentaseDiskon = 0.0;
  if (isAnggota && totalAwal > 500000){
    persentaseDiskon = 15.0;
  } else if (totalAwal > 200000) {
    persentaseDiskon = 10.0;
  } else if (totalAwal > 100000) {
    persentaseDiskon = 5.0;
  } else {
    persentaseDiskon = 0.0;   
  }

  double hargaAkhir = hitungHargaAkhir(totalAwal, persentaseDiskon);
  double nilaiPotongan = totalAwal - hargaAkhir;
  List <Barang> daftarBarang = [
    Barang(nama: 'Buku Tulis', harga: 3000.0, stok: 10),
    Barang(nama: 'Pensil', harga: 2500.0, stok: 15),
    Barang(nama: 'Roti', harga: 5000.0, stok: 3),
    Barang(nama: 'Es Teh', harga: 6000.0, stok: 2),
  ];
  // Memanggil method tampilkan dan memangambil data barang di list daftar barang
  for (var barang in daftarBarang) {
    barang.tampilkan();
  }
  debugPrint('========Laporan Stok Menipis========');
  for(var barang in daftarBarang){
    if(barang.isStokMenipis()){
      String hargaFormatted = currencyFormat.format(barang.harga);
    
    debugPrint('Stok hampir habis, Nama : ${barang.nama} | Sisa stok : ${barang.stok} | Harga : $hargaFormatted');
    }
  }
  debugPrint('=========================================');
  double totalNilaiStok = 0.0;
  for(int i = 0; i < daftarBarang.length; i++){
    var barang = daftarBarang[i];

    double subtotalStok = barang.hitungTotalNilaiStok();
    totalNilaiStok += subtotalStok;

    String hargaFormatted = currencyFormat.format(barang.harga);
    String subtotalFormatted = currencyFormat.format(subtotalStok);

    debugPrint("${i+1}. ${barang.nama} - $hargaFormatted Stok : ${barang.stok} (Total : $subtotalFormatted)" );
  }
  debugPrint("=========================================");
  debugPrint("Total Nilai Seluruh Stok : ${currencyFormat.format(totalNilaiStok)}");
  debugPrint("=========================================");
  //for (int i = 0; i < daftarBarang.length; i++) {
  //  if (daftarStok[i] < 5) {
  //    String nama = daftarBarang[i];
  //    int stokBarang = daftarStok[i];
  //    String hargaFormatted = currencyFormat.format(daftarHarga[i]);
  //
  //  debugPrint("Stok Hampir Habis, Nama : $nama | Sisa Stok : $stokBarang | Harga : $hargaFormatted");
  //}
  //}
  //double totalNilaiStok = 0.0;
  //debugPrint('========Informasi Barang========');
  //for (int i = 0; i < daftarBarang.length; i++){
  //  String nama = daftarBarang[i];
  //  double harga = daftarHarga[i];
  //  int stokBarang = daftarStok[i];

    // Hitung total nilai stok per jenis barang
  //  double subtotalStok = harga * stokBarang;

    // Menambahkan nilai ke total keseluruhan
  //  totalNilaiStok += subtotalStok;

  //  String hargaFormatted = currencyFormat.format(harga);
  //  String subtotalFormatted = currencyFormat.format(subtotalStok);
    
  //  debugPrint("${i + 1}. $nama - $hargaFormatted | Stok: $stokBarang (Total: $subtotalFormatted)",);
  //}
  //debugPrint("=========================================");
  //debugPrint(
  //  "Total Nilai Seluruh Stok : ${currencyFormat.format(totalNilaiStok)}",
  //);
  //debugPrint("=========================================");

  double totalTranskasi = hitungTotal(jumlahBeli, hargaSatuan);
  debugPrint('Jumlah Beli : $jumlahBeli');
  debugPrint('Harga       : $hargaSatuan');
  debugPrint('Total Harga : ${currencyFormat.format(totalTranskasi)}');
  debugPrint('=========================================');

  debugPrint("=== Harga AKhir ===");
  debugPrint("Total Awal         : ${currencyFormat.format(totalAwal)}");
  debugPrint("Potongan           : ${persentaseDiskon.toInt()}% (${currencyFormat.format(nilaiPotongan)})");
  debugPrint("Harga akhir        : ${currencyFormat.format(hargaAkhir)}");

  double totalPembayaran = bayarAkhir(jumlahBeli, hargaSatuan, persentaseDiskon);
  debugPrint("Total Pembayaran   : ${currencyFormat.format(totalPembayaran)}");


  if (jumlahBeli <= 0 || totalAwal <= 0) {
  // Muncul ketika input yang dimasukkan salah
  debugPrint("TRANSAKSI TIDAK VALID!");
  debugPrint("Jumlah beli atau total tidak boleh 0 atau negatif.");
  } else {  
  debugPrint("Memproses Transaksi");
  // Cetak ke Debug Console
  debugPrint("======= KARTU DATA BARANG =======");

  // Status pembeli berubah tergantung nilai variabel bool isAnggota
  debugPrint("Status Pembeli  : ${isAnggota ? 'Anggota' : 'Umum'}");
  debugPrint("Nama Barang     : $namaBarang");

  // Menampilkan kategori dan lokasi rak
  debugPrint("Kategori        : ${kategori.toUpperCase()}");
  debugPrint("Lokasi Rak      : $lokasiRak");

  // Menampilkan harga satuan menurut status pembeli
  debugPrint("Harga Satuan    : ${currencyFormat.format(hargaSatuan)}");
  debugPrint("Stok            : $stok");

  // Status ditampilkan menurut logika boolean yang berasal dari stok
  // Yang ditampilkan antara lain Tersedia atau Habis
  debugPrint("Status          : ${isTersedia ? 'Tersedia' : 'Habis'}");

  debugPrint("Jumlah Beli     : $jumlahBeli");
  debugPrint("Total Awal      : ${currencyFormat.format(totalAwal)}");
  debugPrint("Potongan Diskon : ${currencyFormat.format(nilaiPotongan)} (${persentaseDiskon.toInt()}%)");
  
  debugPrint("HARGA AKHIR     : ${currencyFormat.format(hargaAkhir)}");
  debugPrint("==================================");
  }
  // Jalankan Aplikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Test Penghitung'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

//Pemilihan tipe data yang tepat sangat penting untuk keakuratan kasir koperasi
//agar tidak terjadi kesalahan perhitungan uang atau stok barang.
//Tipe data `double` memastikan perhitungan harga pecahan/desimal seperti
//total dan selisih tetap akurat hingga nilai sen.
//Sementara itu, `int` menjaga jumlah stok dan unit pembelian tetap berupa
//bilangan bulat yang valid tanpa pecahan.