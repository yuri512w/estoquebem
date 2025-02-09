import 'package:flutter/material.dart';
import '../services/database_service.dart';
import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  final DatabaseService dbService;

  const HomeScreen({Key? key, required this.dbService}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _produtos = [];

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    final produtos = widget.dbService.buscarTodosProdutos();
    setState(() {
      _produtos = produtos;
    });
  }

  void _excluirProduto(int index) async {
    await widget.dbService.excluirProduto(index);
    _carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Gestor de Produtos', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _produtos.isEmpty
          ? Center(
              child: Text(
                'Nenhum produto cadastrado.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: _produtos.length,
                itemBuilder: (context, index) {
                  final produto = _produtos[index];
                  return Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.inventory, color: Colors.white),
                      ),
                      title: Text(
                        produto['nome'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Validade: ${produto['validade']}\nQuantidade: ${produto['quantidade']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _excluirProduto(index),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroScreen(dbService: widget.dbService),
            ),
          ).then((_) => _carregarProdutos());
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, size: 30, color: Colors.white),
        tooltip: 'Cadastrar Produto',
      ),
    );
  }
}
