import 'package:flutter/foundation.dart';

class School {
  String picLocation;
  String logoLocation;
  String name;
  double requiredUPG;
  bool shownAlready;
  String abbreviation;
  bool passed;
  //
  String location;
  DateTime established;
  List<int> rank; //QS<local,asian>
  String linkRank;
  //int rankThe;
  String website;
  String motto;
  String mottoMeaning;
  String nickname;
  //Requirement Page

  School({
    @required picName,
    @required logoName,
    @required this.name,
    @required this.abbreviation,
    @required this.requiredUPG,
    this.passed = false,
    @required this.location,
    @required this.established,
    this.rank,
    this.linkRank,
    @required this.website,
    @required this.motto,
    this.mottoMeaning,
    @required this.nickname,
  })  : this.picLocation = "assets/university_pictures/$picName",
        this.logoLocation = "assets/school_logo/$logoName",
        this.shownAlready = false;

  School.up({
    @required picName,
    @required this.name,
    @required this.abbreviation,
    @required this.requiredUPG,
    this.passed = false,
    @required this.location,
    @required this.established,
    @required this.website,
  })  : this.picLocation = "assets/university_pictures/$picName",
        this.logoLocation = "assets/school_logo/up.png",
        this.shownAlready = false,
        this.motto = "Honor and Excellence",
        this.nickname = "UP Fighting Maroons",
        this.rank = [1, 72, 396],
        this.linkRank = "https://www.topuniversities.com/universities/university-philippines#923555";
}

abstract class Schools {
  // Schools._privateConstructor();
  // static final Schools _instance = Schools._privateConstructor();
  // static Schools get instance => _instance;

  static final List<School> list = [
    upd,
    uplb,
    upm,
    upv,
    upou,
    upmin,
    upb,
    upc,
    admu,
    dlsu,
    ust,
    pup,
    plm,
    sanCarlos,
    mapua,
    silliman,
    msu,
    adDavao,
    adCagayan
  ];

  static final School upd = School.up(
    picName: 'upd.jpg',
    abbreviation: 'UPD',
    name: 'UP Diliman',
    requiredUPG: 2.174,
    location: 'Quezon City',
    established: DateTime.utc(1949, 2, 12),
    website: "https://upd.edu.ph/",
  );

  static final School uplb = School.up(
    picName: 'uplb.jpg',
    abbreviation: 'UPLB',
    name: 'UP Los Baños',
    requiredUPG: 2.332,
    location: 'Los Baños',
    established: DateTime.utc(1909, 3, 6),
    website: "https://uplb.edu.ph/",
  );

  static final School upm = School.up(
    picName: 'upm.jpg',
    abbreviation: 'UPM',
    name: 'UP Manila',
    requiredUPG: 2.11,
    location: 'Manila',
    established: DateTime.utc(1905, 12, 1),
    website: "http://our.upm.edu.ph/",
  );

  static final School upv = School.up(
    picName: 'upv.jpg',
    abbreviation: 'UPV',
    name: 'UP Visayas',
    requiredUPG: 2.70,
    location: 'Iloilo, Miag-ao, Tacloban',
    established: DateTime.utc(1947, 1, 1), //NOT EXACT
    website: "https://www.upv.edu.ph/",
  );

  static final School upou = School.up(
    picName: 'upou.jpg',
    abbreviation: 'UPOU',
    name: 'UP Open University',
    requiredUPG: 2.8,
    location: 'Los Baños (Headquarter)',
    established: DateTime.utc(1995, 2, 23),
    website: "https://www.upou.edu.ph/home/",
  );

  static final School upmin = School.up(
    picName: 'upmin.jpg',
    abbreviation: 'UPMin',
    name: 'UP Mindanao',
    requiredUPG: 2.633,
    location: 'Davao',
    established: DateTime.utc(1995, 2, 20),
    website: "https://www2.upmin.edu.ph/",
  );

  static final School upb = School.up(
    picName: 'upb.jpg',
    abbreviation: 'UPB',
    name: 'UP Baguio',
    requiredUPG: 2.576,
    location: 'Baguio',
    established: DateTime.utc(1961, 4, 22),
    website: "https://web.upb.edu.ph/",
  );

  static final School upc = School.up(
    picName: 'upc.jpg',
    abbreviation: 'UPC',
    name: 'UP Cebu',
    requiredUPG: 2.649,
    location: 'Cebu',
    established: DateTime.utc(1918, 5, 3),
    website: "https://www.upcebu.edu.ph/",
  );

  static final School admu = School(
    picName: 'admu.jpg',
    logoName: 'admu.png',
    abbreviation: 'ADMU',
    name: 'Ateneo de Manila',
    requiredUPG: 2.3,
    location: 'Quezon City',
    established: DateTime.utc(1859, 12, 10),
    rank: [2, 124, 601],
    linkRank: "https://www.topuniversities.com/universities/ateneo-de-manila-university#923555",
    website: "https://www.ateneo.edu/",
    motto: "Lux in Domino",
    mottoMeaning: "Light in the Lord",
    nickname: "Ateneo Blue Eagles",
  );

  static final School dlsu = School(
    picName: 'dlsu.jpg',
    logoName: 'dlsu.png',
    abbreviation: 'DLSU',
    name: 'De La Salle',
    requiredUPG: 2.6,
    location: 'Manila',
    established: DateTime.utc(1911, 6, 16),
    rank: [3, 156, 801],
    linkRank: "https://www.topuniversities.com/universities/de-la-salle-university#923555",
    website: "https://www.dlsu.edu.ph/",
    motto: "Religio, Mores, Cultura",
    mottoMeaning: "Religion, Morals, Culture",
    nickname: "DLSU Green Archers",
  );

  static final School ust = School(
    picName: 'ust.jpg',
    logoName: 'ust.png',
    abbreviation: 'UST',
    name: 'University of Santo Tomas',
    requiredUPG: 2.7,
    location: 'Manila',
    established: DateTime.utc(1611, 4, 28),
    rank: [4, 179, 801],
    linkRank: "https://www.topuniversities.com/universities/university-santo-tomas#923555",
    website: "http://www.ust.edu.ph/",
    motto: "Veritas in Caritate",
    mottoMeaning: "Truth in Charity",
    nickname: "UST Growling Tigers",
  );
  static final School pup = School(
    picName: 'pup.jpg',
    logoName: 'pup.png',
    abbreviation: 'PUP',
    name: 'Polytechnic University of the Philippines',
    requiredUPG: 3.0,
    location: 'Manila (Main)',
    established: DateTime.utc(1904, 10, 19),
    //rank: [4, 179, 801],
    website: "https://www.pup.edu.ph/",
    motto: "Tanglaw ng Bayan",
    nickname: "PUP Radicals",
  );
  static final School plm = School(
    picName: 'plm.jpg',
    logoName: 'plm.png',
    abbreviation: 'PLM',
    name: 'Pamantasan ng Lungsod ng Maynila',
    requiredUPG: 3.1,
    location: 'Manila',
    established: DateTime.utc(1965, 6, 19),
    //rank: [4, 179, 801],
    website: "https://www.plm.edu.ph/",
    motto: "Karunungan, Kaunlaran, Kadakilaan",
    nickname: "PLM Haribons",
  );
  static final School sanCarlos = School(
    picName: 'sanCarlos.jpg',
    logoName: 'sanCarlos.png',
    abbreviation: 'USC',
    name: 'University of San Carlos',
    requiredUPG: 4,
    location: 'Cebu',
    established: DateTime.utc(1595, 1, 1), //NOT EXACT
    rank: [5, 351, 0],
    linkRank: "https://www.topuniversities.com/universities/university-san-carlos#923555",
    website: "http://www.usc.edu.ph/",
    motto: "Scientia, Virtus, Devotio",
    mottoMeaning: "Knowledge, Leadership, Service",
    nickname: "USC Warriors",
  );
  static final School mapua = School(
    picName: 'mapua.jpg',
    logoName: 'mapua.png',
    abbreviation: 'MU',
    name: 'Mapúa University',
    requiredUPG: 4.1,
    location: 'Manila',
    established: DateTime.utc(1925, 1, 1), //NOT EXACT
    rank: [6, 451, 0],
    linkRank: "https://www.topuniversities.com/universities/mapua-university#923555",
    website: "https://www.mapua.edu.ph/",
    motto: "Learn, Discover, Create",
    nickname: "Mapúa Cardinals",
  );
  static final School silliman = School(
    picName: 'silliman.jpg',
    logoName: 'silliman.png',
    abbreviation: 'SU',
    name: 'Silliman University',
    requiredUPG: 4.2,
    location: 'Dumaguete',
    established: DateTime.utc(1901, 8, 28),
    rank: [7, 452, 0],
    linkRank: "https://www.topuniversities.com/universities/silliman-university#923555",
    website: "http://su.edu.ph/",
    motto: "Via, Veritas, Vita",
    mottoMeaning: "The way, the Truth and the Life",
    nickname: "	Silliman Stallions",
  );
  static final School msu = School(
    picName: 'msu.jpg',
    logoName: 'msu.png',
    abbreviation: 'MSU-IIT',
    name: 'Mindanao State University-IIT',
    requiredUPG: 4.3,
    location: 'Iligan',
    established: DateTime.utc(1968, 7, 12),
    //rank: [7, 452, 0],
    website: "https://www.msuiit.edu.ph/",
    motto: "Quality Education for a Better Mindanao",
    nickname: "Mindanao State Lions",
  );
  static final School adDavao = School(
    picName: 'adDavao.jpg',
    logoName: 'adDavao.png',
    abbreviation: 'AdDU',
    name: 'Ateneo de Davao',
    requiredUPG: 4.4,
    location: 'Davao',
    established: DateTime.utc(1948, 5, 20),
    //rank: [7, 452, 0],
    website: "https://www.addu.edu.ph/",
    motto: "Fortes in Fide",
    mottoMeaning: "Strong in Faith",
    nickname: "Ateneo Blue Knights",
  );
  static final School adCagayan = School(
    picName: 'adCagayan.jpg',
    logoName: 'adCagayan.png',
    abbreviation: 'Xavier University',
    name: 'Ateneo de Cagayan',
    requiredUPG: 4.5,
    location: 'Cagayan de Oro',
    established: DateTime.utc(1933, 6, 7),
    //rank: [7, 452, 0],
    website: "https://www.xu.edu.ph/",
    motto: "Veritas vos liberabit",
    mottoMeaning: "The truth shall set you free",
    nickname: "Ateneo Xavier Crusaders",
  );
}
