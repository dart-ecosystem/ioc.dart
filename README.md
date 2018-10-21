# IoC
The most simple Ioc Container of Dart and Flutter

## Goal
Keep it minimal

## Important
1. The container does not rely on reflection, it's just a Map, so supports Flutter
2. Dart2 is **required** to use this package

## Feature
1. Supports singleton
2. Supports binding to anything
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
