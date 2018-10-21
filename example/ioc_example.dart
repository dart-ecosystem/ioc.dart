import 'package:ioc/ioc.dart';

class A {
  void someMethod()
  {

  }
}
class B {}

main() {
  Ioc().bind('A', (ioc) => new A());

  Ioc().use<A>('A').someMethod();
}
