# Chuck Norris Jokes - Ejercicio API / Listado / Detalle (Flutter)

## Descripción
App de ejemplo que consume la API pública `https://api.chucknorris.io/jokes/random`. Muestra un listado de chistes (cada ítem con texto y avatar si existe) y permite navegar a una pantalla de detalle.

## Endpoint principal
- `GET https://api.chucknorris.io/jokes/random`
- Ejemplo de respuesta:
```json
{
  "icon_url" : "https://api.chucknorris.io/img/avatar/chuck-norris.png",
  "id" : "V5qCDV4rSO-hs1KqltOXqA",
  "url" : "",
  "value" : "Chuck Norris can move quicker then the blink of an eye"
}
