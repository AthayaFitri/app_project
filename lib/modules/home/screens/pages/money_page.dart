import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../models/money_convert.dart';

class MoneyChangerPage extends StatefulWidget {
  const MoneyChangerPage({super.key});

  @override
  State<MoneyChangerPage> createState() => _MoneyChangerPageState();
}

class _MoneyChangerPageState extends State<MoneyChangerPage> {
  late Future<double> future;
  TextEditingController amtController = TextEditingController();

  TextStyle fromToStyle = const TextStyle(
    color: Colors.indigo,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  String toCurrency = "IDR";

  static List<String> currency = [
    'ADA',
    'AED',
    'AFN',
    'ALL',
    'GEL',
    'EUR',
    'JPY',
    'XPD',
    'IDR',
  ];

  @override
  void initState() {
    super.initState();
    future = CurrencyConverter().convertCurrency(toCurrency, 1);
    amtController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    double data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Money Changer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 240,
              child: Lottie.network(
                'https://lottie.host/abb0a628-09b4-408b-8c4b-e96590467643/xYqJLW4lAT.json',
                repeat: true,
                reverse: false,
                animate: true,
              ),
            ),
            Row(
              children: [
                Text(
                  'Amount :',
                  style: fromToStyle,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                      ),
                      controller: amtController,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.indigo,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To',
                    style: fromToStyle,
                  ),
                  DropdownButtonFormField(
                    value: toCurrency,
                    onChanged: (val) {
                      setState(() {
                        toCurrency = val.toString();
                      });
                    },
                    items: currency.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  data =
                      snapshot.data!; // Assign the value to the class variable
                  return Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.indigo.withOpacity(0.2),
                    ),
                    child: Text(
                      'Result : $data',
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  if (amtController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.indigo,
                        behavior: SnackBarBehavior.floating,
                        content: Text('Please Enter Amount'),
                      ),
                    );
                  } else {
                    double amt = double.parse(amtController.text);
                    setState(() {
                      future = CurrencyConverter().convertCurrency(
                        toCurrency,
                        amt,
                      );
                    });
                  }
                },
                child: const Text(
                  'CONVERT',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
