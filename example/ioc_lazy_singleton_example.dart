import 'package:ioc/ioc.dart';

class A {
  void someMethod() {}
}

main() {
  // use lazy loaded singleton on one
  Ioc().bind('A', (ioc) => new A(), singleton: true, lazy: true);

  Ioc().use<A>('A').someMethod();

  // use lazy loaded singleton on all
  Ioc().config['lazy'] = true;

  Ioc().use<A>('A').someMethod();
}
