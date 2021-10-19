class SVGConstants {
  static SVGConstants? _instace;

  static SVGConstants get instance => _instace ??= SVGConstants._init();

  SVGConstants._init();

  String get getir => toSVG("getir");

  String toSVG(String name) => "assets/images/$name.svg";
}
