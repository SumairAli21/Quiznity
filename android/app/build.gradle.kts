plugins {
    id("com.android.application")
    id("kotlin-android")

    // Flutter Gradle plugin (MUST be after android & kotlin)
    id("dev.flutter.flutter-gradle-plugin")

    // 🔥 Firebase Google Services plugin
    id("com.google.gms.google-services")

    // 🔥 Firebase Crashlytics plugin
    id("com.google.firebase.crashlytics")
}

android {
    namespace = "com.example.englify_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17

        // Required by flutter_local_notifications (uses java.time APIs).
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.englify_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {

    // 🔥 Firebase BOM (handles versions automatically)
    implementation(platform("com.google.firebase:firebase-bom:34.8.0"))

    // 🔐 Firebase Authentication
    implementation("com.google.firebase:firebase-auth")

    // 🗂️ Firebase Firestore (Teacher ↔ Student data)
    implementation("com.google.firebase:firebase-firestore")

    // 🔔 Firebase Cloud Messaging (push notifications)
    implementation("com.google.firebase:firebase-messaging")

    // 💥 Firebase Crashlytics + 📊 Analytics (BOM-managed versions)
    implementation("com.google.firebase:firebase-crashlytics")
    implementation("com.google.firebase:firebase-analytics")

    // Desugaring runtime for flutter_local_notifications.
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
