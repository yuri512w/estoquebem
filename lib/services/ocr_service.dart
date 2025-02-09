
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


class OCRService {
  Future<Map<String, String>> processImage(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      String validade = '';
      String lote = '';

      for (TextBlock block in recognizedText.blocks) {
        final String text = block.text;

        // Procura pela validade
        if (text.contains(RegExp(r'V:|V\s*:'))) {
          validade = _extrairValidade(text);
        }

        // Procura pelo lote
        if (text.contains(RegExp(r'L:|L\s*:'))) {
          lote = _extrairLote(text);
        }
      }

      textRecognizer.close();

      return {
        'validade': validade,
        'lote': lote,
      };
    } catch (e) {
      print('Erro ao processar imagem: $e');
      return {
        'validade': '',
        'lote': '',
      };
    }
  }

  String _extrairValidade(String text) {
    final match = RegExp(r'V:\s*(\d{2}/\d{4})').firstMatch(text);
    return match?.group(1) ?? '';
  }

  String _extrairLote(String text) {
    final match = RegExp(r'L:\s*([\w\d\s]+)').firstMatch(text);
    return match?.group(1)?.trim() ?? '';
  }
}
