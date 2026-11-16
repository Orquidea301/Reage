import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gerenciador de estado global e persistência local da aplicação ReAge.
class AppState extends ChangeNotifier {
  // Padrão Singleton
  AppState._();
  static final AppState instance = AppState._();

  // Chave de armazenamento no SharedPreferences
  static const String _storageKey = 'reage_state_v1';

  // Campos públicos de dados do usuário e estado
  String registerName = '';
  String email = '';
  String role = '';
  bool loggedIn = false;
  bool assessmentDone = false;
  String elderName = '';
  String contact = ''; // SOMENTE dígitos
  String gender = 'Prefiro não informar';
  int age = 65;
  double height = 1.65;
  double weight = 70;

  // Campos privados de autenticação (hash seguro)
  String _salt = '';
  String _hash = '';

  /// Carrega os dados salvos do SharedPreferences (se existirem).
  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      if (jsonString != null) {
        final Map<String, dynamic> data = jsonDecode(jsonString);
        registerName = data['registerName'] ?? '';
        email = data['email'] ?? '';
        role = data['role'] ?? '';
        loggedIn = data['loggedIn'] ?? false;
        assessmentDone = data['assessmentDone'] ?? false;
        elderName = data['elderName'] ?? '';
        contact = data['contact'] ?? '';
        gender = data['gender'] ?? 'Prefiro não informar';
        age = data['age'] ?? 65;
        height = (data['height'] as num?)?.toDouble() ?? 1.65;
        weight = (data['weight'] as num?)?.toDouble() ?? 70;
        _salt = data['salt'] ?? '';
        _hash = data['hash'] ?? '';
      }
    } catch (e) {
      debugPrint('Erro ao carregar AppState: $e');
    }
  }

  /// Grava todos os campos como um único JSON no SharedPreferences.
  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final Map<String, dynamic> data = {
        'registerName': registerName,
        'email': email,
        'role': role,
        'loggedIn': loggedIn,
        'assessmentDone': assessmentDone,
        'elderName': elderName,
        'contact': contact,
        'gender': gender,
        'age': age,
        'height': height,
        'weight': weight,
        'salt': _salt,
        'hash': _hash,
      };
      await prefs.setString(_storageKey, jsonEncode(data));
    } catch (e) {
      debugPrint('Erro ao salvar AppState: $e');
    }
  }

  /// Notifica ouvintes e persiste as alterações.
  void _changed() {
    notifyListeners();
    _save();
  }

  /// Realiza o registo de uma nova conta de usuário.
  Future<void> register({
    required String name,
    required String emailAddress,
    required String password,
    required String accountRole,
  }) async {
    // Apaga dados de conta anterior
    elderName = '';
    contact = '';
    gender = 'Prefiro não informar';
    age = 65;
    height = 1.65;
    weight = 70;
    assessmentDone = false;

    registerName = name;
    email = emailAddress.trim().toLowerCase();
    role = accountRole;

    // Cria salt aleatório (16 bytes, base64Url)
    final random = Random.secure();
    final saltBytes = List<int>.generate(16, (_) => random.nextInt(256));
    _salt = base64UrlEncode(saltBytes);

    // Cria hash SHA-256 de salt:password
    final bytes = utf8.encode('$_salt:$password');
    _hash = sha256.convert(bytes).toString();

    loggedIn = true;
    _changed();
  }

  /// Realiza o login do usuário. Retorna null se sucesso ou mensagem de erro.
  Future<String?> login(String emailAddress, String password) async {
    final trimmedEmail = emailAddress.trim().toLowerCase();

    if (email.isEmpty) {
      return 'Nenhuma conta encontrada neste aparelho. Toque em "Criar conta".';
    }

    if (trimmedEmail != email) {
      return 'E-mail ou senha incorretos.';
    }

    // Calcula hash da tentativa de senha com o salt armazenado
    final bytes = utf8.encode('$_salt:$password');
    final attemptHash = sha256.convert(bytes).toString();

    if (attemptHash != _hash) {
      return 'E-mail ou senha incorretos.';
    }

    loggedIn = true;
    _changed();
    return null;
  }

  /// Realiza o logout (os dados continuam salvos).
  void logout() {
    loggedIn = false;
    _changed();
  }

  /// Conclui a avaliação física e armazena as métricas.
  void finishAssessment({
    required String name,
    required String emergencyContact,
    required int ageValue,
    required double heightValue,
    required double weightValue,
  }) {
    elderName = name;
    contact = emergencyContact.replaceAll(RegExp(r'\D'), '');
    age = ageValue;
    height = heightValue;
    weight = weightValue;
    assessmentDone = true;
    _changed();
  }

  /// Retorna true se existe uma conta cadastrada (e-mail não vazio).
  bool get hasAccount => email.isNotEmpty;

  /// Retorna o nome exibido: nome do idoso (se preenchido), senão o nome de registo.
  String get shownName => elderName.trim().isNotEmpty ? elderName.trim() : registerName;

  /// Calcula o Índice de Massa Corporal (IMC).
  double get imc => weight / (height * height);
}
