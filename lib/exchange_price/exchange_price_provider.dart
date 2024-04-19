import 'dart:convert';

import 'package:flutter_google_gen_ai/core/gemini_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'exchange_price_provider.g.dart';

// https://ai.google.dev/gemini-api/docs/function-calling
final tools = [
  Tool(functionDeclarations: [
    FunctionDeclaration(
      'get_price',
      'return the exchange rates from given currency to all the other currencies',
      Schema(
        SchemaType.object,
        nullable: false,
        properties: {'currency': Schema(SchemaType.string, description: 'ISO 4217 Three Letter Currency Codes - e.g. USD for US Dollars, EUR for Euro etc')},
      ),
    )
  ])
];

// https://www.exchangerate-api.com/docs/free
Future<Map<String, num>> getPriceFromApi(String baseCurrency) async {
  final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/$baseCurrency'));

  var json = jsonDecode(response.body) as Map<String, dynamic>;
  json = json['rates'] as Map<String, dynamic>;
  print(json);
  return json.cast();
}

@riverpod
Future<String> getPriceQuery(GetPriceQueryRef ref, String question) async {
  if (question.isEmpty) {
    return '';
  }

  print(question);

  final model = ref.watch(getGeminiModelProvider('gemini-pro', tools: tools));
  final response = await model.generateContent([Content.text(question)]);

  final c = response.candidates.first;
  final firstPart = c.content.parts.firstOrNull;
  if (firstPart is FunctionCall && firstPart.name == 'get_price') {
    final currency = firstPart.args['currency'];
    print(firstPart.toJson().toString());

    if (currency == null || currency is! String) {
      return '';
    }

    final priceResponse = await getPriceFromApi(currency);
    final funcResponse = Content.functionResponse('get_price', priceResponse);

    final response = await model.generateContent([Content.text(question), c.content, funcResponse]);
    return response.text ?? '';
  }

  return '';
}
