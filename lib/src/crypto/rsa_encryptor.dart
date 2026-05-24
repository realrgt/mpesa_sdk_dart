import 'dart:convert';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:pointycastle/export.dart';

class RsaEncryptor {
  const RsaEncryptor();

  String encryptToBase64({
    required String plaintext,
    required String publicKeyPem,
  }) {
    final publicKey = _parsePublicKeyFromPem(publicKeyPem);
    final cipherText = _encrypt(plaintext, publicKey);
    return base64.encode(cipherText);
  }

  RSAPublicKey _parsePublicKeyFromPem(String pemString) {
    final publicKeyDer = _decodePem(pemString);
    final asn1Parser = ASN1Parser(Uint8List.fromList(publicKeyDer));
    final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

    late ASN1Integer modulus;
    late ASN1Integer exponent;

    if (topLevelSeq.elements.isNotEmpty &&
        topLevelSeq.elements.first is ASN1Integer) {
      modulus = topLevelSeq.elements[0] as ASN1Integer;
      exponent = topLevelSeq.elements[1] as ASN1Integer;
    } else {
      final publicKeyBitString = topLevelSeq.elements[1] as ASN1BitString;
      final publicKeyAsn = ASN1Parser(publicKeyBitString.contentBytes());
      final publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;
      modulus = publicKeySeq.elements[0] as ASN1Integer;
      exponent = publicKeySeq.elements[1] as ASN1Integer;
    }

    return RSAPublicKey(
      modulus.valueAsBigInteger,
      exponent.valueAsBigInteger,
    );
  }

  List<int> _decodePem(String pem) {
    return base64.decode(_removePemHeaderAndFooter(pem));
  }

  String _removePemHeaderAndFooter(String pem) {
    const startsWith = <String>[
      '-----BEGIN PUBLIC KEY-----',
      '-----BEGIN RSA PRIVATE KEY-----',
      '-----BEGIN RSA PUBLIC KEY-----',
      '-----BEGIN PRIVATE KEY-----',
      '-----BEGIN PGP PUBLIC KEY BLOCK-----\\r\\nVersion: React-Native-OpenPGP.js 0.1\\r\\nComment: http://openpgpjs.org\\r\\n\\r\\n',
      '-----BEGIN PGP PRIVATE KEY BLOCK-----\\r\\nVersion: React-Native-OpenPGP.js 0.1\\r\\nComment: http://openpgpjs.org\\r\\n\\r\\n',
    ];
    const endsWith = <String>[
      '-----END PUBLIC KEY-----',
      '-----END PRIVATE KEY-----',
      '-----END RSA PRIVATE KEY-----',
      '-----END RSA PUBLIC KEY-----',
      '-----END PGP PUBLIC KEY BLOCK-----',
      '-----END PGP PRIVATE KEY BLOCK-----',
    ];

    var normalized =
        pem.replaceAll(' ', '').replaceAll('\n', '').replaceAll('\r', '');

    for (var s in startsWith) {
      s = s.replaceAll(' ', '');
      if (normalized.startsWith(s)) {
        normalized = normalized.substring(s.length);
      }
    }

    for (var s in endsWith) {
      s = s.replaceAll(' ', '');
      if (normalized.endsWith(s)) {
        normalized = normalized.substring(0, normalized.length - s.length);
      }
    }

    return normalized;
  }

  Uint8List _encrypt(String plaintext, RSAPublicKey publicKey) {
    final cipher = PKCS1Encoding(RSAEngine())
      ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
    return cipher.process(Uint8List.fromList(plaintext.codeUnits));
  }
}
