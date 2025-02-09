import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/ocr_service.dart';
import '../services/database_service.dart';

class CadastroScreen extends StatefulWidget {
  final DatabaseService dbService;

  const CadastroScreen({Key? key, required this.dbService}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _validadeController = TextEditingController();
  final TextEditingController _loteController = TextEditingController();

  final OCRService _ocrService = OCRService();
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _capturarFoto() async {
    // Abrir a câmera para tirar foto
    final XFile? foto = await _imagePicker.pickImage(source: ImageSource.camera);

    if (foto != null) {
      // Processar a imagem com o OCR
      final dadosExtraidos = await _ocrService.processImage(foto.path);

      setState(() {
        _nomeController.text = dadosExtraidos['nome'] ?? '';
        _validadeController.text = dadosExtraidos['validade'] ?? '';
        _loteController.text = dadosExtraidos['lote'] ?? '';
      });
    }
  }

  void _salvarProduto() async {
    if (_nomeController.text.isNotEmpty &&
        _quantidadeController.text.isNotEmpty &&
        _validadeController.text.isNotEmpty) {
      final produto = {
        'nome': _nomeController.text,
        'validade': _validadeController.text,
        'lote': _loteController.text,
        'quantidade': int.parse(_quantidadeController.text),
      };

      await widget.dbService.salvarProduto(produto);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _capturarFoto,
              icon: Icon(Icons.camera_alt),
              label: Text('Tirar Foto do Produto'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextField(
              controller: _validadeController,
              decoration: InputDecoration(labelText: 'Validade'),
            ),
            TextField(
              controller: _loteController,
              decoration: InputDecoration(labelText: 'Lote'),
            ),
            TextField(
              controller: _quantidadeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantidade'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarProduto,
              child: Text('Salvar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
