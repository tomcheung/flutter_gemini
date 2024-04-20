import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'custom_api_client.dart';

part 'gemini_provider.g.dart';

// read the value using launch argument --dart-define-from-file config.json
const apiKey = String.fromEnvironment("API_KEY");
const customServer = String.fromEnvironment("CUSTOM_SERVER");

@Riverpod(keepAlive: true)
GenerativeModel getGeminiModel(GetGeminiModelRef ref, String model,
    {List<Tool>? tools}) {
  // Enable this proxy is you don't have VPN
  CustomHttpClient? customClient;
  if (customServer.isNotEmpty) {
    customClient = CustomHttpClient(overrideHost: customServer);
  }

  // https://github.com/google/generative-ai-js/issues/66
  return GenerativeModel(
    model: model,
    apiKey: apiKey,
    httpClient: customClient,
    tools: tools,
    requestOptions: const RequestOptions(apiVersion: 'v1beta'),
  );
}
