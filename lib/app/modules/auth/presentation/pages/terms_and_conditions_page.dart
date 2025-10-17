import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  static const String _effectiveDate = '17 de setembro de 2025';

  static final List<Map<String, String>> _sections = [
    {
      'title': 'Data de vigência',
      'body':
          '$_effectiveDate\n\nBem-vindo ao Fidelyn. Estes Termos e Condições ("Termos") regem seu uso do aplicativo Fidelyn destinado a usuários finais (o "App"). Ao criar uma conta, acessar ou usar o App, você concorda com estes Termos. Se não concorda, não utilize o App.',
    },
    {
      'title': 'Definições',
      'body':
          '- App: Aplicativo móvel Fidelyn para usuários finais.\n- Loja/Logista: Estabelecimento parceiro que oferece programas de fidelidade via Fidelyn.\n- Conta: Registro de usuário no App, com e-mail/telefone e credenciais.\n- Pontos/Recompensas: Créditos ou benefícios atribuídos pelo uso junto às lojas parceiras.\n- Dados Pessoais: informações que identificam ou tornam identificável uma pessoa natural, conforme LGPD.',
    },
    {
      'title': 'Escopo do Serviço',
      'body':
          'Fidelyn fornece uma plataforma que permite ao Usuário cadastrar-se, coletar pontos, resgatar recompensas e interagir com lojas parceiras. As regras de acúmulo e resgate de pontos são definidas pela respectiva loja parceira e podem variar entre estabelecimentos.',
    },
    {
      'title': 'Cadastro e Conta',
      'body':
          'Você é responsável por manter suas credenciais seguras e por todas as atividades realizadas na sua Conta. Deve fornecer informações verdadeiras, atualizadas e completas. A Fidelyn pode suspender ou encerrar contas com informações fraudulentas. Não é permitida a transferência de contas a terceiros sem autorização explícita.',
    },
    {
      'title': 'Regras de Pontos e Recompensas',
      'body':
          'Pontos têm validade, condições de uso e podem expirar conforme política da loja parceira; verifique os termos da promoção correspondente.\nPontos e recompensas não têm, em regra, valor em dinheiro e não poderão ser convertidos em moeda sem autorização expressa.\nA Fidelyn pode, por motivo razoável (fraude, erro, abuso), ajustar saldos de pontos, cancelar transações ou bloquear resgates.',
    },
    {
      'title': 'Conduta do Usuário — Proibições',
      'body':
          'Você concorda em não:\n- Usar o App para fins ilegais, fraudulentos ou que violem direitos de terceiros;\n- Tentar invadir, interferir ou burlar a segurança do App;\n- Criar múltiplas contas para fraudar programas de fidelidade.\n\nO descumprimento pode resultar em suspensão, encerramento da conta e responsabilização civil/criminal.',
    },
    {
      'title': 'Privacidade e Tratamento de Dados',
      'body':
          'A proteção dos seus dados é importante. O tratamento dos seus Dados Pessoais seguirá a nossa Política de Privacidade, que detalha quais dados coletamos, finalidades, bases legais, tempo de conservação e seus direitos. A Fidelyn atua como controladora dos dados que coleta por meio do App, salvo quando explicitado que determinados dados são processados por lojas parceiras.\n\nA Fidelyn adota medidas técnicas e administrativas razoáveis para proteger os Dados Pessoais contra acesso não autorizado, perda, alteração ou divulgação indevida, incluindo controles de acesso, criptografia e processos internos de segurança. Entretanto, apesar de nossos esforços, nenhum sistema é absolutamente invulnerável.',
    },
    {
      'title': 'Vazamento de Dados — Responsabilidade e Procedimentos',
      'body':
          'Medidas: adotamos práticas de segurança, atualizações periódicas, monitoramento e controles de acesso técnico/administrativo para reduzir riscos.\n\nNotificação: quando houver incidente de segurança com possibilidade de risco/dano relevante, comunicaremos as autoridades competentes e os titulares nos prazos e nas formas exigidas pela legislação aplicável.\n\nLimitação: na extensão máxima permitida pela lei, a Fidelyn não será responsável por danos resultantes de (i) casos fortuitos ou força maior; (ii) ações de terceiros que realizem invasões sofisticadas sem condições razoavelmente previsíveis; (iii) uso indevido das credenciais do Usuário. Isso sem prejuízo das responsabilidades legais que não possam ser afastadas.',
    },
    {
      'title': 'Propriedade Intelectual',
      'body':
          'Todo conteúdo, marcas, software e elementos do App são de propriedade da Fidelyn ou de licenciantes. É proibida a cópia, reprodução ou uso não autorizado desses elementos.',
    },
    {
      'title': 'Limitação de Responsabilidade',
      'body':
          'Na máxima extensão permitida por lei, a responsabilidade total da Fidelyn por quaisquer danos diretos decorrentes do uso do App fica limitada ao valor efetivamente pago pelo Usuário à Fidelyn nos 12 (doze) meses anteriores ao fato gerador — ou, se inexistirem, a um valor razoável a ser definido conforme a legislação aplicável. A Fidelyn não será responsável por danos indiretos, lucros cessantes, perda de dados ou danos consequenciais, salvo disposição legal em contrário.',
    },
    {
      'title': 'Indenização',
      'body':
          'Você concorda em indenizar e manter a Fidelyn isenta de qualquer reclamação, perda, dano, responsabilidade ou despesa decorrente do seu uso do App em desacordo com estes Termos, de sua violação destes Termos ou de atos/omissões que causem prejuízo a terceiros.',
    },
    {
      'title': 'Encerramento e Suspensão',
      'body':
          'A Fidelyn pode suspender ou encerrar sua Conta em caso de violação destes Termos, ordem judicial ou por motivo de segurança. Você pode encerrar sua Conta seguindo as instruções no App; algumas informações poderão ser retidas conforme nossa Política de Privacidade e obrigações legais.',
    },
    {
      'title': 'Alterações dos Termos',
      'body':
          'Podemos alterar estes Termos a qualquer momento. Mudanças significativas serão comunicadas no App ou por e-mail com antecedência razoável. O uso continuado do App após a alteração implica aceitação das novas condições.',
    },
    {
      'title': 'Comunicações',
      'body':
          'Notificações serão feitas por e-mail, push ou por meio do próprio App. É sua responsabilidade manter meios de contato atualizados.',
    },
    {
      'title': 'Terceiros e Links',
      'body':
          'O App pode conter links ou integrações com serviços de terceiros (ex.: meios de pagamento, redes sociais). A Fidelyn não controla esses serviços e não se responsabiliza por suas práticas de privacidade ou termos — verifique os termos dos respectivos provedores.',
    },
    {
      'title': 'Disposições Gerais',
      'body':
          'Se qualquer cláusula destes Termos for considerada inválida, as demais permanecerão em vigor. A eventual tolerância da Fidelyn quanto a infrações não implica renúncia de direitos.',
    },
    {
      'title': 'Lei Aplicável e Foro',
      'body':
          'Estes Termos serão regidos pelas leis brasileiras. Fica eleito o foro da comarca da sede da Fidelyn para dirimir quaisquer questões, salvo disposição legal em contrário.',
    },
    {
      'title': 'Contato',
      'body':
          'Para dúvidas, solicitações de exercício de direitos de titular ou comunicação de incidentes de segurança, entre em contato pelo e-mail: suporte@fidelyn.com.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Termos e Condições — Fidelyn')),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Termos e Condições — Fidelyn',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Data de vigência: $_effectiveDate',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              ..._sections
                  .map(
                    (s) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          SelectableText(s['body']!),
                        ],
                      ),
                    ),
                  )
                  .toList(),

              const SizedBox(height: 24),

              const Text(
                'Ao continuar a usar o aplicativo, você declara que leu e concorda com estes Termos.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
