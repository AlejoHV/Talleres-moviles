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

