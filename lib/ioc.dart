library ioc;

/**
 * Dead simple inversion of control class
 *
 * @class Ioc
 */
class Ioc {
  static Ioc iocInstance;

  Map<String, dynamic> config = {
    'singleton': false,
  };

  Map _bindingMap = new Map();

  Map _singletonMap = new Map();

  factory Ioc() {
    if (iocInstance is Ioc) {
      return iocInstance;
    }

    iocInstance = new Ioc._();

    return iocInstance;
  }

  Ioc._();

  Ioc bind<T>(dynamic carrier, T initializer(Ioc ioc), {bool singleton}) {
    if (config['singlton'] == true || singleton == true) {
      _singletonMap[carrier] = initializer(this);

      return this;
    }

    _bindingMap[carrier] = initializer;

    return this;
  }

  T use<T>(dynamic carrier) {
    var singleton = _singletonMap[carrier];

    if (singleton != null) {
      return singleton;
    }

    var binding = _bindingMap[carrier];

    if (binding != null) {
      return binding(this);
    }

    return null;
  }
}
