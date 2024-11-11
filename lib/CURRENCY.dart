import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  TextEditingController USDTpriceController = TextEditingController();
  TextEditingController USDTQuantityController = TextEditingController();
  TextEditingController PKRController = TextEditingController();

  double result = 0.0;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade600,
        title: Text(
          "Currency Converter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade600,
        onPressed: () {
          // Clear all text fields and reset the result.
          USDTpriceController.clear();
          USDTQuantityController.clear();
          PKRController.clear();
          setState(() {
            result = 0.0;
            errorMessage = '';
          });
        },
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // USDT Price Input Field
            _buildInputField(
              controller: USDTpriceController,
              hintText: 'Enter USDT Price',
              icon: Icons.attach_money,
            ),
            // USDT Quantity Input Field
            _buildInputField(
              controller: USDTQuantityController,
              hintText: 'Enter USDT Quantity',
              icon: Icons.money,
            ),
            // Converted PKR Field (Non-editable)
            _buildInputField(
              controller: PKRController,
              hintText: 'Converted PKR',
              icon: Icons.currency_rupee_rounded,
              enabled: false,
            ),
            // Error Message Display
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            SizedBox(height: 20),
            // Calculate Button
            GestureDetector(
              onTap: _calculateConversion,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade600, Colors.teal.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.shade200,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Calculate',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle currency calculation
  void _calculateConversion() {
    setState(() {
      double USDTprice = double.tryParse(USDTpriceController.text) ?? -1.0;
      double USDTQuantity = double.tryParse(USDTQuantityController.text) ?? -1.0;

      if (USDTprice <= 0.0 || USDTQuantity <= 0.0) {
        errorMessage = "Please enter valid numeric values.";
        PKRController.clear();
      } else {
        result = USDTQuantity * USDTprice;
        PKRController.text = result.toStringAsFixed(2);
        errorMessage = '';
      }
    });
  }

  // Reusable Input Field with Icon
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool enabled = true,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        enabled: enabled,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.teal.shade600),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.teal.shade400,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
