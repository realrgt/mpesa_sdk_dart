import 'dart:convert';

import '../utils/rsa_key_helper.dart';

class MpesaConfig {
  /// Encrypts the [Api Key] with [Public Key] and
  /// returns a usable Bearer Token
  ///
  static String getBearerToken(String apiKey, String publicKey) {
    try {
      final rsaKeyHelper = RsaKeyHelper();
      final pk = rsaKeyHelper.parsePublicKeyFromPem(publicKey);
      final token = rsaKeyHelper.encrypt(apiKey, pk);

      return 'Bearer ${base64.encode(token)}';
    } catch (e) {
      throw e.toString();
    }
  }
}
