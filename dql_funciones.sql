

-- 1.TotalIngresosCliente(ClienteID, Año): Calcula los ingresos generados por un cliente en un año específico.

DELIMITER $$

CREATE FUNCTION TotalIngresosCliente(p_cliente_id INT, p_anio INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT IFNULL(SUM(total), 0)
    INTO total
    FROM pago
    WHERE id_cliente = p_cliente_id
      AND YEAR(fecha_pago) = p_anio;

    RETURN total;
END $$

DELIMITER ;

-- 2.PromedioDuracionAlquiler(PeliculaID): Retorna la duración promedio de alquiler de una película específica.

DELIMITER $$

CREATE FUNCTION PromedioDuracionAlquiler(p_pelicula_id INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE promedio DECIMAL(5,2);

    SELECT AVG(DATEDIFF(fecha_devolucion, a.ultima_actualizacion))
    INTO promedio
    FROM alquiler a
    JOIN inventario i ON a.id_inventario = i.id_inventario
    WHERE i.id_pelicula = p_pelicula_id
      AND a.fecha_devolucion IS NOT NULL;

    RETURN IFNULL(promedio, 0);
END $$

DELIMITER ;

-- 3.IngresosPorCategoria(CategoriaID): Calcula los ingresos totales generados por una categoría específica de películas.

DELIMITER $$

CREATE FUNCTION IngresosPorCategoria(p_categoria_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT IFNULL(SUM(p.total), 0)
    INTO total
    FROM pago p
    JOIN alquiler a ON p.id_alquiler = a.id_alquiler
    JOIN inventario i ON a.id_inventario = i.id_inventario
    JOIN pelicula_categoria pc ON i.id_pelicula = pc.id_pelicula
    WHERE pc.id_categoria = p_categoria_id;

    RETURN total;
END $$

DELIMITER ;

-- 4.DescuentoFrecuenciaCliente(ClienteID): Calcula un descuento basado en la frecuencia de alquiler del cliente.

DELIMITER $$

CREATE FUNCTION DescuentoFrecuenciaCliente(p_cliente_id INT)
RETURNS DECIMAL(4,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cantidad INT;
    DECLARE descuento DECIMAL(4,2);

    SELECT COUNT(*)
    INTO cantidad
    FROM alquiler
    WHERE id_cliente = p_cliente_id;

    IF cantidad > 20 THEN
        SET descuento = 0.10;
    ELSEIF cantidad > 10 THEN
        SET descuento = 0.05;
    ELSE
        SET descuento = 0.00;
    END IF;

    RETURN descuento;
END $$

DELIMITER ;

-- 5.EsClienteVIP(ClienteID): Verifica si un cliente es "VIP" basándose en la cantidad de alquileres realizados y los ingresos generados.

DELIMITER $$

CREATE FUNCTION EsClienteVIP(p_cliente_id INT)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cantidad_alquileres INT;
    DECLARE total_pagos DECIMAL(10,2);

    SELECT COUNT(*)
    INTO cantidad_alquileres
    FROM alquiler
    WHERE id_cliente = p_cliente_id;

    SELECT IFNULL(SUM(total), 0)
    INTO total_pagos
    FROM pago
    WHERE id_cliente = p_cliente_id;

    RETURN (cantidad_alquileres > 30 AND total_pagos > 300);
END $$

DELIMITER ;