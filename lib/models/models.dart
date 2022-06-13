class Word {

  final String word;
  final String respuesta;

  Word({ required this.word, required this.respuesta});

  Map<String, dynamic> toMap() {
    return { "word": word, "respuesta": respuesta};
  }

  @override
  String toString() {
    return 'Word{name: $word, age: $respuesta}';
  }
}
class Answer{

  final String word;
  final String answer;
  Answer({ required this.word, required this.answer});
  Map<String, dynamic> toMap() {
    return { "word": word, "answer": answer};
  }
  @override
  String toString() {
    return '{word: $word, answer: $answer}';
  }
}
class CheckWords{
  final String word;
  final String answer;

  CheckWords( this.word, this.answer);
  Map<String, dynamic> toMap() {
    return { "word": word, "answer": answer};
  }
}
class CheckWordsData{
  final int rowid;
  final String word;
  final String answer;


  CheckWordsData(this.rowid, this.word, this.answer);

  Map<String, dynamic> toMap() {
    return { "rowid":rowid, "word": word, "answer": answer};
  }

  @override
  String toString() {
    return 'Word{"rowid":$rowid,name: $word, age: $answer}';
  }

}
