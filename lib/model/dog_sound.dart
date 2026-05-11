class DogSound {
  final String id;
  final String name;
  final String image;
  final String audio;

  DogSound({required this.id, required this.name, required this.image, required this.audio});

  factory DogSound.fromJson(Map<String, dynamic> json) {
    return DogSound(
      id: json['id'],
      name: json['post_name'],
      image: json['post_image'],
      audio: json['post_audio'],
    );
  }
}