-- Course: 31012 Data Engineering Platforms for Analytics
-- Final Project
-- Group: Ana Sy-Quia, Emily Zhang, Eugene Kim, Mohammad Khan
-- Model: NBA    Version: Final
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nba
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nba` DEFAULT CHARACTER SET utf8 ;
USE `nba` ;

-- -----------------------------------------------------
-- Table `nba`.`player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba`.`player` ;

CREATE TABLE IF NOT EXISTS `nba`.`player` (
  `player_id` INT NOT NULL AUTO_INCREMENT,
  `player_name` VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY (`player_id`)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba`.`season`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba`.`season` ;

CREATE TABLE IF NOT EXISTS `nba`.`season` (
  `season_id`  INT NOT NULL AUTO_INCREMENT,
  `start_year` FLOAT NOT NULL UNIQUE,
  `end_year` FLOAT NOT NULL,
  PRIMARY KEY (`season_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `nba`.`player_age`
-- -----------------------------------------------------
DROP TABLE IF EXISTS nba.player_age ;

CREATE TABLE nba.player_age (
    player_age_id INT NOT NULL AUTO_INCREMENT,
    player_id INT NOT NULL,
    season_id INT NOT NULL,
    age FLOAT NOT NULL,
    PRIMARY KEY (player_age_id),
    FOREIGN KEY (player_id) REFERENCES nba.player(player_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (season_id) REFERENCES nba.season(season_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba`.`team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba`.`team` ;

CREATE TABLE IF NOT EXISTS `nba`.`team` (
  `team_id`  INT NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY (`team_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba`.`position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba`.`position` ;

CREATE TABLE IF NOT EXISTS `nba`.`position` (
  `position_id`  INT NOT NULL AUTO_INCREMENT,
  `position_description` VARCHAR(45) NULL,
  PRIMARY KEY (`position_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba`.`stat_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba`.`stat_category` ;

CREATE TABLE IF NOT EXISTS `nba`.`stat_category` (
  `stat_category_id`  INT NOT NULL AUTO_INCREMENT COMMENT 'Per game, per minute, per 100 possessions, or total',
  `category_name` VARCHAR(45) NULL UNIQUE,
  PRIMARY KEY (`stat_category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba`.`shooting_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba`.`shooting_stats` ;

CREATE TABLE IF NOT EXISTS `nba`.`shooting_stats` (
  `shooting_stats_id` INT NOT NULL AUTO_INCREMENT,
  `season_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `position_id` INT NOT NULL,
  `dist` FLOAT NULL,
  `fga_2p_pct` FLOAT NULL,
  `fga_0-3_pct` FLOAT,
  `fga_3-10_pct` FLOAT NULL,
  `fga_10-16_pct` FLOAT NULL,
  `fga_16-3p_pct` FLOAT NULL,
  `fga_3p_pct` FLOAT NULL,
  `fg_2p_pct` FLOAT NULL,
  `fg_0-3_pct` FLOAT NULL,
  `fg_3-10_pct` FLOAT NULL,
  `fg_10-16_pct` FLOAT NULL,
  `fg_16-3p_pct` FLOAT NULL,
  `fg_3p_pct` FLOAT NULL,
  `fg_ast_2p_pct` FLOAT NULL,
  `fg_ast_3p_pct` FLOAT NULL,
  `fga_dk_pct` FLOAT NULL,
  `num_dk` FLOAT NULL,
  `3pa_corner_pct` FLOAT NULL,
  `3p_corner_pct` FLOAT NULL,
  PRIMARY KEY (`shooting_stats_id`),
  INDEX `fk_shooting_stats_season1_idx` (`season_id` ASC) VISIBLE,
  INDEX `fk_shooting_stats_player1_idx` (`player_id` ASC) VISIBLE,
  INDEX `fk_shooting_stats_team1_idx` (`team_id` ASC) VISIBLE,
  INDEX `fk_shooting_stats_position1_idx` (`position_id` ASC) VISIBLE,
  CONSTRAINT `fk_shooting_stats_season1`
    FOREIGN KEY (`season_id`)
    REFERENCES `nba`.`season` (`season_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shooting_stats_player1`
    FOREIGN KEY (`player_id`)
    REFERENCES `nba`.`player` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shooting_stats_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba`.`team` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shooting_stats_position1`
    FOREIGN KEY (`position_id`)
    REFERENCES `nba`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba`.`advanced_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba`.`advanced_stats` ;

CREATE TABLE IF NOT EXISTS `nba`.`advanced_stats` (
  `advanced_stats_id` INT NOT NULL AUTO_INCREMENT,
  `player_id` INT NOT NULL,
  `season_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `position_id` INT NOT NULL,
  `per` FLOAT NULL,
  `ts_pct` FLOAT NULL,
  `3pa_r` FLOAT NULL,
  `ft_r` FLOAT NULL,
  `orb_pct` FLOAT NULL,
  `drb_pct` FLOAT NULL,
  `trb_pct` FLOAT NULL,
  `ast_pct` FLOAT NULL,
  `stl_pct` FLOAT NULL,
  `blk_pct` FLOAT NULL,
  `tov_pct` FLOAT NULL,
  `usg_pct` FLOAT NULL,
  `ows` FLOAT NULL,
  `dws` FLOAT NULL,
  `ws` FLOAT NULL,
  `ws_48` FLOAT NULL,
  `ob_pm` FLOAT NULL,
  `db_pm` FLOAT NULL,
  `box_pm` FLOAT NULL,
  `vorp` FLOAT NULL,
  PRIMARY KEY (`advanced_stats_id`),
  INDEX `fk_advanced_stats_player_idx` (`player_id` ASC) VISIBLE,
  INDEX `fk_advanced_stats_season1_idx` (`season_id` ASC) VISIBLE,
  INDEX `fk_advanced_stats_team1_idx` (`team_id` ASC) VISIBLE,
  INDEX `fk_advanced_stats_position1_idx` (`position_id` ASC) VISIBLE,
  CONSTRAINT `fk_advanced_stats_player`
    FOREIGN KEY (`player_id`)
    REFERENCES `nba`.`player` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_advanced_stats_season1`
    FOREIGN KEY (`season_id`)
    REFERENCES `nba`.`season` (`season_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_advanced_stats_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba`.`team` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_advanced_stats_position1`
    FOREIGN KEY (`position_id`)
    REFERENCES `nba`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba`.`play_by_play_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba`.`play_by_play_stats` ;

CREATE TABLE IF NOT EXISTS `nba`.`play_by_play_stats` (
  `play_by_play_stats_id` INT NOT NULL AUTO_INCREMENT,
  `season_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `position_id` INT NOT NULL,
  `pg_pct` FLOAT NULL,
  `sg_pct` FLOAT NULL,
  `sf_pct` FLOAT NULL,
  `pf_pct` FLOAT NULL,
  `c_pct` FLOAT NULL,
  `oncourt` FLOAT NULL,
  `onoff` FLOAT NULL,
  `badpass` FLOAT NULL,
  `lostball` FLOAT NULL,
  `sfc` FLOAT NULL,
  `ofc` FLOAT NULL,
  `sfd` FLOAT NULL,
  `ofd` FLOAT NULL,
  `pga` FLOAT NULL,
  `and1` FLOAT NULL,
  `blkd` FLOAT NULL,
  PRIMARY KEY (`play_by_play_stats_id`),
  INDEX `fk_play_by_play_stats_season1_idx` (`season_id` ASC) VISIBLE,
  INDEX `fk_play_by_play_stats_player1_idx` (`player_id` ASC) VISIBLE,
  INDEX `fk_play_by_play_stats_team1_idx` (`team_id` ASC) VISIBLE,
  INDEX `fk_play_by_play_stats_position1_idx` (`position_id` ASC) VISIBLE,
  CONSTRAINT `fk_play_by_play_stats_season1`
    FOREIGN KEY (`season_id`)
    REFERENCES `nba`.`season` (`season_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_play_by_play_stats_player1`
    FOREIGN KEY (`player_id`)
    REFERENCES `nba`.`player` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_play_by_play_stats_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba`.`team` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_play_by_play_stats_position1`
    FOREIGN KEY (`position_id`)
    REFERENCES `nba`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nba`.`general_stats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nba`.`general_stats` ;

CREATE TABLE IF NOT EXISTS `nba`.`general_stats` (
  `general_stats_id` INT NOT NULL AUTO_INCREMENT,
  `player_id` INT NOT NULL,
  `season_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `position_id` INT NOT NULL,
  `stat_category_id` INT NOT NULL,
  `g` FLOAT NULL,
  `gs` FLOAT NULL,
  `mp` FLOAT NULL,
  `fg` FLOAT NULL,
  `fga` FLOAT NULL,
  `fg_pct` FLOAT NULL,
  `3p` FLOAT NULL,
  `3pa` FLOAT NULL,
  `3p_pct` FLOAT NULL,
  `2p` FLOAT NULL,
  `2pa` FLOAT NULL,
  `2p_pct` FLOAT NULL,
  `efg_pct` FLOAT NULL,
  `ft` FLOAT NULL,
  `fta` FLOAT NULL,
  `ft_pct` FLOAT NULL,
  `orb` FLOAT NULL,
  `drb` FLOAT NULL,
  `trb` FLOAT NULL,
  `ast` FLOAT NULL,
  `stl` FLOAT NULL,
  `blk` FLOAT NULL,
  `tov` FLOAT NULL,
  `pf` FLOAT NULL,
  `pts` FLOAT NULL,
  `awards` VARCHAR(45) NULL,
  `o_rtg` FLOAT NULL,
  `d_rtg` FLOAT NULL,
  PRIMARY KEY (`general_stats_id`),
  INDEX `fk_totals_stats_player1_idx` (`player_id` ASC) VISIBLE,
  INDEX `fk_totals_stats_season1_idx` (`season_id` ASC) VISIBLE,
  INDEX `fk_totals_stats_team1_idx` (`team_id` ASC) VISIBLE,
  INDEX `fk_totals_stats_position1_idx` (`position_id` ASC) VISIBLE,
  INDEX `fk_totals_stats_stat_category1_idx` (`stat_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_totals_stats_player1`
    FOREIGN KEY (`player_id`)
    REFERENCES `nba`.`player` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_totals_stats_season1`
    FOREIGN KEY (`season_id`)
    REFERENCES `nba`.`season` (`season_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_totals_stats_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `nba`.`team` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_totals_stats_position1`
    FOREIGN KEY (`position_id`)
    REFERENCES `nba`.`position` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_totals_stats_stat_category1`
    FOREIGN KEY (`stat_category_id`)
    REFERENCES `nba`.`stat_category` (`stat_category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

