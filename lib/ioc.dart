library ioc;

/**
 * Dead simple inversion of control class
 *
 * @class Ioc
 */
class Ioc {
  static Ioc iocInstance;

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

  Ioc bind<T>(dynamic carrier, T initializer(Ioc ioc)) {
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
