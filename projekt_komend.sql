-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema arekkowalski
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema arekkowalski
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `arekkowalski` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `arekkowalski` ;

-- -----------------------------------------------------
-- Table `arekkowalski`.`klient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arekkowalski`.`klient` (
  `id_klient` INT NOT NULL,
  `nip` VARCHAR(15) NULL DEFAULT NULL,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `nr_telefonu` CHAR(9) NOT NULL,
  `rodzaj` ENUM('firma', 'kient_indywidualny') NOT NULL,
  PRIMARY KEY (`id_klient`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `arekkowalski`.`adres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arekkowalski`.`adres` (
  `id_adres` INT NOT NULL,
  `miejscowosc` VARCHAR(50) NOT NULL,
  `kod_pocztowy` VARCHAR(7) NOT NULL,
  `nr_domu` VARCHAR(5) NOT NULL,
  `rodzaj` ENUM('firmowy', 'prywatny') NOT NULL,
  `klient` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_adres`),
  INDEX `fk_adres_klient1_idx` (`klient` ASC) VISIBLE,
  CONSTRAINT `fk_adres_klient1`
    FOREIGN KEY (`klient`)
    REFERENCES `arekkowalski`.`klient` (`id_klient`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `arekkowalski`.`towar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arekkowalski`.`towar` (
  `id_towar` INT NOT NULL,
  `woda` ENUM('gazowana', 'niegazowana') NULL,
  `pieczywo` ENUM('chleb', 'bułka') NULL,
  `chleb` ENUM('pszenny', 'razowy') NULL,
  `bułka` ENUM('pszenna', 'razowa') NULL,
  `słodycze` ENUM('batonik', 'czekolada') NULL,
  `batonik` ENUM('czekoladowy', 'karmelowy') NULL,
  `czekolada` ENUM('mleczna', 'gorzka') NULL,
  PRIMARY KEY (`id_towar`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `arekkowalski`.`zamowienie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arekkowalski`.`zamowienie` (
  `id_zamowienie` INT NOT NULL,
  `data_zamowienia` DATE NOT NULL,
  `nr_zamowienia` INT UNSIGNED NOT NULL,
  `status_zamowienia` ENUM('zakonczone', 'wyslane', 'gotowe_do_odbioru', 'anulowane', 'przyjete_do_realizacji') NOT NULL,
  `klient` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_zamowienie`),
  INDEX `fk_zamowienie_klient1_idx` (`klient` ASC) VISIBLE,
  CONSTRAINT `fk_zamowienie_klient1`
    FOREIGN KEY (`klient`)
    REFERENCES `arekkowalski`.`klient` (`id_klient`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `arekkowalski`.`pozycja_zamowienia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arekkowalski`.`pozycja_zamowienia` (
  `id_pozycja_zamowienia` INT NOT NULL,
  `cena_netto` DOUBLE UNSIGNED NOT NULL,
  `ilosc` INT UNSIGNED NOT NULL,
  `zamowienie` INT NULL DEFAULT NULL,
  `towar` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_pozycja_zamowienia`),
  INDEX `fk_pozycja_zamowienia_zamowienie1_idx` (`zamowienie` ASC) VISIBLE,
  INDEX `fk_pozycja_zamowienia_towar1_idx` (`towar` ASC) VISIBLE,
  CONSTRAINT `fk_pozycja_zamowienia_towar1`
    FOREIGN KEY (`towar`)
    REFERENCES `arekkowalski`.`towar` (`id_towar`),
  CONSTRAINT `fk_pozycja_zamowienia_zamowienie1`
    FOREIGN KEY (`zamowienie`)
    REFERENCES `arekkowalski`.`zamowienie` (`id_zamowienie`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `arekkowalski`.`pracownik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arekkowalski`.`pracownik` (
  `imie` VARCHAR(15) NOT NULL,
  `id_pracownik` INT NOT NULL,
  `nazwisko` VARCHAR(15) NOT NULL,
  `pensja` DOUBLE UNSIGNED NOT NULL,
  `premia` DOUBLE NULL DEFAULT NULL,
  `data_zatrudniena` DATE NOT NULL,
  `nr_telefonu` CHAR(9) NOT NULL,
  `dzial` ENUM('marketing', 'produkcja', 'magazyn') NULL DEFAULT NULL,
  PRIMARY KEY (`id_pracownik`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `arekkowalski`.`pracownicy_przy_zamowieniu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arekkowalski`.`pracownicy_przy_zamowieniu` (
  `id_zamowienie` INT NOT NULL,
  `id_pracownik` INT NOT NULL,
  PRIMARY KEY (`id_zamowienie`, `id_pracownik`),
  INDEX `fk_zamowienie_has_pracownik_pracownik1_idx` (`id_pracownik` ASC) VISIBLE,
  INDEX `fk_zamowienie_has_pracownik_zamowienie1_idx` (`id_zamowienie` ASC) VISIBLE,
  CONSTRAINT `fk_zamowienie_has_pracownik_pracownik1`
    FOREIGN KEY (`id_pracownik`)
    REFERENCES `arekkowalski`.`pracownik` (`id_pracownik`),
  CONSTRAINT `fk_zamowienie_has_pracownik_zamowienie1`
    FOREIGN KEY (`id_zamowienie`)
    REFERENCES `arekkowalski`.`zamowienie` (`id_zamowienie`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `arekkowalski`.`stan_magazynowy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arekkowalski`.`stan_magazynowy` (
  `id_stan_magazynowy` INT NOT NULL,
  `ilosc` INT UNSIGNED NOT NULL,
  `jednostka_miary` VARCHAR(20) NOT NULL,
  `towar` INT NOT NULL,
  PRIMARY KEY (`id_stan_magazynowy`, `towar`),
  INDEX `fk_stan_magazynowy_towar1_idx` (`towar` ASC) VISIBLE,
  CONSTRAINT `fk_stan_magazynowy_towar1`
    FOREIGN KEY (`towar`)
    REFERENCES `arekkowalski`.`towar` (`id_towar`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `arekkowalski` ;

-- -----------------------------------------------------
-- procedure miesiac_suma_zamowien
-- -----------------------------------------------------

DELIMITER $$
USE `arekkowalski`$$
CREATE DEFINER=`arekkowalski`@`localhost` PROCEDURE `miesiac_suma_zamowien`(IN liczba int, OUT suma int)
BEGIN
SELECT  count(*) INTO suma from  zamowienie   where month(data_zamowienia) = liczba;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function najwieksze
-- -----------------------------------------------------

DELIMITER $$
USE `arekkowalski`$$
CREATE DEFINER=`arekkowalski`@`localhost` FUNCTION `najwieksze`(towar int) RETURNS int
BEGIN
    DECLARE najwieksze int(10);
    SELECT max(ilosc) INTO @najwieksze;
    RETURN @najwieksze;
END$$

DELIMITER ;
USE `arekkowalski`;

DELIMITER $$
USE `arekkowalski`$$
CREATE
DEFINER=`arekkowalski`@`localhost`
TRIGGER `arekkowalski`.`rabat_before_insert`
BEFORE INSERT ON `arekkowalski`.`pozycja_zamowienia`
FOR EACH ROW
BEGIN

  IF NEW.ilosc > 999
  THEN
    SET NEW.cena_netto = new.cena_netto*0.9;
  END IF;
END$$

USE `arekkowalski`$$
CREATE
DEFINER=`arekkowalski`@`localhost`
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

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
