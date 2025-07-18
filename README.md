# EXAMENT MYSQL

Realiza las tareas descritas a continuación. Asegúrate de documentar cada paso y explicar las decisiones tomadas en el desarrollo de cada consulta, procedimiento, función, trigger y evento.


Base de Datos e Inserciones: Enlace.
Requerimientos del Examen

## Consultas SQL:

Realiza las siguientes consultas en SQL relacionadas con el sistema de alquiler de películas:

   1. Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 6 meses.
    2. Lista las cinco películas más alquiladas durante el último año.
    3. Obtén el total de ingresos y la cantidad de alquileres realizados por cada categoría de película.
    4. Calcula el número total de clientes que han realizado alquileres por cada idioma disponible en un mes específico.
    5. Encuentra a los clientes que han alquilado todas las películas de una misma categoría.
    6. Lista las tres ciudades con más clientes activos en el último trimestre.
    7. Muestra las cinco categorías con menos alquileres registrados en el último año.
    8. Calcula el promedio de días que un cliente tarda en devolver las películas alquiladas.
    9. Encuentra los cinco empleados que gestionaron más alquileres en la categoría de Acción.
    10. Genera un informe de los clientes con alquileres más recurrentes.
     11. Calcula el costo promedio de alquiler por idioma de las películas.
    12. Lista las cinco películas con mayor duración alquiladas en el último año.
     13. Muestra los clientes que más alquilaron películas de Comedia.
     14. Encuentra la cantidad total de días alquilados por cada cliente en el último mes.
     15. Muestra el número de alquileres diarios en cada almacén durante el último trimestre.
     16. Calcula los ingresos totales generados por cada almacén en el último semestre.
     17. Encuentra el cliente que ha realizado el alquiler más caro en el último año.
     18. Lista las cinco categorías con más ingresos generados durante los últimos tres meses.
 19. Obtén la cantidad de películas alquiladas por cada idioma en el último mes.
    20. Lista los clientes que no han realizado ningún alquiler en el último año.

## Funciones SQL:

### Desarrolla las siguientes funciones:

    1. TotalIngresosCliente(ClienteID, Año): Calcula los ingresos generados por un cliente en un año específico.
    2. PromedioDuracionAlquiler(PeliculaID): Retorna la duración promedio de alquiler de una película específica.
    3. IngresosPorCategoria(CategoriaID): Calcula los ingresos totales generados por una categoría específica de películas.
    4. DescuentoFrecuenciaCliente(ClienteID): Calcula un descuento basado en la frecuencia de alquiler del cliente.
    5. EsClienteVIP(ClienteID): Verifica si un cliente es "VIP" basándose en la cantidad de alquileres realizados y los ingresos generados.

## Triggers:

### Implementa los siguientes triggers:

    1. ActualizarTotalAlquileresEmpleado: Al registrar un alquiler, actualiza el total de alquileres gestionados por el empleado correspondiente.
    2. AuditarActualizacionCliente: Cada vez que se modifica un cliente, registra el cambio en una tabla de auditoría.
    3.RegistrarHistorialDeCosto: Guarda el historial de cambios en los costos de alquiler de las películas.
    4. NotificarEliminacionAlquiler: Registra una notificación cuando se elimina un registro de alquiler.
    5. RestringirAlquilerConSaldoPendiente: Evita que un cliente con saldo pendiente pueda realizar nuevos alquileres.

## Eventos SQL:

### Crea los siguientes eventos:

    1. InformeAlquileresMensual: Genera un informe mensual de alquileres y lo almacena automáticamente.
    2. ActualizarSaldoPendienteCliente: Actualiza los saldos pendientes de los clientes al final de cada mes.
    3. AlertaPeliculasNoAlquiladas: Envía una alerta cuando una película no ha sido alquilada en el último año.
    4. LimpiarAuditoriaCada6Meses: Borra los registros antiguos de auditoría cada seis meses.
    5. ActualizarCategoriasPopulares: Actualiza la lista de categorías más alquiladas al final de cada mes.