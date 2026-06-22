# App de Gestión de Dispositivos (Flutter) 📱

Aplicación multiplataforma desarrollada en Flutter y Dart. Permite gestionar un catálogo de dispositivos conectándose a una API REST (MockAPI) para leer y guardar registros de forma asíncrona.

## 🚀 Cómo Compilar y Ejecutar

Si acabas de clonar este repositorio, sigue estos pasos para poder compilar y ejecutar el proyecto en tu entorno local:

1. **Asegúrate de tener Flutter instalado**. Puedes comprobarlo ejecutando `flutter doctor` en tu terminal.
2. **Descarga las dependencias**. Abre tu terminal en la carpeta principal del proyecto (donde está este archivo) y ejecuta:
   ```bash
   flutter pub get
   ```
   *(Este comando leerá el archivo `pubspec.yaml` e instalará paquetes necesarios como `http`).*

3. **Ejecuta la aplicación**. Usa el siguiente comando para lanzarla en tu emulador Android/iOS activo, o en tu navegador web (Chrome):
   ```bash
   flutter run
   ```
   *(Nota: si tienes múltiples dispositivos conectados, puedes especificar uno, por ejemplo: `flutter run -d chrome`).*

---

## 🧠 Explicación de la Arquitectura del Código

El código está estructurado separando la interfaz visual de la lógica de red. Todo reside dentro de la carpeta `lib/`:

### 1. `models/device.dart` (Modelado de Datos)
Aquí definimos cómo luce nuestro objeto en memoria.
- Usamos una clase `Device` con los campos correspondientes a la base de datos (name, brand, price).
- Implementamos un constructor `factory Device.fromJson(Map<String, dynamic> json)`. Este método actúa como traductor: mapea los datos crudos en formato JSON de la MockAPI hacia un objeto estructurado en Dart, agregando valores por defecto si algún dato viene nulo para evitar *crashes* en la aplicación.

### 2. `services/api_service.dart` (Capa de Red)
Este archivo se encarga exclusivamente de las llamadas HTTP hacia el servidor utilizando la librería `http`:
- **`getDevices()`:** Hace un método GET (`http.get`), decodifica el JSON de la respuesta y construye una lista de objetos `Device`.
- **`createDevice(Device device)`:** Convierte un nuevo dispositivo Dart de vuelta a texto JSON con `json.encode` y hace un POST hacia la base de datos de MockAPI.
- *Gestión de Excepciones:* Ambas funciones incluyen bloques `try/catch` para interceptar errores de conexión a internet o fallos 404/500 del servidor, lanzando excepciones que la pantalla capturará luego.

### 3. `main.dart` (Interfaz de Usuario)
El núcleo visual de nuestra App:
- Utilizamos un componente de tipo **`StatefulWidget`** (Widget con estado), lo cual nos permite retener en memoria la lista de dispositivos (`_devices`) y si la página está cargando (`_isLoading`).
- Cuando hacemos una llamada de red exitosa, usamos la función `setState()`. Esto le comunica a Flutter que los datos cambiaron para que vuelva a "pintar" o renderizar la lista en la pantalla.
- *Carga Inicial:* Se sobreescribe la función `initState()` para que, apenas la pantalla cargue por primera vez, ejecute el GET automático de datos de internet.
- *Feedback Visual:* Los avisos al usuario se proveen nativamente usando el `ScaffoldMessenger` para invocar un `SnackBar` (una barra inferior verde o roja) de manera no intrusiva.
