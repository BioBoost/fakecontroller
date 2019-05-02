import 'package:bug_mobile_controller/bug/addon.dart';

class AddonLoader {

  static List<Addon> load() {
    List<Addon> addons = new List<Addon>();

    addons.add(Addon("Rocket Engine", "01a2f560d6df03bb"));
    addons.add(Addon("Amphibious", "0140c29c8357f2ce"));
    addons.add(Addon("Harrier", "0155cf8199f0245b"));
    addons.add(Addon("Adamantium", "016bc4464286f3fb"));
    addons.add(Addon("Gravy Shield", "0148eef363dff533"));
    addons.add(Addon("Nanobots", "0164a54798d7d27a"));
    addons.add(Addon("Structural Strengthening", "0136edcaaf285d1d"));
    addons.add(Addon("Flammenwerpfer", "011d5ba90ce241e6"));
    addons.add(Addon("Laser", "01a2eb344edc7c5a"));
    addons.add(Addon("Mines", "01d9643e2bf10134"));
    addons.add(Addon("Plasma Gun", "0100548e2b3038f5"));
    addons.add(Addon("EMP Bomb", "01ff7ab8c2155e57"));
    addons.add(Addon("Ram", "0122e76e424f7c79"));
    addons.add(Addon("Gatling Gun", "01f94b5e5d4277b5"));

    return addons;
  }
}