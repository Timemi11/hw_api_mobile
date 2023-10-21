// "userId": 1,
// "id": 1,
// "title": "quidem molestiae enim"

class AlbumsItem {
  final int userId;
  final int id;
  final String title;

  AlbumsItem({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumsItem.fromJson(Map<String, dynamic> json) {
    return AlbumsItem(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
