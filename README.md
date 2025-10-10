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

