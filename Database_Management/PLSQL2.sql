SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION second_function (car_year NUMBER)
    RETURN NUMBER
IS
X NUMBER;
BEGIN
    IF car_year = NULL THEN
        return 0;
    ELSE 
        SELECT MAX(QTY) INTO X
        FROM (SELECT COUNT(rent_id) AS QTY
            FROM rental_details 
            INNER JOIN cars ON cars.car_id = rental_details.car_id
            WHERE cars.year_prod = car_year
            GROUP BY cars.year_prod
            );
            RETURN X;
    END IF;
END;

SELECT second_function(1985) from dual;