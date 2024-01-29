class Note {
  final int? id;
  final String descripcion;

  Note({
    this.id,
    required this.descripcion,
  });

  Note.fromJson(Map<String, dynamic> item)
      : id = item["id"],
        descripcion = item["descripcion"];

  Map<String, dynamic> toMap() {
    return { 'descripcion': descripcion };
  }
}
