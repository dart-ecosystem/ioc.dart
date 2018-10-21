import 'package:ioc/ioc.dart';

class MyClass {
  OtherClass otherClass;

  MyClass(OtherClass this.otherClass);
}

class OtherClass {}

main() {
  Ioc().bind('MyClass', (Ioc ioc) {
    OtherClass other = ioc.use<OtherClass>('OtherClass');

    return new MyClass(other);
  });

  // later
  Ioc().use<MyClass>('MyClass'); // you will get an instance of OtherClass
}