import 'package:fidelin_user_app/app/core/utils/text_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('email', () {
      test('Deve retornar "Insira um email" se o valor for vazio', () {
        expect(Validators.email(''), 'Insira um email');
      });

      test('Deve retornar "Insira um email válido" para email inválido', () {
        expect(Validators.email('emailinvalido'), 'Insira um email válido');
        expect(Validators.email('email@invalido'), 'Insira um email válido');
        expect(Validators.email('email@invalido.'), 'Insira um email válido');
      });

      test('Deve retornar null para email válido', () {
        expect(Validators.email('teste@example.com'), null);
        expect(Validators.email('outro.teste@sub.domain.co.uk'), null);
      });
    });

    group('password', () {
      test('Deve retornar "Insira uma senha" se o valor for vazio', () {
        expect(Validators.password(''), 'Insira uma senha');
      });

      test(
        'Deve retornar "Insira uma senha válida (deve conter 8 caracteres)" para senha com menos de 8 caracteres',
        () {
          expect(
            Validators.password('1234567'),
            'Insira uma senha válida (deve conter 8 caracteres)',
          );
        },
      );

      test('Deve retornar null para senha com 8 ou mais caracteres', () {
        expect(Validators.password('12345678'), null);
        expect(Validators.password('senhaforte123'), null);
      });
    });

    group('name', () {
      test('Deve retornar "Insira uma nome" se o valor for vazio', () {
        expect(Validators.name(''), 'Insira uma nome');
      });

      test(
        'Deve retornar "Insira um nome válido (Nome e Sobrenome)" para nome inválido',
        () {
          expect(
            Validators.name('João'),
            'Insira um nome válido (Nome e Sobrenome)',
          );
          expect(
            Validators.name('João Silva Souza Costa e Silva'),
            'Insira um nome válido (Nome e Sobrenome)',
          );
        },
      );

      test('Deve retornar null para nome válido', () {
        expect(Validators.name('João Silva'), null);
        expect(Validators.name('Maria de Souza'), null);
      });
    });
  });
}
