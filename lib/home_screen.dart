import 'package:flutter/material.dart';
import 'currency_exchange.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CurrencyExchange _currencyService = CurrencyExchange();
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _exchangeRate = 1.0;
  double _result = 0.0;
  String _errorMessage = '';

  final List<String> _currencies = [
    'USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD', 'TRY'
  ];

  void _convert() {
    if (_amountController.text.isEmpty) return;
    double amount = double.parse(_amountController.text);
    setState(() {
      _result = amount * _exchangeRate;
    });
  }

  void _swapCurrencies() {
    setState(() {
      String temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _fetchExchangeRate();
    });
  }

  Future<void> _fetchExchangeRate() async {
    setState(() {
      _errorMessage = '';
    });
    try {
      double rate = await _currencyService.getExchangeRate(_fromCurrency, _toCurrency);
      setState(() {
        _exchangeRate = rate;
      });
      _convert();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount in $_fromCurrency',
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _fromCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                        _fetchExchangeRate();
                      });
                    },
                    items: _currencies.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: _toCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _toCurrency = newValue!;
                        _fetchExchangeRate();
                      });
                    },
                    items: _currencies.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            Text(
              '${_amountController.text} $_fromCurrency = ${_result.toStringAsFixed(2)} $_toCurrency',
              style: const TextStyle(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _swapCurrencies,
              child: const Text('Swap Currencies', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}



