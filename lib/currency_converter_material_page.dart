import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({Key? key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();
  String selectedCurrency = 'USD'; // Default selected currency
  Map<String, double> conversionRates = {
    'USD': 83.20, // Conversion rate for USD to INR
    'POUND': 103.74, // Conversion rate for GBP to INR
    'Pakistani Rupee': 0.27, // Conversion rate for PKR to INR
    'Euro': 89.11, // Conversion rate for EUR to INR
    'Canadian Dollar': 60.94, // Conversion rate for CAD to INR
    'Japanese Yen': 0.56, // Conversion rate for JPY to INR
    // Add more currencies and their conversion rates as needed
  };

  void convert() {
    final inputAmount = double.tryParse(textEditingController.text);
    if (inputAmount != null) {
      final conversionRate = conversionRates[selectedCurrency];
      if (conversionRate != null) {
        result = inputAmount * conversionRate;
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 43, 147),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 43, 147),
        elevation: 0,
        title: const Text('Currency Converter'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'INR ${result.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 211, 10, 10),
                ),
              ),
              DropdownButton<String>(
                value: selectedCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrency = newValue!;
                  });
                },
                items: conversionRates.keys.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
              ),
              TextField(
                controller: textEditingController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in selected currency',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIconColor: Color.fromARGB(255, 0, 0, 0),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: convert,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
