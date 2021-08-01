import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:encrypt/encrypt.dart';
import 'package:path/path.dart' as p;

import 'base_cryptor.dart';

/// FileCryptor for encryption and decryption files.
class FileCryptor extends BaseFileCryptor {
  /// [key] is using for encrypt and decrypt given file
  final String key;

  /// [iv] is Initialization vector encryption times
  final int iv;

  /// [IV] private instance for encryption and decryption
  final IV _iv;

  /// [Key] private instance for encryption and decryption
  final Key _key;

  /// [dir] working directory
  final String dir;

  /// [useCompress] for compressing file as GZip.
  final bool useCompress;

  /// [key] is using for encrypt and decrypt given file
  ///
  /// [iv] is Initialization vector encryption times
  ///
  /// [dir] working directory
  ///
  /// [useCompress] for compressing file as GZip.
  FileCryptor({
    required this.key,
    required this.iv,
    required this.dir,
    this.useCompress = false,
  })  : assert(key.length == 64, "key length must be 64"),
        this._iv = IV.fromLength(iv),
        this._key = Key.fromBase16(key);

  /// Get current absolute working directory
  String getCurrentDir() => p.absolute(dir);

  @override
  Future<File> decrypt({
    String? inputFile,
    String? outputFile,
    bool? useCompress,
  }) async {
    bool _useCompress = useCompress == null ? this.useCompress : useCompress;
    File _inputFile = File(p.join(dir, inputFile));
    File _outputFile = File(p.join(dir, outputFile));

    bool _outputFileExists = await _outputFile.exists();
    bool _inputFileExists = await _inputFile.exists();

    if (!_outputFileExists) {
      await _outputFile.create();
    }

    if (!_inputFileExists) {
      throw Exception("Input file not found.");
    }

    final _fileContents = _inputFile.readAsBytesSync();

    var compressedContent;

    if (_useCompress) {
      compressedContent = GZipDecoder().decodeBytes(_fileContents.toList());
    }

    final Encrypter _encrypter = Encrypter(AES(_key));

    final _encryptedFile =
        Encrypted((_useCompress ? compressedContent : _fileContents));
    final _decryptedFile = _encrypter.decryptBytes(_encryptedFile, iv: _iv);

    return await _outputFile.writeAsBytes(_decryptedFile);
  }

  @override
  Future<File> encrypt({
    String? inputFileFullPath, //完整路径
    String? outputFile, //文件名
    bool? useCompress,
  }) async {
    File? _inputFile;
    bool _useCompress = useCompress == null ? this.useCompress : useCompress;
    // File _inputFile = File(p.join(dir, inputFile));
    if (inputFileFullPath != null) {
      _inputFile = File(inputFileFullPath);
    }
    File _outputFile = File(p.join(dir, outputFile));

    bool _outputFileExists = await _outputFile.exists();
    bool _inputFileExists = await _inputFile!.exists();

    if (!_outputFileExists) {
      await _outputFile.create();
    }

    if (!_inputFileExists) {
      throw Exception("Input file not found.");
    }

    final _fileContents = _inputFile.readAsBytesSync();

    final Encrypter _encrypter = Encrypter(AES(_key));

    final Encrypted _encrypted = _encrypter.encryptBytes(
      _fileContents,
      iv: _iv,
    );

    var compressedContent;

    if (_useCompress) {
      compressedContent = GZipEncoder().encode(_encrypted.bytes.toList())!;
    }

    File _encryptedFile = await _outputFile
        .writeAsBytes(_useCompress ? compressedContent : _encrypted.bytes);

    return _encryptedFile;
  }

  @override
  Uint8List decryptUint8List({Uint8List? data, bool? useCompress}) {
    bool _useCompress = useCompress == null ? this.useCompress : useCompress;
    if (data == null) {
      throw Exception("data cannot be null");
    }
    final Encrypter _encrypter = Encrypter(AES(_key));

    List<int>? compressedContent;

    if (_useCompress) {
      compressedContent = GZipDecoder().decodeBytes(data);
    }

    final Encrypted _encrypted =
        Encrypted(_useCompress ? Uint8List.fromList(compressedContent!) : data);
    final _decryptedData = _encrypter.decryptBytes(_encrypted, iv: _iv);

    return Uint8List.fromList(_decryptedData);
  }

  @override
  Uint8List encryptUint8List({Uint8List? data, bool? useCompress}) {
    bool _useCompress = useCompress == null ? this.useCompress : useCompress;
    if (data == null) {
      throw Exception("data cannot be null");
    }
    final Encrypter _encrypter = Encrypter(AES(_key));
    final Encrypted _encrypted =
        _encrypter.encrypt(String.fromCharCodes(data), iv: _iv);

    List<int>? compressedContent;

    if (_useCompress) {
      compressedContent = GZipEncoder().encode(_encrypted.bytes.toList())!;
    }

    return _useCompress
        ? Uint8List.fromList(compressedContent!)
        : _encrypted.bytes;
  }
}
