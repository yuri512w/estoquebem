import 'package:hive/hive.dart';

class DatabaseService {
  late Box _box;

  Future<void> init() async {
    // Abra ou crie a caixa de produtos
    _box = await Hive.openBox('produtosBox');

    // Opcional: Preencher com dados iniciais caso o banco esteja vazio
    if (_box.isEmpty) {
      List<Map<String, dynamic>> produtosPreCadastrados = [
        {'nome': 'Arroz', 'validade': '', 'quantidade': 0},
        {'nome': 'Feijão', 'validade': '', 'quantidade': 0},
        {'nome': 'Açúcar', 'validade': '', 'quantidade': 0},
        {'nome': 'Óleo de soja', 'validade': '', 'quantidade': 0},
      ];

      for (var produto in produtosPreCadastrados) {
        await _box.add(produto);
      }
    }
  }

  Future<void> salvarProduto(Map<String, dynamic> produto) async {
    await _box.add(produto);
  }

  List<Map<String, dynamic>> buscarTodosProdutos() {
    return _box.values.cast<Map<String, dynamic>>().toList();
  }

  Future<void> excluirProduto(int index) async {
    await _box.deleteAt(index);
  }
}
