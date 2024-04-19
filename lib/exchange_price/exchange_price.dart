import 'package:flutter/material.dart';
import 'package:flutter_google_gen_ai/exchange_price/exchange_price_provider.dart';
import 'package:flutter_google_gen_ai/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExchangePrice extends ConsumerStatefulWidget {
  const ExchangePrice({super.key});

  @override
  ConsumerState<ExchangePrice> createState() => _ExchangePriceState();
}

class _ExchangePriceState extends ConsumerState<ExchangePrice> {
  var _currentQuestion = '';
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final answer = ref.watch(getPriceQueryProvider(_currentQuestion));
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Flutter price query demo'),
      ),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Text(answer.value ?? ''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _editingController,
                    maxLines: 10,
                    minLines: 1,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final question = _editingController.text;
                    setState(() {
                      _currentQuestion = question;
                    });
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
