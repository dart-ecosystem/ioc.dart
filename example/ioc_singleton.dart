import 'package:ioc/ioc.dart';

class A {
  void someMethod() {}
}

main() {
  // use singleton on one
  Ioc().bind('A', (ioc) => new A(), singleton: true);

  Ioc().use<A>('A').someMethod();

  // use singleton on all
  Ioc().config['singlton'] = true;

  Ioc().use<A>('A').someMethod();
}
