import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static const String _effectiveDate = '17 de setembro de 2025';

  static final List<Map<String, String>> _sections = [
    {
      'title': 'Data de vigência',
      'body':
          '$_effectiveDate\n\nEsta Política de Privacidade descreve como a Fidelyn coleta, usa, compartilha e protege seus Dados Pessoais quando você utiliza o aplicativo Fidelyn ("App").',
    },
    {
      'title': 'Controladora de dados',
      'body':
          'A Fidelyn é a controladora dos Dados Pessoais coletados por meio do App, salvo quando informado expressamente que determinado processamento é realizado por parceiros ou fornecedores. Para questões relacionadas a dados, utilize o e-mail: suporte@fidelyn.com.',
    },
    {
      'title': 'Dados que coletamos',
      'body':
          '- Dados de identificação: nome, e-mail, telefone.\n- Dados de uso: histórico de pontos, resgates, interações com lojas parceiras.\n- Dados técnicos: identificadores do dispositivo, versão do sistema operacional, logs de erro.\n- Dados de localização: quando você autoriza o App a acessar sua localização para facilitar promoções locais (opcional).',
    },
    {
      'title': 'Finalidades do tratamento',
      'body':
          'Coletamos e usamos seus dados para: (i) operar a plataforma e permitir o acúmulo e resgate de pontos; (ii) comunicar ofertas e notificações relevantes; (iii) prevenir fraudes e abusos; (iv) melhorar funcionalidades e analisar uso; (v) cumprir obrigações legais.',
    },
    {
      'title': 'Base legal',
      'body':
          'Tratamos seus Dados Pessoais com base em: (i) execução de contrato (quando aplicável); (ii) cumprimento de obrigação legal; (iii) consentimento do titular (para comunicações e marketing, quando solicitado); e (iv) legítimo interesse (por exemplo, prevenção a fraudes e melhoria do serviço), observados os direitos dos titulares e a legislação aplicável.',
    },
    {
      'title': 'Compartilhamento de dados',
      'body':
          'Podemos compartilhar seus dados com: (i) lojas parceiras para fins de gestão de pontos e campanhas; (ii) provedores de serviços (ex.: hospedagem, análise, envio de e-mail); (iii) autoridades competentes quando exigido por lei. Exigimos contratos que protejam os dados quando compartilhamos com terceiros.',
    },
    {
      'title': 'Transferência internacional',
      'body':
          'Quando necessário, poderemos transferir dados para provedores localizados fora do Brasil. Garantimos que tais transferências observem salvaguardas adequadas e a legislação aplicável.',
    },
    {
      'title': 'Retenção de dados',
      'body':
          'Reteremos seus Dados Pessoais pelo tempo necessário para cumprir as finalidades descritas nesta política, obedecendo prazos legais e fiscais. Após o término da necessidade, os dados serão eliminados ou anonimizados, salvo obrigação legal em contrário.',
    },
    {
      'title': 'Direitos dos titulares',
      'body':
          'Você tem direitos previstos na LGPD, incluindo acesso, correção, eliminação, portabilidade, oposição e revogação de consentimento. Para exercer seus direitos, entre em contato através do e-mail: suporte@fidelyn.com.',
    },
    {
      'title': 'Segurança',
      'body':
          'Adotamos medidas técnicas e administrativas para proteger os Dados Pessoais contra acesso não autorizado, perda, alteração ou divulgação indevida. Embora utilizemos boas práticas de segurança, nenhum sistema é infalível; em caso de incidente de segurança, notificaremos as autoridades e titulares conforme a legislação aplicável.',
    },
    {
      'title': 'Cookies e tecnologias similares',
      'body':
          'Podemos utilizar cookies e tecnologias semelhantes para melhorar a experiência do usuário, analisar uso e oferecer funcionalidades. Em geral, essas tecnologias não coletam informações que identifiquem pessoalmente o usuário sem o seu consentimento.',
    },
    {
      'title': 'Menores de idade',
      'body':
          'O App não é destinado a menores de idade sem consentimento dos pais ou responsáveis. Não coletamos intencionalmente dados de menores sem o devido consentimento. Caso tome conhecimento de coleta indevida, entre em contato para que possamos remover os dados.',
    },
    {
      'title': 'Alterações nesta Política',
      'body':
          'Podemos atualizar esta Política de Privacidade periodicamente. Mudanças significativas serão comunicadas no App ou por e-mail. Recomendamos a revisão periódica desta página.',
    },
    {
      'title': 'Contato',
      'body':
          'Para dúvidas, solicitações relacionadas a dados pessoais ou comunicação de incidentes, contate: suporte@fidelyn.com.',
    },
    {
      'title': 'Observação final',
      'body':
          'Esta Política de Privacidade é um modelo e não substitui aconselhamento jurídico. Recomendamos revisão por assessor jurídico para garantir conformidade plena com a LGPD e demais normas aplicáveis.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Política de Privacidade — Fidelyn')),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Política de Privacidade — Fidelyn',
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
                'Seus direitos e dúvidas podem ser exercidos pelo e-mail informado acima.',
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
