
# Mimari Yapı
```
lib
├── core
│   ├── base
│   │   ├── model
│   │   │   ├── base_error.dart
│   │   │   ├── base_model.dart
│   │   │   └── IResponseModel.dart
│   │   └── service
│   │       └── base_service.dart
│   ├── constants
│   │   ├── app
│   │   │   └── app_constants.dart
│   │   ├── enums
│   │   │   ├── app_theme_enum.dart
│   │   │   ├── http_request_enum.dart
│   │   │   └── preferences_types.dart
│   │   ├── image
│   │   │   ├── images.dart
│   │   │   └── svg.dart
│   │   └── routes
│   │       └── navigation_constants.dart
│   ├── extension
│   │   ├── context_extension.dart
│   │   ├── network_exntension.dart
│   │   └── string_extension.dart
│   └── init
│       ├── cache
│       │   └── locale_manager.dart
│       ├── di
│       │   └── di.dart
│       ├── language
│       │   └── language_manager.dart
│       ├── logger
│       │   └── logger.dart
│       ├── navigator
│       │   └── navigation_service.dart
│       ├── network
│       │   ├── core_dio.dart
│       │   ├── ICoreDio.dart
│       │   ├── network_core
│       │   │   └── core_operations.dart
│       │   ├── network_manager.dart
│       │   └── no_network.dart
│       └── theme
│           └── theme_service.dart
├── feature
│   ├── home
│   │   ├── bloc
│   │   │   ├── home_bloc.dart
│   │   │   ├── home_event.dart
│   │   │   └── home_state.dart
│   │   ├── model
│   │   │   └── movie.dart
│   │   ├── service
│   │   │   └── home_service.dart
│   │   └── view
│   │       └── home_screen.dart
│   ├── login
│   │   ├── bloc
│   │   │   ├── login_bloc.dart
│   │   │   ├── login_event.dart
│   │   │   └── login_state.dart
│   │   ├── model
│   │   │   ├── login_request.dart
│   │   │   └── user.dart
│   │   ├── service
│   │   │   └── login_service.dart
│   │   └── view
│   │       └── login_screen.dart
│   ├── profile
│   │   ├── bloc
│   │   │   ├── profile_bloc.dart
│   │   │   ├── profile_event.dart
│   │   │   └── profile_state.dart
│   │   ├── model
│   │   │   └── favorite_model.dart
│   │   ├── service
│   │   │   └── profile_service.dart
│   │   └── view
│   │       ├── jeton_bottomshet.dart
│   │       ├── photo_upload_view.dart
│   │       └── profile_screen.dart
│   └── register
│       ├── bloc
│       │   ├── register_bloc.dart
│       │   ├── register_event.dart
│       │   └── register_state.dart
│       ├── model
│       │   └── register_request.dart
│       ├── service
│       │   └── register_service.dart
│       └── view
│           └── register_screen.dart
├── main.dart
└── product
    ├── app
    │   └── application_item.dart
    ├── mixin
    │   └── env_manager.dart
    ├── network
    │   ├── header_query.dart
    │   └── service_extension.dart
    ├── route
    │   └── route.dart
    ├── theme
    │   ├── app_theme.dart
    │   ├── color
    │   │   ├── dark_color_theme.dart
    │   │   ├── i_color_theme.dart
    │   │   └── light_color_theme.dart
    │   └── text
    │       ├── dart_theme.dart
    │       ├── i_text_theme.dart
    │       └── light_text_theme.dart
    └── widget
        ├── bottom_nav_bar.dart
        ├── custom_button.dart
        ├── custom_textfield.dart
        ├── error_dialog_widget.dart
        ├── no_network_shet.dart
        └── social_icon_button.dart
```

1. core – Tüm proje genelinde tekrar kullanılabilecek soyut yapılar<br>
2. feature – özellik bazlı katman(sayfalar)<br>
3. product – Uygulamaya Özgü Yapılar<br>


# Kurulum
Bu projeyi çalıştırmak için aşağıdaki adımları takip edebilirsiniz:

Depoyu Klonlama:<br>
git clone https://github.com/RamazanAksoy/marti_case_ra.git

Gerekli Paketleri Yükleme: Projenin bağımlılıklarını yüklemek için aşağıdaki komutu çalıştırın<br>
flutter pub get

Uygulamayı Çalıştırma: Uygulamayı çalıştırmak için şu komutu kullanabilirsiniz<br>
flutter run
