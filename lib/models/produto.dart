class Produto {
  int? id;
  String nome;
  String validade;
  int quantidade;
  String imagemPath;

  Produto({
    this.id,
    required this.nome,
    required this.validade,
    required this.quantidade,
    required this.imagemPath,
  });

  // Converte para Map para salvar no banco
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'validade': validade,
      'quantidade': quantidade,
      'imagemPath': imagemPath,
    };
  }

  // Converte de Map para Produto
  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      validade: map['validade'],
      quantidade: map['quantidade'],
      imagemPath: map['imagemPath'],
    );
  }
}
