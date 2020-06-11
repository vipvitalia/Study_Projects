SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION first_function (year_param NUMBER, name_param VARCHAR2)
    RETURN NUMBER
IS 
    c NUMBER;
BEGIN 
    IF year_param = 1950  THEN
        DBMS_OUTPUT.PUT_LINE('No such cars');
        RETURN 0;
    ELSE 
        SELECT count(cars.car_id) INTO c
        FROM cars
        INNER JOIN car_manufacturer ON car_manufacturer.man_id = cars.manufacturer
        INNER JOIN rental_details ON rental_details.car_id = cars.manufacturer
        WHERE cars.year_prod > year_param and car_manufacturer.man_name = name_param;
        RETURN c;
    END IF;
END;
         






SELECT first_function(1987, 'FORD') from dual;
