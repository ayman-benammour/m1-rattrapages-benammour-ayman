# Tempo Tasks - Time Tracking App

## Description
**Tempo Tasks** est une application de suivi du temps qui permet aux utilisateurs de créer et de gérer des tâches, de chronométrer la durée de chaque tâche, et de visualiser toutes les tâches enregistrées, triées par date.

## Features
- **Créer et gérer des tâches** : Ajoutez des tâches avec un nom, une catégorie, un commentaire, une durée prévue.
- **Chronomètre intégré** : Suivez la durée des tâches en temps réel grâce au chronomètre intégré.
- **Vue de toutes les tâches** : Visualisez toutes les tâches enregistrées, triées par date ou par ordre alphabétique.

## Getting Started

### Prérequis
Assurez-vous d'avoir installé les éléments suivants sur votre machine :
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) (pour l'émulateur Android)
- [Xcode](https://developer.apple.com/xcode/) (pour le simulateur iOS, uniquement sur macOS)

### Installation

1. **Clonez le repository :**
   ```bash
   git clone https://github.com/votre-utilisateur/tempo-tasks.git
   cd 02-Architecture-Mobile-IOS

2. **Installez les dépendances :**
   ```bash
   flutter pub get

3. **Séléctionner votre device**
   ```bash
   flutter emulators
   To run an emulator, run 'flutter emulators --launch <emulator id>'.

3. **Lancer l'application**
   ```bash
   flutter run

## Structure du projet
    lib/
      ├── models/    : Modèles de données.
      ├── providers/ : Gestionnaires d'état utilisant Provider.
      ├── screens/   : Écrans de l'application.
      └── main.dart  : Point d'entrée de l'application.

## [Vidéo](https://www.youtube.com/watch?v=dJoTO_AZ-k4&ab_channel=AymanBenammour)
Pour une démonstration complète de l'application, ainsi que des explications sur les principes architecturaux utilisés : 
[Lien](https://www.youtube.com/watch?v=dJoTO_AZ-k4&ab_channel=AymanBenammour)

## Sources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package Documentation](https://pub.dev/packages/provider)
