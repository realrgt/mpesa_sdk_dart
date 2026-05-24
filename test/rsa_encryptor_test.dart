import 'dart:convert';

import 'package:mpesa_sdk_dart/src/crypto/rsa_encryptor.dart';
import 'package:test/test.dart';

import 'fixtures/keys.dart';

void main() {
  group('RsaEncryptor', () {
    test('encrypts api key into base64 payload', () {
      const encryptor = RsaEncryptor();

      final token = encryptor.encryptToBase64(
        plaintext: testApiKey,
        publicKeyPem: testPublicKey,
      );

      expect(token, isNotEmpty);
      expect(() => base64.decode(token), returnsNormally);
    });

    test('throws with invalid key payload', () {
      const encryptor = RsaEncryptor();

      expect(
        () => encryptor.encryptToBase64(
          plaintext: testApiKey,
          publicKeyPem: 'invalid-key',
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
