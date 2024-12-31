class Game {
  String bgImage;
  String icon;
  String name;
  String type;
  num score;
  num download;
  num review;
  String description;
  List<String> images;

  Game(
    this.bgImage,
    this.icon,
    this.name,
    this.type,
    this.score,
    this.download,
    this.review,
    this.description,
    this.images,
  );

  static List<Game> games() {
    return [
      Game(
        'assets/images/ndo1.jpeg',
        'assets/images/ndo2.jpeg',
        'Ndole Sawa',
        'Legume',
        4.8,
        382,
        324,
        "Ori is stranger to peril, but when a fateful flight puts the owlet ku in har'ms way.Ori is stranger to peril, but when a fateful flight puts the owlet ku in har'ms way.Ori is stranger to peril, but when a fateful flight puts the owlet ku in har'ms way.",
        [
          'assets/images/ndo3.jpeg',
          'assets/images/ndo4.jpeg',
          'assets/images/ndo5.jpeg',
        ],
      ),
      Game(
        'assets/images/pom1.jpeg',
        'assets/images/pom2.jpeg',
        'Bouillon de pomme',
        'Legume',
        3.7,
        226,
        148,
        "Rayman is stranger to peril, but when a fateful flight puts the owlet ku in har'ms way.Ori is stranger to peril, but when a fateful flight puts the owlet ku in har'ms way.Ori is stranger to peril, but when a fateful flight puts the owlet ku in har'ms way.",
        [
          'assets/images/pom3.jpeg',
          'assets/images/pom4.jpeg',
          'assets/images/pom3.jpeg',
          'assets/images/pom1.jpeg',
        ],
      ),
      Game(
        'assets/images/ndo3.jpeg',
        'assets/images/ndo2.jpeg',
        'Eru & fufu',
        'Legume',
        3.7,
        226,
        148,
        "Rayman is stranger to peril, but when a fateful flight puts the owlet ku in har'ms way.Ori is stranger to peril, but when a fateful flight puts the owlet ku in har'ms way.Ori is stranger to peril, but when a fateful flight puts the owlet ku in har'ms way.",
        [
          'assets/images/ndo3.jpeg',
          'assets/images/ndo4.jpeg',
          'assets/images/ndo5.jpeg',
          'assets/images/ndo1.jpeg',
        ],
      ),
    ];
  }
}
