import 'package:ioc/ioc.dart';
import 'package:test/test.dart';

class A {}

class B {}

void main()
{
  group('Ioc tests', ()
  {
    test('Ioc() is an instance of Ioc', () {
      expect(Ioc(), TypeMatcher<Ioc>());
    });

    test('should alway be singleton', ()
    {
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
  });
}
