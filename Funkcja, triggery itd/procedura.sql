DELIMITER $$
USE `arekkowalski`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `miesiac_suma_zamowien`(IN liczba int, OUT suma int)
BEGIN
SELECT  count(*) INTO suma from  zamowienie   where month(data_zamowienia) = liczba;
END$$

DELIMITER ;