DELIMITER $$
USE `arekkowalski`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `arekkowalski`.`rabat_before_insert`
BEFORE INSERT ON `arekkowalski`.`pozycja_zamowienia`
FOR EACH ROW
BEGIN

  IF NEW.ilosc > 999
  THEN
    SET NEW.cena_netto = new.cena_netto*0.9;
  END IF;
END$$