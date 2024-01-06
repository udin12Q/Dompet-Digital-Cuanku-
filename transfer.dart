import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class TransferHistory {
  final String bank;
  final String accountNumber;
  final double amount;
  final Color historyColor; // Added for dynamic color
  final DateTime transferDateTime; // Added for transfer date and time

  TransferHistory(this.bank, this.accountNumber, this.amount, this.historyColor,
      this.transferDateTime);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransferPage(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}

class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController passwordController =
      TextEditingController(); // Added for password
  String selectedBank = 'BRI'; // Default bank selection
  List<TransferHistory> transferHistory = []; // List to store transfer history
  final String correctPassword = '12131415'; // Correct password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.pink),
                      decoration: InputDecoration(
                        labelText: 'Jumlah transfer',
                        labelStyle: TextStyle(color: Colors.pink),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: accountNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Nomor Rekening',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Sandi',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Check password before proceeding with the transfer
                        if (passwordController.text == correctPassword) {
                          showBankSelectionDialog();
                        } else {
                          // Show error message or take appropriate action for incorrect password
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Sandi yang dimasukkan salah.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      icon: Icon(Icons.business, color: Colors.white),
                      label: Text('Antar Bank',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Bank Dipilih: $selectedBank',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: transferHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: transferHistory[index].historyColor.withOpacity(0.9),
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(
                        'Transfer ke ${transferHistory[index].bank} - ${transferHistory[index].amount}',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        amountController.text =
                            transferHistory[index].amount.toString();
                        accountNumberController.text =
                            transferHistory[index].accountNumber;
                        selectedBank = transferHistory[index].bank;
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {
                // Add logic to handle sending to contact
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Kirim ke Kontak'),
                      content: Text(
                          'Tambahkan logika pengiriman ke kontak di sini.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            showTransferReceipt(); // Show transfer receipt after sending to contact
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: Icon(Icons.contact_page, color: Colors.white),
              label: Text('Kirim ke Kontak',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void showBankSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text('Pilih Bank', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            children: [
              ListTile(
                title: Text('BRI'),
                onTap: () {
                  selectBank('BRI');
                  Navigator.pop(context);
                  showAccountNumberDialog();
                },
              ),
              ListTile(
                title: Text('BNI'),
                onTap: () {
                  selectBank('BNI');
                  Navigator.pop(context);
                  showAccountNumberDialog();
                },
              ),
              ListTile(
                title: Text('BCA'),
                onTap: () {
                  selectBank('BCA');
                  Navigator.pop(context);
                  showAccountNumberDialog();
                },
              ),
              ListTile(
                title: Text('MANDIRI'),
                onTap: () {
                  selectBank('MANDIRI');
                  Navigator.pop(context);
                  showAccountNumberDialog();
                },
              ),
              ListTile(
                title: Text('KALSEL'),
                onTap: () {
                  selectBank('KALSEL');
                  Navigator.pop(context);
                  showAccountNumberDialog();
                },
              ),
              ListTile(
                title: Text('MUAMALAT'),
                onTap: () {
                  selectBank('MUAMALAT');
                  Navigator.pop(context);
                  showAccountNumberDialog();
                },
              ),
              ListTile(
                title: Text('BSI'),
                onTap: () {
                  selectBank('BSI');
                  Navigator.pop(context);
                  showAccountNumberDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showAccountNumberDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color historyColor = generateRandomColor(); // Generate a dynamic color

        return AlertDialog(
          title: Text('Masukkan Nomor Rekening',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            children: [
              TextField(
                controller: accountNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nomor Rekening',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  double amount = double.tryParse(amountController.text) ?? 0.0;
                  transferHistory.add(
                    TransferHistory(selectedBank, accountNumberController.text,
                        amount, historyColor, DateTime.now()),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(primary: historyColor),
                child: Text('Transfer',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }

  void selectBank(String bank) {
    setState(() {
      selectedBank = bank;
    });
  }

  void showTransferReceipt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TransferHistory lastTransfer =
            transferHistory[transferHistory.length - 1];

        return AlertDialog(
          title: Text('Bukti Transfer',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: lastTransfer != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Dikirim Melalui: CUANKU'),
                    Text('Pengirim: User'),
                    Text(
                        'Penerima: ${lastTransfer.accountNumber} (${lastTransfer.bank})'),
                    Text('Jumlah yang Dikirim: ${lastTransfer.amount}'),
                    Text(
                        'Dikirim pada Tanggal dan Waktu: ${lastTransfer.transferDateTime.toString()}'),
                  ],
                )
              : Text('Tidak ada transaksi terakhir.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Color generateRandomColor() {
    // You can implement a method to generate a dynamic color based on your criteria
    // For simplicity, let's use a random color for demonstration purposes
    return Color.fromRGBO(
      (DateTime.now().millisecond * 17) % 256,
      (DateTime.now().millisecond * 13) % 256,
      (DateTime.now().millisecond * 19) % 256,
      1.0,
    );
  }
}
