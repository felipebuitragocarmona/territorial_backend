## Contexto

Los municipios y alcaldías en Colombia enfrentan un reto permanente: conocer con precisión el estado real de sus territorios para tomar decisiones que mejoren la calidad de vida de sus comunidades. Sin embargo, la información territorial suele estar dispersa, desactualizada o fragmentada entre dependencias, lo que dificulta la planificación, la asignación de recursos y la respuesta oportuna ante problemáticas sociales y físicas del entorno urbano.

A esto se suma que los ciudadanos, quienes habitan y experimentan el territorio de manera cotidiana, carecen de canales efectivos para reportar situaciones que afectan su entorno —focos de contaminación, deterioro de la malla vial, acumulación de residuos, entre otros— y hacer seguimiento a su atención.

---

## Problema que aborda

La ausencia de una herramienta integrada que articule información espacial, social y comunitaria impide que las alcaldías cuenten con una visión unificada del territorio. Los funcionarios trabajan con datos inconexos, las decisiones se toman sin soporte geográfico actualizado y la participación ciudadana en la gestión territorial es mínima o inexistente.

---

## Propósito del sistema

El sistema de valoración territorial es una plataforma digital diseñada para apoyar a las alcaldías en el reconocimiento, caracterización y cuidado de sus comunidades. Integra tres componentes fundamentales:

|Componente|Descripción|
|---|---|
|**Espacial**|Permite demarcar y visualizar el territorio mediante polígonos geoespaciales que definen departamentos, ciudades, comunas y barrios sobre un mapa interactivo|
|**Social**|Registra anotaciones territoriales —reportes de ciudadanos y funcionarios— categorizadas, geolocalizadas y respaldadas con evidencia fotográfica|
|**Comunitario**|Involucra activamente al ciudadano como agente de reporte y calificación, y a las entidades como partes interesadas en la gestión territorial|

---

## Actores

| Actor             | Descripción                                                               |
| ----------------- | ------------------------------------------------------------------------- |
| **Funcionario**   | Profesional de la alcaldía que demarca territorios y gestiona anotaciones |
| **Ciudadano**     | Habitante que reporta eventualidades y califica anotaciones               |
| **Administrador** | Gestiona usuarios, entidades, categorías y configuración del sistema      |

---

## Módulo 1 — Administración de entidades del sistema

### CU-01 Gestionar Entidades

|Campo|Descripción|
|---|---|
|**Actor**|Administrador|
|**Precondición**|El administrador está autenticado|
|**Postcondición**|La entidad queda creada, editada o eliminada en el sistema|

| Paso | Actor         | Acción                                                                                                                                                                                                                                                              |
| ---- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1    | Administrador | Accede al módulo de entidades                                                                                                                                                                                                                                       |
| 2    | Administrador | Ingresa nombre y datos de la entidad tales como : Nombre, descripción, tipo de entidad (pública o privada), nit, teléfono, correo electrónico, dirección, y estado (activa, inactiva). Además debe permitir subir la imagen de un logo tipo subida desde el sistema |
| 3    | Sistema       | Valida que no exista una entidad con el mismo nombre                                                                                                                                                                                                                |
| 4    | Sistema       | Guarda la entidad                                                                                                                                                                                                                                                   |

| #   | Flujo alternativo                                                                           |
| --- | ------------------------------------------------------------------------------------------- |
| 3a  | Ya existe una entidad con ese nombre → el sistema notifica y cancela                        |
| E1  | Editar: el administrador modifica los datos → el sistema valida y actualiza                 |
| E2  | Eliminar: el sistema verifica que la entidad no tenga funcionarios ni interesados asociados |
| E2a | Tiene dependencias → el sistema impide la eliminación y lista los registros dependientes    |

---

### CU-02 Gestionar Funcionarios

| Campo             | Descripción                                                               |
| ----------------- | ------------------------------------------------------------------------- |
| **Actor**         | Administrador                                                             |
| **Precondición**  | El administrador está autenticado; existe al menos una entidad registrada |
| **Postcondición** | El funcionario queda creado, editado, desactivado o eliminado             |

| Paso | Actor         | Acción                                                                   |
| ---- | ------------- | ------------------------------------------------------------------------ |
| 1    | Administrador | Accede al módulo de entidades, e ingresa a la opción agregar funcionario |
| 2    | Administrador | Ingresa nombre, correo, cargo, rol, celular                              |
| 3    | Sistema       | Valida que el correo no esté registrado previamente                      |
| 4    | Sistema       | Crea el funcionario y le asigna el rol correspondiente                   |


| #   | Flujo alternativo                                                                  |
| --- | ---------------------------------------------------------------------------------- |
| 3a  | El correo ya existe → el sistema notifica y cancela                                |
| E1  | Editar: el administrador modifica datos o cambia de entidad → el sistema actualiza |
| E3  | Eliminar: solo si el funcionario no tiene anotaciones ni demarcaciones asociadas   |

---

### CU-03 Gestionar Ciudadanos

| Campo             | Descripción                                               |
| ----------------- | --------------------------------------------------------- |
| **Actor**         | Administrador, Sistema                                    |
| **Precondición**  | El administrador está autenticado                         |
| **Postcondición** | El ciudadano queda registrado o actualizado en el sistema |

| Paso | Actor         | Acción                                                                             |
| ---- | ------------- | ---------------------------------------------------------------------------------- |
| 1    | Administrador | Ingresa los datos de nombre, correo, celular y dirección (pin colocado en el mapa) |
| 2    | Sistema       | Guarda los datos                                                                   |
| 3    | Administrador | Puede consultar o eliminar ciudadanos desde el panel                               |

---

### CU-04 Gestionar Categorías y Subcategorías

|Campo|Descripción|
|---|---|
|**Actor**|Administrador|
|**Precondición**|El administrador está autenticado|
|**Postcondición**|La categoría o subcategoría queda creada, editada o eliminada|

| Paso | Actor         | Acción                                                                                  |
| ---- | ------------- | --------------------------------------------------------------------------------------- |
| 1    | Administrador | Accede al módulo de categorías                                                          |
| 2    | Administrador | Ingresa el nombre de la categoría y puede subir una imagen que simboliza su significado |
| 3    | Administrador | Opcionalmente selecciona una categoría padre para crear subcategoría                    |
| 4    | Sistema       | Guarda la categoría con su relación jerárquica                                          |

| #   | Flujo alternativo                                                                   |
| --- | ----------------------------------------------------------------------------------- |
| E1  | Editar: se puede cambiar nombre o reasignar categoría padre                         |
| E2  | Eliminar: el sistema verifica que no tenga subcategorías ni anotaciones asociadas   |
| E2a | Tiene dependencias → el sistema impide la eliminación y sugiere reasignar antes     |

---

### CU-05 Gestionar Comunas

| Campo             | Descripción                                                              |
| ----------------- | ------------------------------------------------------------------------ |
| **Actor**         | Administrador                                                            |
| **Precondición**  | El administrador está autenticado; existe al menos una ciudad registrada |
| **Postcondición** | La comuna queda creada, editada o eliminada en el sistema                |

| Paso | Actor         | Acción                                                                                   |
| ---- | ------------- | ---------------------------------------------------------------------------------------- |
| 1    | Administrador | Accede al módulo de comunas                                                              |
| 2    | Administrador | Selecciona el departamento y la ciudad a la que pertenece la comuna                      |
| 3    | Sistema       | Consulta la API Colombia  para verificar y autocompletar datos del departamento y ciudad |
| 4    | Administrador | Ingresa el nombre de la comuna                                                           |
| 5    | Sistema       | Valida que no exista una comuna con el mismo nombre en esa ciudad                        |
| 6    | Sistema       | Guarda la comuna asociada a la ciudad                                                    |

| #   | Flujo alternativo                                                                           |
| --- | ------------------------------------------------------------------------------------------- |
| 5a  | Ya existe una comuna con ese nombre en la ciudad → el sistema notifica y cancela            |
| E1  | Editar: el administrador modifica el nombre → el sistema valida y actualiza                 |
| E2  | Eliminar: el sistema verifica que la comuna no tenga barrios asociados antes de eliminar    |
| E2a | La comuna tiene barrios → el sistema impide la eliminación y lista los barrios dependientes |

---

### CU-06 Gestionar Barrios

|Campo|Descripción|
|---|---|
|**Actor**|Administrador|
|**Precondición**|El administrador está autenticado; existe al menos una comuna registrada|
|**Postcondición**|El barrio queda creado, editado o eliminado en el sistema|

|Paso|Actor|Acción|
|---|---|---|
|1|Administrador|Accede al módulo de barrios|
|2|Administrador|Selecciona la comuna a la que pertenece el barrio|
|3|Administrador|Ingresa el nombre del barrio|
|4|Sistema|Valida que no exista un barrio con el mismo nombre en esa comuna|
|5|Sistema|Guarda el barrio asociado a la comuna|

|#|Flujo alternativo|
|---|---|
|4a|Ya existe un barrio con ese nombre en la comuna → el sistema notifica y cancela|
|E1|Editar: el administrador modifica el nombre → el sistema valida y actualiza|
|E2|Eliminar: el sistema verifica que el barrio no tenga puntos ni anotaciones asociadas|
|E2a|El barrio tiene puntos o anotaciones → el sistema impide la eliminación y lista los dependientes|

---

## Módulo 2 — Autenticación

### CU-07 Iniciar sesión con OAuth

| Campo             | Descripción                                           |
| ----------------- | ----------------------------------------------------- |
| **Actor**         | Funcionario, Ciudadano, Administrador                 |
| **Precondición**  | El usuario tiene cuenta en Google, Microsoft o GitHub |
| **Postcondición** | El usuario queda autenticado con su rol asignado      |

|Paso|Actor|Acción|
|---|---|---|
|1|Usuario|Accede al sistema y selecciona proveedor (Google / Microsoft / GitHub)|
|2|Sistema|Redirige al proveedor OAuth correspondiente|
|3|Proveedor|Autentica al usuario y retorna token|
|4|Sistema|Valida el token y asigna rol según usuario registrado|
|5|Sistema|Crea sesión y redirige al módulo principal|

|#|Flujo alternativo|
|---|---|
|3a|El proveedor rechaza la autenticación → el sistema muestra error y permite reintentar|
|4a|El usuario no está registrado → el sistema solicita completar perfil antes de continuar|

---

### CU-08 Cerrar sesión

|Campo|Descripción|
|---|---|
|**Actor**|Funcionario, Ciudadano, Administrador|
|**Precondición**|El usuario tiene sesión activa|
|**Postcondición**|La sesión queda destruida y se redirige al login|

|Paso|Actor|Acción|
|---|---|---|
|1|Usuario|Selecciona cerrar sesión|
|2|Sistema|Invalida el token de sesión|
|3|Sistema|Redirige al login|

---

## Módulo 3 — Gestión territorial (mapa interactivo)

### CU-09 Demarcar puntos de un barrio

|Campo|Descripción|
|---|---|
|**Actor**|Funcionario|
|**Precondición**|El funcionario está autenticado; el barrio existe en el sistema|
|**Postcondición**|El barrio queda demarcado con sus coordenadas persistidas|

|Paso|Actor|Acción|
|---|---|---|
|1|Funcionario|Selecciona un barrio desde el panel lateral|
|2|Sistema|Carga el mapa interactivo centrado en el barrio|
|3|Funcionario|Hace clic sobre el mapa para agregar coordenadas (puntos)|
|4|Sistema|Une los puntos formando un polígono en tiempo real|
|5|Funcionario|Guarda el polígono|
|6|Sistema|Persiste las coordenadas y asocia el polígono al barrio|

|#|Flujo alternativo|
|---|---|
|3a|El funcionario arrastra un punto existente → el sistema actualiza el polígono en tiempo real|
|5a|El polígono no está cerrado → el sistema cierra automáticamente uniendo el último punto con el primero|

---

### CU-10 Editar polígono de barrio

|Campo|Descripción|
|---|---|
|**Actor**|Funcionario|
|**Precondición**|El barrio tiene al menos un polígono guardado|
|**Postcondición**|El polígono queda actualizado en el sistema|

|Paso|Actor|Acción|
|---|---|---|
|1|Funcionario|Selecciona el barrio a editar|
|2|Sistema|Muestra el polígono existente con sus puntos editables|
|3|Funcionario|Agrega, mueve o elimina puntos|
|4|Funcionario|Guarda los cambios|
|5|Sistema|Actualiza las coordenadas persistidas|

---

### CU-11 Ver ubicación en tiempo real de funcionarios

|Campo|Descripción|
|---|---|
|**Actor**|Administrador, Funcionario|
|**Precondición**|Los funcionarios tienen sesión activa y GPS habilitado|
|**Postcondición**|El usuario visualiza la ubicación actualizada de los funcionarios filtrados|

| Paso | Actor   | Acción                                                                 |
| ---- | ------- | ---------------------------------------------------------------------- |
| 1    | Usuario | Accede al mapa de seguimiento                                          |
| 2    | Sistema | Muestra los funcionarios activos como marcadores en el mapa            |
| 3    | Usuario | Filtra por entidad                                                     |
| 4    | Sistema | Actualiza los marcadores en tiempo real según posición del dispositivo |

|#|Flujo alternativo|
|---|---|
|3a|No hay funcionarios activos en la entidad filtrada → el sistema muestra mensaje informativo|
|4a|El funcionario pierde conexión → su marcador se muestra atenuado con la última posición conocida|

---

## Módulo 4 — Gestión de anotaciones

### CU-12 Crear anotación

| Campo             | Descripción                                                      |
| ----------------- | ---------------------------------------------------------------- |
| **Actor**         | Funcionario, Ciudadano                                           |
| **Precondición**  | El usuario está autenticado; existe al menos un barrio demarcado |
| **Postcondición** | La anotación queda registrada y visible en el mapa               |

| Paso | Actor   | Acción                                                             |
| ---- | ------- | ------------------------------------------------------------------ |
| 1    | Usuario | Hace clic sobre un punto del mapa                                  |
| 2    | Sistema | Abre formulario con coordenadas prellenadas                        |
| 3    | Usuario | Ingresa descripción, selecciona categoría(s) y adjunta fotografías |
| 4    | Sistema | Asocia la anotación al barrio                                      |
| 5    | Usuario | Asocia las entidades a las que les puede interesarles la anotación |
| 6    | Sistema | Guarda la anotación y la muestra en el mapa                        |

|#|Flujo alternativo|
|---|---|
|4a|El punto cae fuera de un barrio demarcado → el sistema alerta y pide confirmación para guardar sin barrio|


---

### CU-13 Calificar anotación

|Campo|Descripción|
|---|---|
|**Actor**|Ciudadano|
|**Precondición**|Existe al menos una anotación; el ciudadano está autenticado|
|**Postcondición**|La calificación queda registrada en Votación|

|Paso|Actor|Acción|
|---|---|---|
|1|Ciudadano|Selecciona una anotación en el mapa|
|2|Sistema|Muestra el detalle de la anotación|
|3|Ciudadano|Asigna calificación (1 a 5 estrellas) y escribe comentario|
|4|Sistema|Registra la calificación asociada al ciudadano y la anotación|

|#|Flujo alternativo|
|---|---|
|4a|El ciudadano ya calificó esa anotación → el sistema permite editar la calificación existente|

---
### CU-14 Visualizar anotaciones en el mapa por categoría y subcategoría

| Campo             | Descripción                                                                                                         |
| ----------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Actor**         | Funcionario, Ciudadano, Administrador                                                                               |
| **Precondición**  | El usuario está autenticado; existen anotaciones registradas en el sistema con categorías asignadas                 |
| **Postcondición** | El mapa muestra únicamente las anotaciones que corresponden a los filtros de categoría y subcategoría seleccionados |

|Paso|Actor|Acción|
|---|---|---|
|1|Usuario|Accede al módulo del mapa territorial|
|2|Sistema|Carga el mapa con todas las anotaciones visibles, cada una representada con un marcador de color según su categoría principal|
|3|Usuario|Abre el panel de filtros laterales|
|4|Sistema|Muestra el árbol jerárquico de categorías y subcategorías disponibles con el conteo de anotaciones por cada nodo|
|5|Usuario|Selecciona una o varias categorías del árbol|
|6|Sistema|Filtra en tiempo real las anotaciones del mapa mostrando solo las que pertenecen a las categorías seleccionadas|
|7|Usuario|Expande una categoría para ver sus subcategorías y selecciona una o varias subcategorías específicas|
|8|Sistema|Refina el filtro mostrando únicamente las anotaciones que coinciden con las subcategorías seleccionadas|
|9|Usuario|Hace clic sobre un marcador en el mapa|
|10|Sistema|Muestra el detalle de la anotación: descripción, categoría, subcategoría, evidencias fotográficas, calificación promedio y fecha de registro|

| #   | Flujo alternativo                                                                                                                                                                                                                |
| --- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 2a  | No existen anotaciones registradas → el sistema muestra el mapa vacío con un mensaje informativo                                                                                                                                 |
| 6a  | La categoría seleccionada no tiene anotaciones asociadas → el sistema informa que no hay registros para ese filtro y mantiene el panel activo                                                                                    |
| 7a  | La categoría no tiene subcategorías → el sistema lo indica visualmente y aplica el filtro solo a nivel de categoría                                                                                                              |
| 8a  | El usuario selecciona categoría padre y subcategoría hija simultáneamente → el sistema interpreta que se deben mostrar todas las anotaciones de la categoría padre incluyendo todas sus subcategorías                            |
| F1  | **Limpiar filtros:** el usuario hace clic en "Limpiar filtros" → el sistema restaura el mapa mostrando todas las anotaciones                                                                                                     |
| F2  | **Filtro por territorio combinado:** el usuario combina el filtro de categoría con un filtro de barrio o comuna → el sistema aplica ambos filtros simultáneamente y muestra solo las anotaciones que cumplan las dos condiciones |


---

## Módulo 5 — Reportes inteligentes (chat)

### CU-15 Consultar reporte mediante chat

|Campo|Descripción|
|---|---|
|**Actor**|Funcionario, Administrador|
|**Precondición**|El usuario está autenticado; existen datos en el sistema|
|**Postcondición**|El usuario obtiene el reporte visualizado en el formato seleccionado|

| Paso | Actor   | Acción                                                                                    |
| ---- | ------- | ----------------------------------------------------------------------------------------- |
| 1    | Usuario | Accede al módulo de reportes                                                              |
| 2    | Usuario | Escribe una pregunta en lenguaje natural                                                  |
| 3    | Sistema | Interpreta la consulta y genera datos de respuesta                                        |
| 4    | Sistema | Presenta la respuesta en cuatro formatos: barra simple, barra agrupada, circular y líneas |


|#|Flujo alternativo|
|---|---|
|3a|El sistema no interpreta la consulta → solicita reformular con sugerencias de ejemplo|
|3b|La consulta no retorna datos → informa que no hay registros para los filtros indicados|
|4a|Solo un tipo de gráfica aplica → el sistema deshabilita los formatos no pertinentes e indica el motivo|

--- Ejemplo detallado

Aquí está el caso de uso documentado para tu equipo:

---

## Caso de uso: Generación de reportes visuales

**Actor:** Cliente (frontend / consumidor de API)
**Endpoint:** `POST /reports`

---

### Descripción

El cliente envía una consulta al backend a través del endpoint `/reports`. El backend procesa la query, determina qué tipo de visualización corresponde, y retorna una estructura JSON lista para ser renderizada con ApexCharts.

---

### Flujo principal

**1. El cliente envía la petición**

```http
POST /reports
Content-Type: application/json

{
  "query": "ventas por región del último trimestre"
}
```

**2. El backend interpreta la query** y decide qué tipo de gráfica representa mejor los datos solicitados.

**3. El backend retorna una de tres respuestas posibles:**

---

**Respuesta A — Gráfica de pastel** *(distribución proporcional)*

```json
{
  "type": "pie",
  "labels": ["Team A", "Team B", "Team C", "Team D", "Team E"],
  "series": [44, 55, 13, 43, 22]
}
```

Úsala cuando los datos representen partes de un todo (porcentajes, participación de mercado, distribución por categoría).

---

**Respuesta B — Gráfica de barras** *(comparación entre categorías)*

```json
{
  "type": "bar",
  "series": [
    {
      "name": "Servings",
      "data": [44, 55, 41, 67, 22, 43, 21, 33, 45, 31, 87, 65, 35]
    }
  ]
}
```

Úsala cuando se comparen valores entre elementos distintos (productos, regiones, periodos).

---

**Respuesta C — Gráfica de líneas** *(tendencia en el tiempo)*

```json
{
  "type": "line",
  "series": [
    { "name": "High - 2013", "data": [28, 29, 33, 36, 32, 32, 33] },
    { "name": "Low - 2013",  "data": [12, 11, 14, 18, 17, 13, 13] }
  ]
}
```

Úsala cuando los datos muestren evolución temporal o tendencias con una o varias series.

---

### Responsabilidad del frontend

El frontend debe leer el campo `type` de la respuesta y renderizar el componente ApexCharts correspondiente. No necesita conocer de antemano qué tipo llegará — debe manejar los tres casos.

```typescript
switch (response.type) {
  case 'pie':  // renderizar PieChartComponent
  case 'bar':  // renderizar BarChartComponent
  case 'line': // renderizar LineChartComponent
}
```

---

### Códigos de respuesta HTTP

| Código | Situación |
|--------|-----------|
| `200 OK` | Query procesada correctamente, retorna el JSON de la gráfica |
| `400 Bad Request` | El campo `query` viene vacío o malformado |
| `422 Unprocessable` | La query no pudo asociarse a ningún tipo de gráfica |
| `500 Internal Server Error` | Error en el procesamiento del backend |

Aquí están los tres enlaces de referencia de ApexCharts que mencionaste:

| Tipo | Enlace |
|------|--------|
| 🥧 Pie | https://apexcharts.com/angular-chart-demos/pie-charts/simple-pie/ |
| 📊 Bar | https://apexcharts.com/angular-chart-demos/bar-charts/basic-bar/ |
| 📈 Line | https://apexcharts.com/angular-chart-demos/line-charts/line-with-data-labels/ |

---

