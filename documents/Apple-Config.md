1. Certificates (Certificados)
É a sua "Identidade Digital". O certificado prova para a Apple que você é você. Sem ele, o sistema não deixa você instalar nada.

Existem dois tipos principais: um para Desenvolvimento (testar no seu iPhone) e um para Distribuição (enviar para a App Store).

2. Identifiers (Identificadores / App IDs)
É o "RG do seu Aplicativo". Cada app precisa de um ID único no mundo (geralmente no formato com.suaempresa.nomeapp).

É aqui que você também ativa recursos especiais para esse "RG", como Login com Apple, Notificações Push ou iCloud.

3. Devices (Dispositivos)
É a "Lista VIP" de aparelhos. Enquanto você está desenvolvendo (antes de lançar na loja), o app não roda em qualquer iPhone. Ele só roda nos aparelhos que estiverem cadastrados aqui pelo número de série (UDID).

Se o iPhone do seu chefe ou cliente não estiver nessa lista, eles não conseguirão testar o app.

4. Profiles (Provisioning Profiles)
É o que junta tudo (Onde você estava antes). O "Perfil" é um arquivo que amarra os três itens acima. Ele diz ao iPhone:

"Eu autorizo este Desenvolvedor (Certificate) a instalar este App (Identifier) neste iPhone específico (Device)."

5. Keys (Chaves)
São chaves de acesso para serviços. Usado principalmente para configurar serviços de backend, como enviar Notificações Push (APNs) ou "Sign in with Apple".

Diferente dos certificados, as chaves não expiram com tanta frequência e podem ser usadas para vários apps da mesma conta.

6. Services (Serviços)
Aqui ficam configurações para tecnologias muito específicas, como configurar contas de comerciante para Apple Pay ou passes para a Apple Wallet. Se o seu app não usa Apple Pay ou Wallet, você raramente tocará aqui.