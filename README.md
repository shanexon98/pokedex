# Pokédex Flutter CC SHANEXON ORTIZ

Aplicación Flutter que consume la API pública de PokeAPI para listar, filtrar y ver el detalle de Pokémon.

## Tecnologías utilizadas
- Flutter 
- Riverpod (gestión de estado, providers)
- Dio (cliente HTTP)
- Freezed + Json Serializable (modelos inmutables y mapeo JSON)
- PokeAPI (fuente de datos REST)

## Cómo correr el proyecto
1. Requisitos previos
   - Tener instalado Flutter SDK (`>=3.x`).
   - Dispositivo/emulador/simulador disponible.
2. Instalar dependencias
   - `flutter pub get`
3. Ejecutar
   - Android/iOS: `flutter run`


## Arquitectura
Se sigue una separación por capas y por feature:

### Core
- `lib/core/dio_client.dart`: inicializa `Dio` con `baseUrl`, timeouts.

### Data
- `features/pokemon/data/datasources/pokemon_remote_datasource.dart`: llamadas HTTP a PokeAPI.
- `features/pokemon/data/repositories/pokemon_repository_impl.dart`: orquesta el datasource y convierte JSON a entidades de Domain.

### Domain
- Entidades: `Pokemon`, `PokemonDetail`, `PokemonSpecies` (modelos puros con parseo desde JSON).
- Contrato: `features/pokemon/domain/repositories/pokemon_repository.dart` (interfaz del repositorio).
- Caso de uso: `features/pokemon/domain/usecases/get_pokemon_list.dart` (obtención de lista).

### Presentation
- Páginas: lista, favoritos, detalle, onboarding y splash.
- Providers (Riverpod): `pokemon_providers.dart` gestiona repositorios, usecases y `FutureProvider.family` para detalle y species; también `StateProvider` para búsqueda y `StateNotifierProvider` para filtros y favoritos.
- Widgets reutilizables: `PokeballLoader` (loader animado), `PokemonCard`, `TypeImageChip`, estados de esqueleto/error y modal de filtros.
- Utilidades: `type_utils.dart` (colores por tipo y assets de tipo).

## Capas de seguridad
Aunque es una aplicación cliente sin credenciales ni escritura en servidor, se aplican medidas básicas:
- Transporte seguro: todo tráfico es sobre HTTPS a `pokeapi.co`.
- Timeouts de red: `connectTimeout` y `receiveTimeout` a 10s para evitar bloqueos.
- Manejo de errores: estados `error` en providers y widgets de error en UI; evita fallos silenciosos.
- Validación mínima de respuestas: parseo defensivo en entidades (`null-safety`, defaults, `clamp` en `genderRate`).
- CORS/Web: consumo de PokeAPI compatible con navegadores modernos.



## Estructura de carpetas principal
- `lib/core` – utilidades base (red)
- `lib/features/pokemon` – feature principal con Data/Domain/Presentation
- `assets/images` – recursos gráficos (tipos, pokebola, onboarding)

