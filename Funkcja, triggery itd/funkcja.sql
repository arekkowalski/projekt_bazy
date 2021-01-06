DELIMITER $$
USE `arekkowalski`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `funkcja_zlecenia`(liczba int) RETURNS int
BEGIN
    DECLARE suma int;
    SELECT count(*) INTO suma from  zamowienie   where month(data_zamowienia) = liczba;
	RETURN suma ;
END$$

DELIMITER ;