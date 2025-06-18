class BeatlesMember {
  final String name;
  final String birthday;
  final String info;
  final String imagePath; // Dies ist für die Mitgliederbilder

  const BeatlesMember({
    required this.name,
    required this.birthday,
    required this.info,
    required this.imagePath,
  });
}

class DatabaseRepository {
  static const String ringoStartImagePath = 'assets/fotos/ringo_start.jpg';
  static const String johnStartImagePath = 'assets/fotos/john_start.jpg';
  static const String georgeStartImagePath = 'assets/fotos/george_start.jpg';
  static const String paulStartImagePath = 'assets/fotos/paul_start.jpg';

  static const List<BeatlesMember> beatlesMembers = [
    BeatlesMember(
      name: 'George Harrison',
      birthday: '25. Februar 1943',
      info:
          'The Beatles (1962 – 1970), Traveling Wilburys (1988 – 1990), The Quarrymen (1958)',
      imagePath: 'assets/fotos/george.jpg',
    ),
    BeatlesMember(
      name: 'Paul McCartney',
      birthday: '18. Juni 1942',
      info:
          'The Beatles (1962 – 1970), Wings (1971 – 1981), The Quarrymen (1957 – 1960)',
      imagePath: 'assets/fotos/paul.jpg',
    ),
    BeatlesMember(
      name: 'John Lennon',
      birthday: '9. Oktober 1940',
      info:
          'The Beatles (1962 – 1970), Plastic Ono Band (1969 – 1974), The Quarrymen (1956 – 1960)',
      imagePath: 'assets/fotos/john.jpg',
    ),
    BeatlesMember(
      name: 'Ringo Starr',
      birthday: '7. Juli 1940',
      info:
          'The Beatles (1962 – 1970), Ringo and his All Starr Band (Seit 1989), Plastic Ono Band (1969 – 1970)',
      imagePath: 'assets/fotos/ringo.jpg',
    ),
  ];
}
