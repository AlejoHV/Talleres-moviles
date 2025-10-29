# Taller 1 - Flutter + Widgets + Git Flow

## Jose Alejandro Hernández Vallecilla
## 230222020

Para el desarrollo de este primer taller se realizó la práctica de lo aprendido en clase, aplicando los conceptos y la metodologia de git flow, el uso de los widgets más comunes de futter y la construción de una aplicación sencilla bajo la práctica de control de versiones usando ramas y StatefulWidget para evidenciar el uso de setState.

El presente taller cuenta con las siguientes características:
-
- Título inicial “Hola, Flutter” alternando con "¡Título cambiado!” bajo un ElevatedButton.
- Nombre del desarrollador con un Text centrado.
- Una imagen con Image.network() y dos imágenes con Image.asset().
- SnackBar con el mensaje: “Título actualizado” cada que se presiona cambiar título.  
- Widgets:
  - Container con márgenes, colores y estilos.
  - ListView con tres 3 elementos con icono y texto.
  - Stack superponiendo texto sobre una de las imagenes.
- Diseño visual organizado con Column, Row, Padding, SizedBox, Margin y alineaciones adecuadas.

# Capturas
<img width="301" height="620" alt="image" src="https://github.com/user-attachments/assets/c42254e0-84c8-4a07-ad7f-50dbd4790188" />
<img width="295" height="619" alt="image" src="https://github.com/user-attachments/assets/f74c207e-daf9-41d8-8120-ea713cd52d0a" />
<img width="298" height="619" alt="image" src="https://github.com/user-attachments/assets/83004cf3-4d7e-42bc-8e46-b2cf842df2e0" />

# Taller 2 - Navegación, widgets y ciclo de vida en Flutter

Las rutas principales (estructura), en el proyecto están definidas en app_router.dart así:
-
- / Inicio (HomeScreen)
- /vehiculos Panel de Vehículos con pestañas (VehiculosScreen)
- /paso_parametros Pantalla para enviar parámetros (PasoParametrosScreen)
- /detalle/:parametro/:metodo Pantalla de detalle que recibe dos parámetros en la URL:
    - parametro (el valor ingresado por el usuario)
    - metodo (el método de navegación usado: go, push, replace)
/ciclo_vida
Pantalla de ciclo de vida (CicloVidaScreen)

¿Cómo se envían parámetros?
- 
Los parámetros se envían en la URL usando dos puntos : en la definición de la ruta.

Widgets
-
Entre los widgets usados se encuentran GridView, TabBar y Stepper, la razón de usar estos dos primeros widgest es porque me permite mostrar una lista de elementos y manejar diferentes secciones dentro de una pantalla, mejorando la interactividad con el usuario y el orden. Por otro lado, el Stepper es visualmente atractivo y permite mostrar el avance de un proceso paso a paso. Esto ayuda a ilustrar el ciclo de vida del widget de manera más clara y didáctica, mostrando cómo cambia el estado y cómo se reconstruye la pantalla. 

# Capturas
<img width="310" height="619" alt="image" src="https://github.com/user-attachments/assets/9d058e79-a295-4235-8b86-1c0fc486f2e1" />
<img width="301" height="615" alt="image" src="https://github.com/user-attachments/assets/a83ccb3d-80d9-46a2-8368-17c1db97b461" />
<img width="285" height="613" alt="image" src="https://github.com/user-attachments/assets/edbda2d2-6ceb-42da-ab80-4d262603fc7e" />
<img width="305" height="620" alt="image" src="https://github.com/user-attachments/assets/e83d3eac-aa29-4f58-b04b-693b27f3beb0" />
<img width="309" height="620" alt="image" src="https://github.com/user-attachments/assets/10675e38-a040-4ba2-85ff-1fd0cbeeb8a1" />
<img width="309" height="620" alt="image" src="https://github.com/user-attachments/assets/e8d238ef-5842-45f2-942b-4672e9268073" />

# Taller 3 - Segundo plano, asincronía y servicios en Flutter

### 📘 Cuándo usar cada técnica

#### 🔹 **Future / async / await**

* **Uso recomendado:** Cuando necesitas realizar tareas **asíncronas no bloqueantes** que dependen del tiempo o de respuestas externas (como llamadas a API, lectura de archivos o consultas simuladas).
* **Ejemplo en el proyecto:** Se usó un `Future.delayed()` de 2–3 segundos para simular la carga de datos desde un servicio.
* **Ventaja:** Permite mantener la **UI fluida** mientras esperas el resultado.
* **Estados mostrados:**

  * `Cargando...` mientras el Future está en ejecución.
  * `Éxito` cuando los datos se cargan correctamente.
  * `Error` cuando ocurre una falla simulada.
* **Ejecución controlada:** Con `async/await`, se imprime en consola el orden de ejecución antes, durante y después del proceso, demostrando la asincronía controlada.

---

#### 🔹 **Timer**

* **Uso recomendado:** Cuando necesitas ejecutar código **de manera periódica o temporizada**, como cronómetros, animaciones o tareas repetitivas.
* **Ejemplo en el proyecto:** Se implementó un **cronómetro** con botones para:

  * `Iniciar`
  * `Pausar`
  * `Reanudar`
  * `Reiniciar`
* **Frecuencia de actualización:** Cada 1 segundo (o cada 100 ms si se requieren milisegundos).
* **Buenas prácticas:**

  * Cancelar el `Timer` al pausar o al salir de la vista para **liberar recursos**.
  * Usar `setState` para reflejar el cambio del tiempo en la interfaz.

---

#### 🔹 **Isolate**

* **Uso recomendado:** Para ejecutar **tareas pesadas o de alto consumo de CPU** sin bloquear el hilo principal de la interfaz.
* **Ejemplo en el proyecto:** Se implementó un cálculo intensivo (sumas o promedios grandes) que se ejecuta en un `Isolate` usando `Isolate.spawn`.
* **Comunicación:** Se envía y recibe información a través de **mensajes** entre el isolate y la UI.
* **Ventaja:** La aplicación sigue siendo **responsiva**, mostrando los resultados finales en pantalla junto con los tiempos de ejecución.
* **Casos típicos:** Procesamiento de datos, cálculos matemáticos, generación de informes o imágenes.

---

### 🖼️ Diagramas y flujos de pantallas

#### 📱 Lista de pantallas principales:

1. **Menú principal:**

   * Permite navegar entre las tres secciones: *Future*, *Cronómetro* y *Isolate*.

2. **Pantalla de Future (Asincronía):**

   * Muestra los estados `Cargando`, `Éxito` o `Error`.
   * Incluye impresión en consola del orden de ejecución.

3. **Pantalla de Cronómetro (Timer):**

   * Botones: Iniciar / Pausar / Reanudar / Reiniciar.
   * Muestra el tiempo transcurrido en un `Text` grande tipo marcador.

4. **Pantalla de Proceso Pesado (Isolate):**

   * Botón para ejecutar el cálculo pesado.
   * Muestra el tiempo de inicio, los resultados del cálculo y los tiempos de respuesta.

---

### 🔄 Flujo general del proyecto

```
[Menú Principal]
      │
      ├──> [Future: carga simulada con async/await]
      │          ↓
      │       (Estados: Cargando → Éxito/Error)
      │
      ├──> [Cronómetro: Timer]
      │          ↓
      │   (Iniciar ↔ Pausar ↔ Reanudar ↔ Reiniciar)
      │
      └──> [Isolate: proceso pesado]
                 ↓
        (Ejecución en hilo separado)
        (Resultado enviado a la UI)
```

# Capturas
<img width="300" height="620" alt="image" src="https://github.com/user-attachments/assets/feedbe5e-deca-4ef4-8cfb-a175713202b9" />
<img width="300" height="620" alt="image" src="https://github.com/user-attachments/assets/54610357-9e61-40d7-8c68-fda38dd03837" />
<img width="300" height="620" alt="image" src="https://github.com/user-attachments/assets/b4970dd4-b586-4686-aae9-62d327108537" />
<img width="300" height="620" alt="image" src="https://github.com/user-attachments/assets/3307cacf-0d11-4d2c-b910-94ff6e5d63a1" />
<img width="300" height="620" alt="image" src="https://github.com/user-attachments/assets/134e118e-2e42-4f58-94ca-96fe80728d51" />
<img width="300" height="620" alt="image" src="https://github.com/user-attachments/assets/43a3b6f7-9adf-45b9-905b-782f8aeab5ea" />

# Taller 4 - Peticiones HTTP y Consumo de API Pública en Flutter

API Utilizada: Marvel Developer API
- 
### - Endpoint Principal: 
`` GET https://gateway.marvel.com/v1/public/characters ``
### - Autenticación Requerida:

- Parámetros de query: ts, apikey, hash
- Sistema de autenticación HMAC-MD5

### - Ejemplo de Respuesta JSON
```
{
  "code": 200,
  "status": "Ok",
  "data": {
    "offset": 0,
    "limit": 20,
    "total": 1493,
    "count": 20,
    "results": [
      {
        "id": 1011334,
        "name": "3-D Man",
        "description": "",
        "modified": "2014-04-29T14:18:17-0400",
        "thumbnail": {
          "path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
          "extension": "jpg"
        },
        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011334",
        "comics": {
          "available": 12,
          "collectionURI": "http://gateway.marvel.com/v1/public/characters/1011334/comics",
          "items": [
            {
              "resourceURI": "http://gateway.marvel.com/v1/public/comics/21366",
              "name": "Avengers: The Initiative (2007) #14"
            }
          ]
        }
      }
    ]
  }
}
```
Arquitectura
- 
```
lib/
  │
  ├── services/
  │   └── marvel_service.dart
  ├── views/
  │   └── marvel/
  │       ├── personajes_list_screen.dart
  │       └── personajes_detail_screen.dart

```
Rutas definidas
-
<img width="524" height="275" alt="image" src="https://github.com/user-attachments/assets/094f1ae2-b44a-4634-8d1c-a60841665b5c" />

Capturas
-
<img width="320" height="650" alt="image" src="https://github.com/user-attachments/assets/26d84008-b828-484a-b345-d6090e21a9d6" />
<img width="320" height="650" alt="image" src="https://github.com/user-attachments/assets/8afa2443-6c5a-46ad-bd04-70723baa779b" />
<img width="320" height="650" alt="image" src="https://github.com/user-attachments/assets/78007b6e-6af4-448f-b568-d5248d5d18a2" />
<img width="320" height="650" alt="image" src="https://github.com/user-attachments/assets/2f94c7a5-79b6-46df-af5b-658e05c9c36e" />
<img width="320" height="650" alt="image" src="https://github.com/user-attachments/assets/caa62e18-7424-47a2-a52c-dd64a4afa700" />
<img width="320" height="650" alt="image" src="https://github.com/user-attachments/assets/a9b06d79-34ac-4cc5-aecf-03b7c4ffc386" />
<img width="320" height="650" alt="image" src="https://github.com/user-attachments/assets/fd3493f8-b03d-47a5-8d3c-1bc7076fdf77" />
<img width="320" height="650" alt="image" src="https://github.com/user-attachments/assets/99b338b5-909e-4b9d-8a75-d4e1e3a156f3" />
<img width="320" height="650" alt="image" src="https://github.com/user-attachments/assets/600e4db5-a0cd-4f51-be63-a46bf2e447cb" />

# Taller 1 - Distribución de APK con Firebase App Distribution

Descripción Flujo de Distribución
-
Generar APK → Firebase App Distribution → Notificar Testers → Instalación → Feedback → Actualización

```
1. Generar APK: Compilación de la aplicación en modo release
2. App Distribution: Subida a Firebase para distribución controlada
3. Testers: Invitación a usuarios específicos para testing
4. Instalación: Descarga e instalación en dispositivos Android
5. Actualización: Ciclo iterativo de mejoras y nuevas versiones
```
Publicación
-
### Pasos para Publicar una Nueva Versión

#### 1. Preparación del Código
```
Actualizar versionado en android/app/build.gradle
versionCode = X  # Incrementar numéricamente (1 en 1)
versionName = "X.X.X"  # Seguir versionado semántico (1.0.0)
```
#### 2. Generación del APK
```
# Limpiar y construir
flutter clean
flutter pub get
flutter build apk
```
#### 3. Distribución en Firebase
```
# El APK se genera en:
# build/app/outputs/flutter-apk/app-release.apk
```
#### 4. Subir a Firebase Console
```
  1. Acceder a Firebase Console
  2. Ir a App Distribution → Releases
  3. Subir APK y seleccionar archivo generado
  4. Asignar al grupo QA_Clase
  5. Agregar Release Notes descriptivas
```
#### 5. Notificación a Testers
```
Los testers reciben email de invitación automáticamente
Pueden instalar directamente desde el enlace
```

Versionado
-
## Esquema de Versionado

He utilizado el versionado semántico: versionName.versionCode

Ejemplo: 1.0.1+2 donde:
- 1.0.0: versionName (visible al usuario)
- +1: versionCode (incremental interno)

## Historial de Versiones
| Versión |	Version Code |	Cambios Principales |
| :--- | :---: | ---: |
|1.0.0 |1 |	Release inicial - Estructura base |
|1.0.1 |2 |	Rediseño menú principal + mejoras UI|

## Configuración en build.gradle
```
android {
    defaultConfig {
        applicationId "con.example.talleresmoviles"
        versionCode 2      // Incrementar por cada build
        versionName "1.0.1" // Versión semántica
    }
}
```
## Release Notes
### Formato Estándar
```
# TÍTULO DESCRIPTIVO - [App Name] v[Versión]

## INFORMACIÓN DE LA VERSIÓN
- Versión: [X.X.X]
- Fecha: [Fecha distribución]
- Tipo: [Release inicial/Bug fix/Nueva feature]

## CAMBIOS PRINCIPALES
### MEJORAS IMPLEMENTADAS
- [ ] [Descripción específica del cambio]
- [ ] [Beneficio para el usuario]

### CORRECCIONES
- [ ] [Problema resuelto]

## INSTRUCCIONES PARA TESTERS
1. [Pasos específicos para probar]
2. [Comportamiento esperado]

## CONTACTO
- Desarrollador: [Nombre]
- Reportar issues: [Email]
```
### Ejemplo básico de la versión 1.0.1
```
# 🎨 ACTUALIZACIÓN DE INTERFAZ - Talleres Móviles v1.0.1

## 📋 INFORMACIÓN
- Versión 1.0.1 → 1.0.0
- Fecha 20/10/2025
- Tipo Mejora de interfaz y experiencia de usuario

## 🔄 CAMBIOS PRINCIPALES
### 🎯 MEJORAS VISUALES
- Rediseño del Menú Principal
- Título "Menú Principal" agregado
- Subtítulo "Navegación de la App"
- Mejor jerarquía visual

## 🧪 PARA TESTERS
1. Verificar nuevo diseño del menú
2. Confirmar navegación funcional
3. Validar usabilidad mejorada
```
Capturas
-
<img width="920" height="533" alt="image" src="https://github.com/user-attachments/assets/337f7886-0fd9-4735-ac40-49e109de9765" />
<img width="929" height="340" alt="image" src="https://github.com/user-attachments/assets/0d062717-74d7-4e07-80fd-7b5738ba935f" />
<img width="390" height="800" alt="image" src="https://github.com/user-attachments/assets/de78a044-b103-4a54-97b1-05a14444da52" />
<img width="390" height="800" alt="image" src="https://github.com/user-attachments/assets/faf93c32-0304-4e0d-9231-8cc4ddc274b6" />
<img width="390" height="1004" alt="image" src="https://github.com/user-attachments/assets/18bfc170-2beb-4fb9-b58b-eb68ff6c75db" />
<img width="390" height="1004" alt="image" src="https://github.com/user-attachments/assets/d0eb2e1b-f778-46a3-af5f-4a19de4a5157" />


# Taller 2 - autenticación JWT

## Módulo de Autenticación JWT
### Objetivo
- Manejar estados de carga, éxito y error mediante servicios, repositorios y notifiers.
- Persistir datos sensibles (tokens) en `flutter_secure_storage` y no sensibles (nombre, correo, tema, idioma) en `shared_preferences`.
- Exponer una vista de evidencia que muestre la información almacenada localmente y permita cerrar sesión.
### Implementación principal
- **Servicios HTTP:** `auth_api_service` consume los endpoints `/api/login` y `/api/users` del API de Parqueadero (Swagger), encapsulando manejo de errores y parseo de respuestas.
- **Repositorio:** `auth_repository` orquesta autenticación, persistencia en almacenamiento seguro y lectura/escritura de preferencias.
- **Gestión de estado:** `auth_notifier` y `auth_state` controlan los estados `loading`, `authenticated`, `error` y `idle`, notificando a las pantallas.
- **Almacenamiento local:**
 - `flutter_secure_storage`: `access_token`, `token_type`.
 - `shared_preferences`: nombre, correo, apellido, tema, idioma.
- **Vista de evidencia:** `evidence_screen` muestra los datos persistidos, indica si existe token y expone botón de cierre de sesión que limpia ambos almacenamientos.
### Flujo resumido
1. El usuario registra o inicia sesión desde el formulario; las credenciales viajan como JSON al backend de la API.
2. El backend responde con JWT; el repositorio guarda tokens y datos en los almacenamientos correspondientes.
3. `auth_notifier` actualiza el estado a `authenticated`, permitiendo navegar al resto de la app.
4. Desde el menú se accede a la pantalla de evidencia para consultar la información guardada o cerrar sesión.
### Evidencias
- **Solicitud exitosa de login:** captura mostrando respuesta 200 con token JWT.
- **Vista Evidencia de Sesión:** pantalla que lista nombre, correo, tema, idioma y estado del token.
- **Limpieza de datos:** mensaje "Datos locales eliminados" tras pulsar el botón de cerrar sesión.
---
## Capturas
  - Clase AuthApiService

<img width="900" height="500" alt="image" src="https://github.com/user-attachments/assets/601939d8-8a18-49b8-8445-7f7b06533004" />
<img width="900" height="500" alt="image" src="https://github.com/user-attachments/assets/7dedd2ac-30cc-4483-86c0-6a7f19bca7e3" />

  - Clase AuthRepository

<img width="900" height="500" alt="image" src="https://github.com/user-attachments/assets/926e33a5-f2be-4946-97c3-d021c5b8ad1f" />

  - Clase AuthLocalStorage

<img width="900" height="600" alt="image" src="https://github.com/user-attachments/assets/380ec52c-60b2-4f15-90cc-d56b57f5fbd9" />

  - Pantalla de Login y Registro de usuarios (Mensajes y estatus de error: Error de validación, Credenciales invalidas y requisitos mínimos de contraseña)

<img width="360" height="800" alt="image" src="https://github.com/user-attachments/assets/b15f7083-db06-4c38-8bfc-dafe34af4428" />
<img width="360" height="800" alt="image" src="https://github.com/user-attachments/assets/5554c1af-55cf-49fd-8661-6600b6077693" />
<img width="360" height="800" alt="image" src="https://github.com/user-attachments/assets/51b430b3-771b-46d4-8785-94d7d9554528" />
<img width="360" height="800" alt="image" src="https://github.com/user-attachments/assets/815b3490-cdcf-491e-968b-5af8e1a7ea74" />
<img width="360" height="800" alt="image" src="https://github.com/user-attachments/assets/f754220a-63ff-4d91-abfc-f76a29bd01ba" />

  - Pantalla de Evidencia antes y despues de cerrar seción   

<img width="360" height="800" alt="image" src="https://github.com/user-attachments/assets/83f00403-e90e-4899-8c4f-9009ac4156ba" />
<img width="360" height="800" alt="image" src="https://github.com/user-attachments/assets/9f2049ac-8c6f-4f77-90bc-88da365845a8" />
<img width="360" height="800" alt="image" src="https://github.com/user-attachments/assets/f5bab71f-67d8-440f-a4fc-dcc116fb9e7b" />

