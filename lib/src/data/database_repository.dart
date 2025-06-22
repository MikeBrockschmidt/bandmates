class BandMember {
  final String name;
  final String birthday;
  final String info;
  final String imagePath;
  final List<String> musicGroups;

  BandMember({
    required this.name,
    required this.birthday,
    required this.info,
    required this.imagePath,
    required this.musicGroups,
  });
}

class DatabaseRepository {
  // Startfotos
  static const String beatlesStartImagePath = 'assets/fotos/beatles_start.jpg';
  static const String georgeharrisonStartImagePath =
      'assets/fotos/george_start.jpg';
  static const String paulmccartneyStartImagePath =
      'assets/fotos/paul_start.jpg';
  static const String johnlennonStartImagePath = 'assets/fotos/john_start.jpg';
  static const String ringostarrStartImagePath = 'assets/fotos/ringo_start.jpg';

  static const String genesisStartImagePath = 'assets/fotos/genesis_start.jpg';
  static const String petergabrielStartImagePath =
      'assets/fotos/peter-gabriel-corbijn.jpg';
  static const String philcollinsStartImagePath =
      'assets/fotos/phil-collins-start.jpg';
  static const String tonybanksStartImagePath =
      'assets/fotos/tony-banks-start.jpg';
  static const String stevehacketStartImagePath =
      'assets/fotos/steve-hackett-start.jpg';
  static const String mikerutherfordstartStartImagePath =
      'assets/fotos/mike-rutherford-start.jpg';

  static const String pinkFloydStartImagePath =
      'assets/fotos/pinkfloyd_start.jpg';
  static const String sydBarrettStartImagePath =
      'assets/fotos/syd_barrett_start.jpg';
  static const String davidGilmourStartImagePath =
      'assets/fotos/david_gilmore_start.jpg';
  static const String rogerWatersStartImagePath =
      'assets/fotos/roger_waters_start.jpg';
  static const String nickMasonStartImagePath =
      'assets/fotos/nick_mason_start.jpg';
  static const String richardWrightStartImagePath =
      'assets/fotos/richard_wright_start.jpg';

  static const String rollingStonesStartImagePath =
      'assets/fotos/rollingstones_start.jpg';
  static const String mickJaggerStartImagePath =
      'assets/fotos/mick_jagger_start.jpg';
  static const String keithRichardsStartImagePath =
      'assets/fotos/keith_richards_start.jpg';
  static const String charlieWattsStartImagePath =
      'assets/fotos/charlie_watts_start.jpg';
  static const String ronnieWoodStartImagePath =
      'assets/fotos/ronnie_wood_start.jpg';
  static const String billWymanStartImagePath =
      'assets/fotos/bill_wyman_start.jpg';

  // Logos
  static const String genesisLogoPath = 'assets/grafiken/GenesisLogo-kl.jpg';
  static const String beatlesLogoPath = 'assets/grafiken/TheBeatlesLogo-kl.jpg';
  static const String pinkFloydLogoPath =
      'assets/grafiken/PinkFloydsLogo-s.jpg';
  static const String rollingStonesLogoPath =
      'assets/grafiken/RollingStonesLogo-s.jpg';
  static const String theSmithsLogoPath = 'assets/grafiken/TheSmithsLogo-s.jpg';

  // Beatles-Mitglieder
  static final List<BandMember> beatlesMembers = [
    BandMember(
      name: 'George Harrison',
      birthday: '25. Februar 1943',
      info: 'Gitarrist, Sänger',
      imagePath: 'assets/fotos/george.jpg',
      musicGroups: [
        'The Beatles',
        'Traveling Wilburys',
        'The Quarrymen',
        'Plastic Ono Band',
      ],
    ),
    BandMember(
      name: 'Paul McCartney',
      birthday: '18. Juni 1942',
      info: 'Sänger, Bassist',
      imagePath: 'assets/fotos/paul.jpg',
      musicGroups: ['The Beatles', 'Wings', 'The Quarrymen'],
    ),
    BandMember(
      name: 'John Lennon',
      birthday: '9. Oktober 1940',
      info: 'Sänger, Gitarrist',
      imagePath: 'assets/fotos/john.jpg',
      musicGroups: ['The Beatles', 'Plastic Ono Band', 'The Quarrymen'],
    ),
    BandMember(
      name: 'Ringo Starr',
      birthday: '7. Juli 1940',
      info: 'Schlagzeuger',
      imagePath: 'assets/fotos/ringo.jpg',
      musicGroups: ['The Beatles', 'Plastic Ono Band', 'All-Starr Band'],
    ),
  ];

  // Genesis-Mitglieder
  static final List<BandMember> genesisMembers = [
    BandMember(
      name: 'Tony Banks',
      birthday: '27. März 1950',
      info: 'Keyboarder',
      imagePath: tonybanksStartImagePath,
      musicGroups: ['Genesis', 'Bankstatement', 'Strictly Inc.', 'Anon'],
    ),
    BandMember(
      name: 'Phil Collins',
      birthday: '30. Januar 1951',
      info: 'Schlagzeuger, Sänger',
      imagePath: philcollinsStartImagePath,
      musicGroups: ['Genesis', 'Phil Collins', 'Brand X'],
    ),
    BandMember(
      name: 'Mike Rutherford',
      birthday: '2. Oktober 1950',
      info: 'Gitarrist, Bassist',
      imagePath: mikerutherfordstartStartImagePath,
      musicGroups: ['Genesis', 'Mike & The Mechanics', 'Red 7', 'Anon'],
    ),
    BandMember(
      name: 'Steve Hackett',
      birthday: '12. Februar 1950',
      info: 'Gitarrist',
      imagePath: stevehacketStartImagePath,
      musicGroups: ['Genesis', 'GTR', 'Quiet World'],
    ),
    BandMember(
      name: 'Peter Gabriel',
      birthday: '13. Februar 1950',
      info: 'Sänger, Flötist',
      imagePath: petergabrielStartImagePath,
      musicGroups: ['Genesis', 'Peter Gabriel'],
    ),
  ];

  // Pink Floyd-Mitglieder
  static final List<BandMember> pinkFloydMembers = [
    BandMember(
      name: 'Nick Mason',
      birthday: '27. Januar 1944',
      info: 'Schlagzeuger',
      imagePath: nickMasonStartImagePath,
      musicGroups: ['Pink Floyd'],
    ),
    BandMember(
      name: 'David Gilmour',
      birthday: '6. März 1946',
      info: 'Gitarrist, Sänger',
      imagePath: davidGilmourStartImagePath,
      musicGroups: ['Pink Floyd'],
    ),
    BandMember(
      name: 'Roger Waters',
      birthday: '6. September 1943',
      info: 'Bassist, Sänger',
      imagePath: rogerWatersStartImagePath,
      musicGroups: ['Pink Floyd'],
    ),
    BandMember(
      name: 'Syd Barrett',
      birthday: '6. Januar 1946',
      info: 'Sänger, Gitarrist',
      imagePath: sydBarrettStartImagePath,
      musicGroups: ['Pink Floyd'],
    ),
    BandMember(
      name: 'Richard Wright',
      birthday: '28. Juli 1943',
      info: 'Keyboarder, Sänger',
      imagePath: richardWrightStartImagePath,
      musicGroups: ['Pink Floyd', 'Zee'],
    ),
  ];

  // Rolling Stones-Mitglieder
  static final List<BandMember> rollingStonesMembers = [
    BandMember(
      name: 'Ronnie Wood',
      birthday: '1. Juni 1947',
      info: 'Gitarrist',
      imagePath: ronnieWoodStartImagePath,
      musicGroups: ['The Rolling Stones', 'Faces', 'Jeff Beck Group'],
    ),
    BandMember(
      name: 'Mick Jagger',
      birthday: '26. Juli 1943',
      info: 'Sänger, Frontmann',
      imagePath: mickJaggerStartImagePath,
      musicGroups: ['The Rolling Stones'],
    ),
    BandMember(
      name: 'Charlie Watts',
      birthday: '2. Juni 1941',
      info: 'Schlagzeuger',
      imagePath: charlieWattsStartImagePath,
      musicGroups: ['The Rolling Stones'],
    ),
    BandMember(
      name: 'Keith Richards',
      birthday: '18. Dezember 1943',
      info: 'Gitarrist, Songwriter',
      imagePath: keithRichardsStartImagePath,
      musicGroups: ['The Rolling Stones', 'X-Pensive Winos'],
    ),
    BandMember(
      name: 'Bill Wyman',
      birthday: '24. Oktober 1936',
      info: 'Bassist',
      imagePath: billWymanStartImagePath,
      musicGroups: ['Bill Wyman’s Rhythm Kings'],
    ),
  ];

  static List<String> getAdditionalArtistsFor(String artistName) {
    switch (artistName.toLowerCase()) {
      case 'george harrison':
        return ['Traveling Wilburys', 'The Quarrymen', 'Plastic Ono Band'];
      case 'john lennon':
        return ['Plastic Ono Band', 'The Quarrymen'];
      case 'paul mccartney':
        return ['Wings', 'The Quarrymen'];
      case 'ringo starr':
        return ['Plastic Ono Band', 'All-Starr Band'];
      case 'peter gabriel':
        return ['Peter Gabriel'];
      case 'phil collins':
        return ['Phil Collins', 'Brand X'];
      case 'mike rutherford':
        return ['Mike & The Mechanics', 'Red 7'];
      case 'tony banks':
        return ['Strictly Inc.', 'tony banks'];
      case 'steve hackett':
        return ['GTR', 'steve hackett'];
      case 'syd barrett':
        return ['Pink Floyd'];
      case 'david gilmour':
        return ['Pink Floyd'];
      case 'roger waters':
        return ['Pink Floyd'];
      case 'nick mason':
        return ['Pink Floyd'];
      case 'richard wright':
        return ['Pink Floyd'];
      case 'mick jagger':
        return ['The Rolling Stones'];
      case 'keith richards':
        return ['The Rolling Stones', 'X-Pensive Winos'];
      case 'charlie watts':
        return ['The Rolling Stones'];
      case 'ronnie wood':
        return ['The Rolling Stones', 'Faces', 'Jeff Beck Group'];
      case 'bill wyman':
        return ['The Rolling Stones', 'Bill Wyman’s Rhythm Kings'];
      default:
        return [];
    }
  }

  // The Smiths-Mitglieder
  static const String smithsStartImagePath = 'assets/fotos/thesmiths_band.jpg';
  static const String mikeJoyceStartImagePath = 'assets/fotos/mike_joyce.jpg';
  static const String morrisseyStartImagePath = 'assets/fotos/morrissey.jpg';
  static const String andyRourkeStartImagePath = 'assets/fotos/andy_rourke.jpg';
  static const String johnnyMarrStartImagePath = 'assets/fotos/johnny_marr.jpg';

  static const String theSmithsStartImagePath =
      'assets/fotos/the_smiths_start.jpg';
  static final List<BandMember> theSmithsMembers = [
    BandMember(
      name: 'Mike Joyce',
      birthday: '1. Juni 1963',
      info: 'Schlagzeuger',
      imagePath: mikeJoyceStartImagePath,
      musicGroups: ['The Smiths'],
    ),
    BandMember(
      name: 'Morrissey',
      birthday: '22. Mai 1959',
      info: 'Sänger, Texter',
      imagePath: morrisseyStartImagePath,
      musicGroups: ['The Smiths'],
    ),
    BandMember(
      name: 'Andy Rourke',
      birthday: '17. Januar 1964',
      info: 'Bassist',
      imagePath: andyRourkeStartImagePath,
      musicGroups: ['The Smiths'],
    ),
    BandMember(
      name: 'Johnny Marr',
      birthday: '31. Oktober 1963',
      info: 'Gitarrist, Songwriter',
      imagePath: johnnyMarrStartImagePath,
      musicGroups: ['The Smiths', 'Modest Mouse', 'The Cribs'],
    ),
  ];
}
