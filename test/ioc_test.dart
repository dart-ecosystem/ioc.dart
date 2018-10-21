import 'package:ioc/ioc.dart';
import 'package:test/test.dart';

class A {}

class B {}

class C {
  static int initializedCount = 0;

  C() {
    initializedCount++;
  }
}

void main() {
  group('Ioc tests', () {
    test('Ioc() is an instance of Ioc', () {
      expect(Ioc(), TypeMatcher<Ioc>());
    });

    test('should alway be singleton', () {
      expect(Ioc(), Ioc());
    });

    test('.bind() self binding', () {
      Ioc().bind(A, (Ioc ioc) => new A());
      var instance = Ioc().use(A);
      var instance2 = Ioc().use(A);

      expect(instance, TypeMatcher<A>());
      expect(instance, isNot(instance2));
    });

    test('.bind() none-self binding', () {
      Ioc().bind(A, (Ioc ioc) => new B());

      var instance = Ioc().use(A);
      var instance2 = Ioc().use(A);

      expect(instance, TypeMatcher<B>());
      expect(instance, isNot(instance2));
    });

    test('.bind() string binding', () {
      Ioc().bind('A', (Ioc ioc) => new A());

      var instance = Ioc().use('A');
      var instance2 = Ioc().use('A');

      expect(instance, TypeMatcher<A>());
      expect(instance, isNot(instance2));
    });

    test('.bind() singleton', () {
      Ioc().bind('A', (ioc) => new A(), singleton: true);
      Ioc().bind(A, (ioc) => new A(), singleton: true);

      var a1 = Ioc().use('A');
      var a2 = Ioc().use('A');

      expect(a1, TypeMatcher<A>());
      expect(a1, a2);
    });

    test('.bind() with global singleton setting', () {
      Ioc().config['singlton'] = true;
      Ioc().bind('A', (ioc) => new A());
      Ioc().bind(A, (ioc) => new A());

      var a1 = Ioc().use('A');
      var a2 = Ioc().use('A');

      expect(a1, TypeMatcher<A>());
      expect(a1, a2);
      Ioc().config['singlton'] = false;
    });

    test('lazy load singleton', () {
      Ioc myIoc = Ioc.create();

      myIoc.bind('A', (ioc) => new C(), singleton: true, lazy: true);

      expect(C.initializedCount, 0);

      C c = myIoc.use<C>('A');

      expect(C.initializedCount, 1);
      expect(c, TypeMatcher<C>());

      myIoc.use<C>('A');
      expect(C.initializedCount, 1);
    });

    test('set lazy load singleton at global', () {
      Ioc myIoc = Ioc.create();
      myIoc.config['lazy'] = true;
      C.initializedCount = 0;

      myIoc.bind('A', (ioc) => new C(), singleton: true);

      expect(C.initializedCount, 0);

      C c = myIoc.use<C>('A');

      expect(C.initializedCount, 1);
      expect(c, TypeMatcher<C>());

      myIoc.use<C>('A');
      expect(C.initializedCount, 1);
    });
  });
}
