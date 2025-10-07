# README — Gerar e usar um .jks para assinar o app Android

Este mini README descreve, passo-a-passo, como **gerar um Java KeyStore (.jks)** com `keytool`, o que significa cada opção do comando, como armazenar as informações localmente (key.properties / local.properties) e como **configurar o `build.gradle.kts` (Kotlin DSL)** do módulo `app` para assinar a build de *release*.

> **Aviso de segurança:** não comite senhas ou arquivos `.jks` em repositórios públicos. Adicione `key.properties` e o `.jks` ao seu `.gitignore`.

---

## Pré-requisitos

* JDK (Java) instalado e `keytool` disponível no PATH.
* Flutter + Android SDK (caso esteja usando Flutter).

---

## 1) Gerar o keystore com `keytool`

### Comando (Windows)

```powershell
keytool -genkeypair -v -keystore C:\Users\SeuUsuario\fidelyn-user-key.jks -alias fidelyn-user -keyalg RSA -keysize 2048 -validity 10000
```

### Comando (macOS / Linux)

```bash
keytool -genkeypair -v -keystore /home/seuusuario/fidelyn-user-key.jks -alias fidelyn-user -keyalg RSA -keysize 2048 -validity 10000
```

### O que cada opção faz

* `-genkeypair` → gera um par de chaves (pública + privada).
* `-v` → modo verboso (mais detalhes na saída).
* `-keystore C:\Users\SeuUsuario\fidelyn-user-key.jks` → caminho e nome do arquivo `.jks` que será criado. Substitua pelo caminho que quiser.
* `-alias fidelyn-user` → nome (alias) da chave dentro do keystore.
* `-keyalg RSA` → algoritmo da chave (RSA é padrão seguro).
* `-keysize 2048` → tamanho da chave (2048 bits é padrão seguro).
* `-validity 10000` → validade da chave em dias (~27 anos).

Ao executar, o `keytool` pedirá:

* Senha do keystore (store password) — você usou apenas essa.
* Informações de identidade (nome, organização, cidade, estado, país).
* Em seguida ele perguntará se quer definir uma senha da chave (`keyPassword`). Se você pressionou `Enter`, a senha da chave será igual à senha do keystore.

---

## 2) Criar `key.properties` (recomendado)

Na pasta `android/` do seu projeto (módulo `app`), crie o arquivo `key.properties` e **não** o comite.

Exemplo (`android/key.properties`):

```properties
storePassword=minhaSenhaDoKeystore
keyPassword=minhaSenhaDoKeystore
keyAlias=fidelyn-user
storeFile=C:\Users\SeuUsuario\fidelyn-user-key.jks
```

* No Windows, use `C:\\Users\\SeuUsuario\\...` ou `C:/Users/SeuUsuario/...`.
* Adicione `android/key.properties` ao `.gitignore`.

### Observação sobre `local.properties`

* `local.properties` normalmente contém configurações locais do SDK, por exemplo `sdk.dir` e **não** deveria ser usado para guardar senhas sensíveis.
* Se preferir, você pode guardar somente o caminho `storeFile` em `local.properties` e manter as senhas em `key.properties`, mas **recomendo** manter tudo em `key.properties` e garantir que ele esteja no `.gitignore`.

Exemplo (**não recomendado** para senhas):

```properties
# local.properties (apenas como exemplo; evite colocar senhas aqui)
storeFile=C:/Users/SeuUsuario/fidelyn-user-key.jks
```

---

## 3) Alteração em `android/app/build.gradle.kts` (Kotlin DSL)

Abaixo um snippet pronto para colar no `build.gradle.kts` do módulo `app`. Ele carrega `key.properties` (se existir) e cria a `signingConfig` de `release` usando esses valores.

```kotlin
import java.util.Properties
import java.io.FileInputStream

// Carrega key.properties
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.fidelyn.user"
    compileSdk = 34 // ou use flutter.compileSdkVersion se estiver usando Flutter plugin

    defaultConfig {
        applicationId = "com.fidelyn.user"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }

    signingConfigs {
        // Mantém a config de debug
        getByName("debug")

        // Cria a signing config de release usando key.properties
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storePassword = keystoreProperties.getProperty("storePassword")
            val storeFilePath = keystoreProperties.getProperty("storeFile")
            if (!storeFilePath.isNullOrBlank()) {
                storeFile = file(storeFilePath)
            }
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}
```

> Se você já tem `import` ou outras configurações no topo do arquivo, apenas integre as seções acima.

---

## 4) Gerar o bundle de release

No terminal (na raiz do projeto Flutter):

```bash
flutter clean
flutter build appbundle --release
```

O AAB gerado ficará em `build/app/outputs/bundle/release/app-release.aab`.

---

## 5) Boas práticas e troubleshooting

* **Não comite** `key.properties` nem o `.jks` em repositórios públicos.
* Adicione `android/key.properties` e o `.jks` ao `.gitignore`.
* Se o Gradle reclamar que `storeFile` não existe, verifique o caminho em `key.properties` (também cheque permissões).
* Se aparecer erro sobre senha inválida, confirme `storePassword` e `keyPassword`.

---

## Exemplo rápido de `.gitignore` (na pasta android/)

```
# Keystore
key.properties
*.jks
```

---

Se quiser, eu posso:

* Gerar para você um `key.properties` de exemplo sem senhas (você preenche), ou
* Verificar seu `build.gradle.kts` atual (cole aqui) e eu ajusto para você.

Boa sorte — quando terminar, rode `flutter build appbundle --release` e me diga se aparecer algum erro que eu te ajudo a resolver.
