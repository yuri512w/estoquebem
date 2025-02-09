import 'package:flutter/material.dart';
import '../services/database_service.dart';

class AlertaScreen extends StatefulWidget {
  final DatabaseService dbService;

  const AlertaScreen({Key? key, required this.dbService}) : super(key: key);

  @override
  _AlertaScreenState createState() => _AlertaScreenState();
}

class _AlertaScreenState extends State<AlertaScreen> {
  List<Map<String, dynamic>> _produtosVencendo = [];

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    final todosProdutos = widget.dbService.buscarTodosProdutos();
    final dataAtual = DateTime.now();
    final vencendo = todosProdutos.where((produto) {
      final validade = DateTime.parse(produto['validade']);
      final diferenca = validade.difference(dataAtual).inDays;
      return diferenca <= 7 && diferenca >= 0; // Entre 0 e 7 dias
    }).toList();

    setState(() {
      _produtosVencendo = vencendo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos Próximos ao Vencimento'),
      ),
      body: _produtosVencendo.isEmpty
          ? Center(
              child: Text(
                'Nenhum produto próximo ao vencimento.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _produtosVencendo.length,
              itemBuilder: (context, index) {
                final produto = _produtosVencendo[index];
                return ListTile(
                  title: Text(produto['nome']),
                  subtitle: Text('Validade: ${produto['validade']}'),
                  trailing: Text('Qtd: ${produto['quantidade']}'),
                );
              },
            ),
    );
  }
}
