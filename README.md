Estoquebem

Estoquebem é um aplicativo Flutter para gestão de produtos com reconhecimento de texto via OCR (Google ML Kit).

1. Tecnologias Utilizadas

Flutter (Dart)

Google ML Kit (Reconhecimento de texto)

SQLite (Banco de dados local)

Provider (Gerenciamento de estado)

Gradle (Compilação Android)

2. Configuração do Ambiente

2.1. Instale as Dependências

Certifique-se de que tem o Flutter instalado e atualizado:

flutter doctor

Instale as dependências do projeto:

flutter pub get

2.2. Configurar Gradle

Caso esteja enfrentando problemas com o Gradle, atualize as versões:

Arquivo: android/gradle/wrapper/gradle-wrapper.properties

distributionUrl=https\://services.gradle.org/distributions/gradle-8.0.2-all.zip

Arquivo: android/build.gradle

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath "com.android.tools.build:gradle:8.0.2"
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.22"
    }
}

2.3. Configurar AndroidManifest.xml

Arquivo: android/app/src/main/AndroidManifest.xml
Adicione as permissões necessárias para OCR:

<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

3. Como Executar o Projeto

3.1. Rodar no Emulador ou Dispositivo Físico

Conecte um dispositivo via USB ou abra um emulador e execute:

flutter run

Caso precise de logs mais detalhados:

flutter run --verbose

3.2. Gerar APK

Para gerar o APK de produção:

flutter build apk --release

O APK gerado estará em:

build/app/outputs/flutter-apk/app-release.apk

Para gerar um APK de depuração:

flutter build apk --debug

4. Estrutura do Projeto

estoquebem/
├── android/           # Código nativo Android
├── ios/               # Código nativo iOS
├── lib/               # Código principal Flutter
│   ├── models/        # Modelos de dados
│   ├── services/      # Serviços (OCR, banco de dados, etc.)
│   ├── screens/       # Telas do aplicativo
│   ├── widgets/       # Componentes reutilizáveis
│   ├── main.dart      # Arquivo principal
├── assets/            # Imagens, ícones, fontes
├── pubspec.yaml       # Configurações do Flutter e dependências
├── README.md          # Documentação do projeto

5. Contato

Caso tenha dúvidas ou precise de suporte, entre em contato pelo GitHub ou envie um e-mail para [yuri512w@gmail.com].

