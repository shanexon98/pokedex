# Pokédex Flutter CC SHANEXON ORTIZ

Aplicación Flutter que consume la API pública de PokeAPI para listar, filtrar y ver el detalle de Pokémon.

URL de visualización del app

https://youtube.com/shorts/itpSjgRD8p4?feature=share

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


<img width="800" height="1500" alt="Simulator Screenshot - iPhone 16 Pro - 2025-10-22 at 00 54 08" src="https://github.com/user-attachments/assets/a33995b5-eadc-4784-8148-589e0d936aff" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-10-22 at 00 54 05" src="https://github.com/user-attachments/assets/24f96039-bf03-40b7-b225-6fa3a1303fda" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-10-22 at 00 53 55" src="https://github.com/user-attachments/assets/373ed024-4ae5-468c-8cc4-095245c4134c" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-10-22 at 00 53 45" src="https://github.com/user-attachments/assets/22c1d5c5-03f7-4849-b858-702aefb16972" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-10-22 at 00 53 39" src="https://github.com/user-attachments/assets/31feef3f-80f3-4867-91e4-96474b47dbda" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-10-22 at 00 53 35" src="https://github.com/user-attachments/assets/f7e20c22-f39b-4769-96d5-82ee9d4ff692" />

## Estructura de carpetas principal
- `lib/core` – utilidades base (red)
- `lib/features/pokemon` – feature principal con Data/Domain/Presentation
- `assets/images` – recursos gráficos (tipos, pokebola, onboarding)

