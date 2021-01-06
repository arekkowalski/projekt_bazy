DELIMITER $$
USE `arekkowalski`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `arekkowalski`.`stan_magazynowy_before_insert`
BEFORE INSERT ON `arekkowalski`.`stan_magazynowy`
FOR EACH ROW
BEGIN
	if NEW.ilosc< 0
    then
		set NEW.ilosc  = 0;
	end if;
END$$
DELIMITER ;
