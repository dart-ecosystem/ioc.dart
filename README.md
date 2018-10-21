# IoC
The most simple IoC Container of Dart and Flutter

If you looking for a package that is light-weight and provide production-ready of inversion of
control, then this package is right for you.

This package provides only 2 main api, easy to learn and use,  but definitely fits most use case in your flutter project.

If you are a server developer developing small or medium scale project, it's very likely you want to use this package.
However, large scale project may need more powerful heavy-weight IoC library.

You **can** use it in your angular project, but we highly recommend you use dependency injection system provided by angular.

## Goal
Keep it minimal, light-weight

## Important
1. The container does not rely on reflection, it's just a Map, so supports Flutter
2. Dart2 is **required** to use this package

## Feature
1. Supports singleton
2. Supports binding to anything
4. Supports lazy initialization (Developing)
3. Detects circular dependencies (Developing)

## Usage

bind to a string:

```dart
import 'package:ioc/ioc.dart';

main() {
  Ioc().bind('MyClass', (ioc) => new MyClass());
  
  // later
  Ioc().use('MyClass'); // you will get an instance of MyClass
  // with generic if you want
  Ioc().use<MyClass>('MyClass');
}
```

bind to self:

```dart
import 'package:ioc/ioc.dart';

main() {
  Ioc().bind(MyClass, (ioc) => new MyClass());
  
  // later
  Ioc().use(MyClass); // you will get an instance of MyClass
}
```

bind to other:

```dart
import 'package:ioc/ioc.dart';

main() {
  Ioc().bind(MyClass, (ioc) => new OtherClass());
  
  // later
  Ioc().use(MyClass); // you will get an instance of OtherClass
}
```

bind with other dependency

```dart
import 'package:ioc/ioc.dart';

main() {
  Ioc().bind('MyClass', (Ioc ioc) {
    OtherClass other = ioc.use<OtherClass>('OtherClass');
    
    return new MyClass(other);
  });
  
  // later
  Ioc().use<MyClass>('MyClass'); // you will get an instance of OtherClass
}
```

using singleton: 

```dart
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
```

using lazy-loading singleton: 

```dart
import 'package:ioc/ioc.dart';

class A {
  void someMethod() {}
}

main() {
  // use lazy loaded singleton on one
  Ioc().bind('A', (ioc) => new A(), singleton: true, lazy: true);

  // class A will only be instantiated after first .use('A')
  Ioc().use<A>('A').someMethod();

  // use lazy loaded singleton on all
  Ioc().config['lazy'] = true;

  Ioc().use<A>('A').someMethod();
}
```