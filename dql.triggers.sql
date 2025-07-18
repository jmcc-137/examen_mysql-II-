

CREATE TABLE IF NOT EXISTS total_alquileres_empleado (
    id_empleado INT PRIMARY KEY,
    total_alquileres INT DEFAULT 0
);

Trigger:

DELIMITER $$

CREATE TRIGGER tr_actualizar_total_alquileres_empleado
AFTER INSERT ON alquiler
FOR EACH ROW
BEGIN
    INSERT INTO total_alquileres_empleado(id_empleado, total_alquileres)
    VALUES (NEW.id_empleado, 1)
    ON DUPLICATE KEY UPDATE total_alquileres = total_alquileres + 1;
END $$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER tr_auditar_actualizacion_cliente
BEFORE UPDATE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_cliente (id_cliente, nombre_anterior, apellidos_anterior, email_anterior)
    VALUES (OLD.id_cliente, OLD.nombre, OLD.apellidos, OLD.email);
END $$

DELIMITER ;


CREATE TABLE IF NOT EXISTS historial_costo_pelicula (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_pelicula INT,
    costo_anterior DECIMAL(5,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Trigger:

DELIMITER $$

CREATE TRIGGER tr_registrar_historial_costo
BEFORE UPDATE ON pelicula
FOR EACH ROW
BEGIN
    IF OLD.repaplacement_cost <> NEW.repaplacement_cost THEN
        INSERT INTO historial_costo_pelicula (id_pelicula, costo_anterior)
        VALUES (OLD.id_pelicula, OLD.repaplacement_cost);
    END IF;
END $$

DELIMITER ;



CREATE TABLE IF NOT EXISTS notificaciones_alquiler (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_alquiler INT,
    mensaje TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Trigger:

DELIMITER $$

CREATE TRIGGER tr_notificar_eliminacion_alquiler
BEFORE DELETE ON alquiler
FOR EACH ROW
BEGIN
    INSERT INTO notificaciones_alquiler (id_alquiler, mensaje)
    VALUES (OLD.id_alquiler, CONCAT('Se eliminó el alquiler con ID ', OLD.id_alquiler));
END $$

DELIMITER ;


CREATE TRIGGER tr_restringir_alquiler_saldo_pendiente
BEFORE INSERT ON alquiler
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM alquiler a
        LEFT JOIN pago p ON a.id_alquiler = p.id_alquiler
        WHERE a.id_cliente = NEW.id_cliente
        AND p.id_pago IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente tiene saldo pendiente y no puede alquilar nuevas películas.';
    END IF;
END $$

DELIMITER ;


