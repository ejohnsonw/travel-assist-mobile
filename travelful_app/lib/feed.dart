class Feed {
  final String title;
  final String urlAction;
  final String description;
  final int id;

  Feed._({this.id, this.title, this.urlAction, this.description});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return new Feed._(
        title: json['title'],
        urlAction: json['urlAction'],
        id: json['id'],
        description: json['description']);
  }
}
