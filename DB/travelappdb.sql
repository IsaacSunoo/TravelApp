-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema travelappdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `travelappdb` ;

-- -----------------------------------------------------
-- Schema travelappdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `travelappdb` DEFAULT CHARACTER SET utf8 ;
USE `travelappdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) NOT NULL,
  `password` VARCHAR(500) NOT NULL,
  `email` VARCHAR(500) NOT NULL,
  `active` TINYINT NOT NULL,
  `role` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `followers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `followers` ;

CREATE TABLE IF NOT EXISTS `followers` (
  `follower_id` INT NOT NULL,
  `followed_id` INT NOT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_follower_user_idx` (`follower_id` ASC),
  INDEX `fk_followed_user_idx` (`followed_id` ASC),
  CONSTRAINT `fk_follower_user`
    FOREIGN KEY (`follower_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_followed_user`
    FOREIGN KEY (`followed_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profile_loc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profile_loc` ;

CREATE TABLE IF NOT EXISTS `profile_loc` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(500) NOT NULL,
  `state` VARCHAR(500) NOT NULL,
  `country` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profile` ;

CREATE TABLE IF NOT EXISTS `profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `first_name` VARCHAR(500) NOT NULL,
  `last_name` VARCHAR(500) NOT NULL,
  `img_link` VARCHAR(500) NULL,
  `location_id` INT NOT NULL,
  `bio` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_location_profile_loc_idx` (`location_id` ASC),
  INDEX `fk_user_id_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_location_profile_loc`
    FOREIGN KEY (`location_id`)
    REFERENCES `profile_loc` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_id_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `destination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `destination` ;

CREATE TABLE IF NOT EXISTS `destination` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(500) NOT NULL,
  `state` VARCHAR(500) NULL,
  `country` VARCHAR(500) NOT NULL,
  `longitude` VARCHAR(500) NULL,
  `latitude` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trip` ;

CREATE TABLE IF NOT EXISTS `trip` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(500) NOT NULL,
  `rating` INT NOT NULL,
  `total_cost` DOUBLE NOT NULL,
  `date_start` DATETIME NOT NULL,
  `date_end` DATETIME NOT NULL,
  `destination_id` INT NOT NULL,
  `review` TEXT NOT NULL,
  `img_link` VARCHAR(500) NULL,
  `profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_destination_id_destination_idx` (`destination_id` ASC),
  INDEX `fk_profile_id_profile_idx` (`profile_id` ASC),
  CONSTRAINT `fk_destination_id_destination`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_profile_id_profile`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `posts` ;

CREATE TABLE IF NOT EXISTS `posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message` TEXT NOT NULL,
  `trip_id` INT NOT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `prof_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_prof_id_profile_idx` (`prof_id` ASC),
  INDEX `fk_trip_id_trip_idx` (`trip_id` ASC),
  CONSTRAINT `fk_prof_id_profile`
    FOREIGN KEY (`prof_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_trip_id_trip`
    FOREIGN KEY (`trip_id`)
    REFERENCES `trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `post_id` INT NOT NULL,
  `prof_id` INT NOT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_post_id_posts_idx` (`post_id` ASC),
  CONSTRAINT `fk_post_id_posts`
    FOREIGN KEY (`post_id`)
    REFERENCES `posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorites` ;

CREATE TABLE IF NOT EXISTS `favorites` (
  `trip_id` INT NOT NULL,
  `profile_id` INT NOT NULL,
  INDEX `fk_trip_id_trip_idx` (`trip_id` ASC),
  INDEX `fk_profile_id_profile_idx` (`profile_id` ASC),
  CONSTRAINT `fk_trip_id_trip`
    FOREIGN KEY (`trip_id`)
    REFERENCES `trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorites_profile_id_profile`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rec_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rec_type` ;

CREATE TABLE IF NOT EXISTS `rec_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recommendation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recommendation` ;

CREATE TABLE IF NOT EXISTS `recommendation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `trip_id` INT NOT NULL,
  `rec_type_id` INT NOT NULL,
  `content` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trip_id_trip_idx` (`trip_id` ASC),
  INDEX `fk_rec_type_id_rec_type_idx` (`rec_type_id` ASC),
  CONSTRAINT `fk_fk_recommedation_trip_id_trip`
    FOREIGN KEY (`trip_id`)
    REFERENCES `trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rec_type_id_rec_type`
    FOREIGN KEY (`rec_type_id`)
    REFERENCES `rec_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tag` ;

CREATE TABLE IF NOT EXISTS `tag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trip_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trip_tag` ;

CREATE TABLE IF NOT EXISTS `trip_tag` (
  `trip_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  INDEX `fk_trip_id_trip_idx` (`trip_id` ASC),
  INDEX `fk_tag_id_tag_idx` (`tag_id` ASC),
  CONSTRAINT `fk_tag_trip_id_trip`
    FOREIGN KEY (`trip_id`)
    REFERENCES `trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tag_id_tag`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS travelappuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'travelappuser'@'localhost' IDENTIFIED BY 'travelappuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'travelappuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (1, 'JamesG', 'password', 'JG@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (2, 'SteveSt', 'password', 'SS@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (3, 'JorgeS', 'password', 'JS@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (4, 'GeorgeD', 'password', 'GD@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (5, 'BrockL', 'password', 'BL@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (6, 'AndyC', 'password', 'AC@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (7, 'TateC', 'password', 'TC@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (8, 'ArnoldF', 'password', 'AF@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (9, 'JeffC', 'password', 'JC@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (10, 'GillW', 'password', 'GW@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (11, 'TrentJ', 'password', 'TJ@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (12, 'BobR', 'password', 'BR@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (13, 'SteveT', 'password', 'ST@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (14, 'LizaM', 'password', 'LM@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (15, 'JennyK', 'password', 'JK@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (16, 'MiaL', 'password', 'ML@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (17, 'RaulK', 'password', 'RK@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (18, 'RichardH', 'password', 'RH@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (19, 'JerryF', 'password', 'JF@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (20, 'DerekR', 'password', 'DR@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (21, 'FrankV', 'password', 'FV@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (22, 'HarryC', 'password', 'HC@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (23, 'MattV', 'password', 'MV@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (24, 'IsaacM', 'password', 'IM@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (25, 'PhilW', 'password', 'PW@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (26, 'RaulM', 'password', 'RM@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (27, 'PabstB', 'password', 'PB@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (28, 'DeniseF', 'password', 'DF@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (29, 'TimJ', 'password', 'TJ@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (30, 'JakeL', 'password', 'JL@wander.com', 1, 'standard');

COMMIT;


-- -----------------------------------------------------
-- Data for table `followers`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (1, 10, DEFAULT);
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (2, 9, DEFAULT);
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (3, 8, DEFAULT);
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (4, 7, DEFAULT);
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (5, 6, DEFAULT);
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (6, 5, DEFAULT);
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (7, 4, DEFAULT);
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (8, 3, DEFAULT);
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (9, 2, DEFAULT);
INSERT INTO `followers` (`follower_id`, `followed_id`, `create_date`) VALUES (10, 1, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `profile_loc`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (1, 'Denver', 'CO', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (2, 'Las Vegas', 'NV', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (3, 'Mobile', 'AL', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (4, 'Raleigh', 'NC', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (5, 'Fresno', 'CA', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (6, 'Austin', 'TX', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (7, 'Atlanta', 'GA', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (8, 'New Orleans', 'LA', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (9, 'Seattle', 'WA', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (10, 'NY', 'NY', 'USA');
INSERT INTO `profile_loc` (`id`, `city`, `state`, `country`) VALUES (11, 'Tampa', 'FL', 'USA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `profile`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (1, 1, 'James', 'Gill', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 1, 'I like turtles and hockey.  I love trying new foods and meeting new people.  I’ve never been to Argentina but I have been to Alaska and that was fun.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (2, 2, 'Steve', 'Striker', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 2, 'I’m in tech and super busy but when I find the time, I like a good adventure and shredding the gnar.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (3, 3, 'Jorge', 'Sims', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 3, 'I’m in school for now but planning an epic adventure in Switzerland when I’m done.  Looking forward to celebrating and taking some time to adventure.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (4, 4, 'George', 'Danger', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 4, 'My name is Danger which is fitting that I love to swim with sharks.  My dog’s name is Carbon and he follows me on all over the globe.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (5, 5, 'Brock', 'Lee', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 5, 'I have a strong name which matches my strong desire to travel, adventure, kick butt and take names.  I plan to visit every country ever invented.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (6, 6, 'Andy', 'Conling', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 6, 'I take pictures of my adventures to build up my social media platform.  Go follow my insta to see my travels.  I love meeting like-minded travelers.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (7, 7, 'Tate', 'Channer', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 7, 'I haven’t traveled much but I’m planning an epic journey for the near future.  I’m hoping this community will inspire me to reach that goal.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (8, 8, 'Arnold', 'Farms', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 8, 'I’m here to share my travels with you fine folks.  Let’s get together and adventure!');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (9, 9, 'Jeff', 'Collins', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 9, 'My life is a journey.  I’m here to find people to travel with and be inspired.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (10, 10, 'Gill', 'Walberg', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 10, 'I like tacos.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (11, 11, 'Trent', 'Jacobs', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 1, 'I like turtles and hockey.  I love trying new foods and meeting new people.  I’ve never been to Argentina but I have been to Alaska and that was fun.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (12, 12, 'Bob', 'Rossco', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 2, 'I’m in tech and super busy but when I find the time, I like a good adventure and shredding the gnar.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (13, 13, 'Steve', 'Thompson', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 3, 'I’m in school for now but planning an epic adventure in Switzerland when I’m done.  Looking forward to celebrating and taking some time to adventure.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (14, 14, 'Liza', 'Marsh', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 4, 'My name is Danger which is fitting that I love to swim with sharks.  My dog’s name is Carbon and he follows me on all over the globe.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (15, 15, 'Jenny', 'Kim', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 5, 'I have a strong name which matches my strong desire to travel, adventure, kick butt and take names.  I plan to visit every country ever invented.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (16, 16, 'Mia', 'Lamb', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 6, 'I take pictures of my adventures to build up my social media platform.  Go follow my insta to see my travels.  I love meeting like-minded travelers.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (17, 17, 'Raul', 'Kemper', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 7, 'I haven’t traveled much but I’m planning an epic journey for the near future.  I’m hoping this community will inspire me to reach that goal.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (18, 18, 'Richard', 'Hendrick', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 8, 'I’m here to share my travels with you fine folks.  Let’s get together and adventure!');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (19, 19, 'Jerry', 'Ford', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 9, 'My life is a journey.  I’m here to find people to travel with and be inspired.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (20, 20, 'Derek', 'Rey', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 10, 'I like tacos.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (21, 21, 'Frank', 'Vick', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 1, 'I like turtles and hockey.  I love trying new foods and meeting new people.  I’ve never been to Argentina but I have been to Alaska and that was fun.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (22, 22, 'Harry', 'Conner', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 2, 'I’m in tech and super busy but when I find the time, I like a good adventure and shredding the gnar.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (23, 23, 'Matt', 'Vin', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 3, 'I’m in school for now but planning an epic adventure in Switzerland when I’m done.  Looking forward to celebrating and taking some time to adventure.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (24, 24, 'Isaac', 'Munoo', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 4, 'My name is Danger which is fitting that I love to swim with sharks.  My dog’s name is Carbon and he follows me on all over the globe.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (25, 25, 'Phil', 'Warren', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 5, 'I have a strong name which matches my strong desire to travel, adventure, kick butt and take names.  I plan to visit every country ever invented.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (26, 26, 'Paul', 'Maul', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 6, 'I take pictures of my adventures to build up my social media platform.  Go follow my insta to see my travels.  I love meeting like-minded travelers.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (27, 27, 'Pabst', 'Blue', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 7, 'I haven’t traveled much but I’m planning an epic journey for the near future.  I’m hoping this community will inspire me to reach that goal.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (28, 28, 'Denise', 'Fellar', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 8, 'I’m here to share my travels with you fine folks.  Let’s get together and adventure!');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (29, 29, 'Tim', 'James', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 9, 'My life is a journey.  I’m here to find people to travel with and be inspired.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (30, 30, 'Jake', 'Lillith', 'https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/2645706/1360/906/m1/fpnw/wm0/fkgco7lsh5smjg12fovsvklcfqg2zwi4zomlfom0odl2tu3youe5bvbzfjbqqmjz-.jpg?1494680392&s=1eb3e799e2ee3e19df84e6edf9e77766', 11, 'I like tacos.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (1, 'Barcelona', '', 'Spain', '41.385063', '2.173404');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (2, 'Munich', '', 'Germany', '48.137154', '11.576124');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (3, 'Prague', '', 'Czech Republic', '50.075539', '14.437800');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (4, 'Beijing', '', 'China', '39.904202', '116.407394');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (5, 'Interlaken', '', 'Switzerland', '46.686348', '7.863205');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (6, 'Venice', '', 'Italy', '45.440845', '12.315515');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (7, 'Paris', '', 'France', '48.856613', '2.352222');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (8, 'Rome', '', 'Italy', '41.902782', '12.496365');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (9, 'Berlin', '', 'Germany', '52.520008', '13.404954');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (10, 'Krakow', '', 'Poland', '50.064651', '19.944981');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (11, 'Madrid', '', 'Spain', '40.416775', '-3.703790');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (12, 'Copenhagen', '', 'Denmark', '55.676098', '12.568337');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (13, 'Dresden', '', 'Germany', '51.050407', '13.737262');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (14, 'Vienna', '', 'Austria', '48.208176', '16.373819');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (15, 'London', '', 'United Kingdom', '51.507351', '-0.127758');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (16, 'Dubai', '', 'United Arab Emirates', '25.204849', '55.270782');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (17, 'Bangkok', '', 'Thailand', '13.756331', '100.501762');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (18, 'Ha Long Bay', '', 'Vietnam', '14.058324', '108.277199');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (19, 'Sentosa', '', 'Singapore', '1.249404', '103.830322');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (20, 'Tokyo', '', 'Japan', '35.689487', '139.691711');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (21, 'Istanbul', '', 'Turkey', '41.008240', '28.978359');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (22, 'Zagreb', '', 'Croatia', '45.815010', '15.981919');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (23, 'Budapest', '', 'Hungary', '47.498140', '19.040550');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (24, 'Lisbon', '', 'Portugal', '38.722252', '-9.139337');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (25, 'Amsterdam', '', 'Netherlands', '52.370216', '4.895168');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (26, 'Mallorca', '', 'Spain', '39.695263', '3.017571');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (27, 'Mexico City', '', 'Mexico', '19.432608', '-99.133209');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (28, 'San Jose', '', 'Costa Rica', '9.928069', '-84.090729');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (29, 'Mumbai', '', 'India', '19.075983', '72.877655');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (30, 'Auckland', '', 'New Zealand', '-36.853610', '174.764990');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (31, 'Sydney', '', 'Australia', '-33.868820', '151.209290');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (32, 'Belfast', '', 'Ireland', '54.597286', '-5.930120');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (33, 'Reykjavik', '', 'Iceland', '64.126518', '-21.817438');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (34, 'San Juan', '', 'Puerto Rico', '18.465540', '-66.105736');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (35, 'Lima', '', 'Peru', '-12.046373', '-77.042755');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (36, 'Cairo', '', 'Egypt', '30.044420', '31.235712');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (37, 'Athens', '', 'Greece', '37.983810', '23.727539');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (38, 'Mount Everest', '', 'Nepal', '27.988121', '86.924973');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (39, 'Antananarivo', '', 'Madagascar', '-18.766947', '46.869106');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (40, 'Quito', '', 'Ecuador', '-0.180653', '-78.467834');
INSERT INTO `destination` (`id`, `city`, `state`, `country`, `longitude`, `latitude`) VALUES (41, 'Havana', '', 'Cuba', '23.113592', '-82.366592');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trip`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (1, 'Fun Times in Barcelona', 5, 2000, '2018-01-05 00:00:00', '2018-01-12 00:00:00', 1, 'Stayed at Hostel Jordan in a 6 person dorm.  Used the metro to get around and walked quite a bit.  I highly recommend taking public transpo; it is affordable and easy to use.  Be careful walking La Rambla, we were warned about nefarious people looking for oblivious tourists.  Took the free bar crawl with the hostel and it was just ok due to the lack of drink specials.  Take the Red Bus tour for sure!', 'images/places/barcelona.jpg', 1);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (2, 'THE Oktoberfest', 5, 1750, '2018-09-20 00:00:00', '2018-09-30 00:00:00', 2, 'I drank 3 liters of beer and I don’t remember much so I’m sure that means it was a great time!  Highly recommend.', 'images/places/oktoberfest.jpg', 2);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (3, 'Beautiful Prague', 5, 1500, '2018-03-07 00:00:00', '2018-03-15 00:00:00', 3, 'My beloved Prague!  Stayed at Hostel Fish and mostly walked everywhere in the city.  There is plenty to see by foot; I’m positive you won’t cover it all.  I had few plans and just found things to do.  I must have walked the St. Charles Bridge a few times because it is so beautiful.  The beer is cheap and tasty, you can’t go wrong.  Don’t forget to visit the Astrological Clock while trying all of the street food.', 'images/places/prague.jpg', 3);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (4, 'My Great Wall Adventure', 4, 1250, '2018-01-01 00:00:00', '2018-01-10 00:00:00', 4, 'I am convinced that the best time to visit the Great Wall is in January.  There were NO CROWDS!  It was also freezing so bring a jacket and enjoy epic pictures that look like you have the whole wall to yourself.  Go to the night market and try everything.  I would also recommend taking the high-speed rail to Shanghai.', 'images/places/beijing.jpg', 4);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (5, 'Adventure in the Alps', 4, 2750, '2018-04-05 00:00:00', '2018-04-17 00:00:00', 5, 'Interlaken is like a dream.  I rented a bike for the city but used the rail between cities.  You’ll need a little extra cash handy for this trip.  Switzerland is a little more pricey than surrounding countries but so worth it.  If you can find the time, try the Alpine slide in Lucerne.', 'images/places/interlaken.jpg', 5);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (6, 'The Venice Life', 5, 2150, '2018-05-06 00:00:00', '2018-05-17 00:00:00', 6, 'Pizza and Piazza San Marco, it doesn’t get any better.  Until you hit Rome, lol.  Had lunch in the square and went to the see the church.  Skipped over the gondola ride but it sure looked fun from afar.  You can cover a lot of ground in a couple days if you plan it right.  Venice is romantic for sure.', 'images/places/venice.jpg', 6);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (7, 'Nothing Like Notre Dame', 3, 1950, '2018-05-01 00:00:00', '2018-05-08 00:00:00', 7, 'Catacombs, Notre Dame, The Eiffel Tower, The Louvre.  These are all wonderful reasons to visit France but the best reason is to have picnic on the grass by the Eiffel Tower and watch it light up.  You can drink wine with your baguette.  Dooooo it!', 'images/places/paris.jpg', 7);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (8, 'That One Time at the Vatican', 4, 1800, '2018-05-12 00:00:00', '2018-05-25 00:00:00', 8, 'I got lost in Rome and it was wonderful.  While lost, I had some gelato and saw the Colosseum.  I’m convinced that the best thing to do is get lost!  Walk up the Spanish Steps for a Killer view!', 'images/places/rome.jpg', 8);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (9, 'Berlin History Tour', 3, 2100, '2018-09-06 00:00:00', '2018-09-10 00:00:00', 9, 'I didn’t have a whole lot of time in Berlin so I made sure to maximize my time there.  I recommend taking a few tours because you can cover a lot of ground with a tour guide.  Maybe kind of touristy but I went to Hofbrauhaus and it turned out to be pretty fun with great food.  Lot’s of history here in Berlin.', 'images/places/berlin.jpg', 9);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (10, 'The Gem That is Krakow', 5, 1400, '2018-09-06 00:00:00', '2018-09-17 00:00:00', 10, 'Krakow is off the beaten path but soooooo worth it!  Visit the salt mines, the Bone Church in Sedlec, and The Oscar Schindler Museum.  You can eat pretty much anywhere here and not break the bank.', 'images/places/krakow.jpg', 10);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (11, 'Magic in Madrid', 5, 1500, '2018-01-06 00:00:00', '2018-01-20 00:00:00', 11, 'Wander in the wonder on the streets of Madrid.  Decided to walk the city for the most part.  Took the metro here and there but Madrid is very walkable.  Retiro Park was among the best places to visit, and it is just that…a beautiful park where you can pay less than 10euro to rent a small row boat and take in the surroundings: beautiful fountains, turquoise water, and other visitors enjoying the beauty with you.  Don’t forget to visit.', 'https://www.thetimes.co.uk/travel/s3/growthtravel-prod/uploads/2017/03/Madrid_GettyImages.jpg', 1);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (12, 'Copenhagen Adventure', 3, 1710, '2018-02-07 00:00:00', '2018-02-17 00:00:00', 12, 'I would skip the Little Mermaid statue and stop at the Gefion fountain before the Little Mermaid if you are pressed for time.  The Rosenborg Castle Gardens might be among the more overlooked but interesting places to stumble upon.  Really look at the statues, they are out there.', 'https://www.ciee.org/sites/default/files/content/program/main-image/hero-copenhagen-516769472.jpg', 2);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (13, 'Escape to Dresden', 3, 1575, '2018-03-02 00:00:00', '2018-03-10 00:00:00', 13, 'I rode a bike around Dresden and saw the famous Furstenzug Mural—wow what a sight!  Explored the Zwinger’s amazing Baroque style architecture.  Dresden is a nice stop in your journey and must see for any history buff.', 'https://sumfinity.com/wp-content/uploads/2018/03/Zwinger-Palace-Dresden-Germany-sunny.jpg', 3);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (14, 'Vienna in the Spring', 3, 2000, '2018-04-04 00:00:00', '2018-04-15 00:00:00', 14, 'Vienna is just beautiful.   Visit Hofburg Palace.  The Hofburg Palace is another huge palatial complex that pays tribute to the power and influence of the Habsburg dynasty and served as the main winter palace for the rulers of the Austro-Hungarian Empire for hundreds of years.', 'https://roadscholar-iv-prod.azureedge.net/publishedmedia/hi65kc8kks4okgwdjabo/22960-city-walks-vienna-austria-lghoz.jpg', 4);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (15, 'Holiday in London', 3, 2500, '2018-05-05 00:00:00', '2018-05-19 00:00:00', 15, 'Red Tour Bus is the way to go to see the most of city.  A short boat tour was included with ours which took us by Big Ben where we disembarked and got a beer at a quaint little pub.  It was chilly in October.', 'https://cdn.londonandpartners.com/visit/general-london/areas/river/76709-640x360-houses-of-parliament-and-london-eye-on-thames-from-above-640.jpg', 5);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (16, 'Dubai for the Win', 4, 2450, '2018-06-09 00:00:00', '2018-06-21 00:00:00', 16, 'Dubai is a city and emirate in the United Arab Emirates known for luxury shopping, ultramodern architecture and a lively nightlife scene. Burj Khalifa, an 830m-tall tower, dominates the skyscraper-filled skyline. At its foot lies Dubai Fountain, with jets and lights choreographed to music. On artificial islands just offshore is Atlantis, The Palm, a resort with water and marine-animal parks. ', 'https://dak95nwic4sny.cloudfront.net/73/dubai-39699597-1508946889-ImageGalleryLightboxLarge.jpg', 6);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (17, 'My Week in Thailand', 5, 1400, '2018-07-08 00:00:00', '2018-07-16 00:00:00', 17, 'Until you’ve eaten on a Bangkok street, noodles mingling with your sweat amid a cloud of exhaust fumes, you haven’t actually eaten Thai food. It can be an intense mix: the base flavours – spicy, sour, sweet and salty – aren’t exactly meat and potatoes. But for adventurous foodies who don\'t need white tablecloths, there’s probably no better dining destination in the world. And with immigration bringing every regional Thai and international cuisine to the capital, it\'s also a truly diverse experience. And perhaps best of all, Bangkok has got to be one of the best-value dining destinations in the world. - Lonely Planet', 'https://www.saga.co.uk/contentlibrary/saga/publishing/verticals/travel/destinations/asia/thailand-history-and-culture.jpg', 7);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (18, 'Hello Vietnam', 5, 1450, '2018-08-20 00:00:00', '2018-08-30 00:00:00', 18, 'If you have the bills, Vietnam has the thrills and chills. Some require a little physical effort, such as motorbiking switchback after switchback up the jaw-dropping Hai Van Pass in central Vietnam. Others require even more sweat: kitesurfing the tropical oceanic waters off Mui Ne or hiking the evergreen hills around Bac Ha or Sapa. And when you’re done with all that adrenaline stuff, there’s plenty of horizontal ‘me’ time to relish. Vietnam has outstanding spas – from marble temples of treatments to simple family-run massage salons with backpacker-friendly rates. - Lonely Planet', 'https://cdn2.wanderlust.co.uk/media/2367/lists-top-10-things-to-do-in-vietnam.jpg?anchor=center&mode=crop&width=1440&height=540&rnd=131481546600000000', 8);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (19, 'Wander in Singapore', 4, 1900, '2018-09-01 00:00:00', '2018-09-11 00:00:00', 19, 'If you have the bills, Vietnam has the thrills and chills. Some require a little physical effort, such as motorbiking switchback after switchback up the jaw-dropping Hai Van Pass in central Vietnam. Others require even more sweat: kitesurfing the tropical oceanic waters off Mui Ne or hiking the evergreen hills around Bac Ha or Sapa. And when you’re done with all that adrenaline stuff, there’s plenty of horizontal ‘me’ time to relish. Vietnam has outstanding spas – from marble temples of treatments to simple family-run massage salons with backpacker-friendly rates.', 'https://s3-ap-southeast-1.amazonaws.com/images.humanresourcesonline.net/wp-content/uploads/2018/05/Jerene-May-2018-Singapore-skyline-iStock.jpg', 9);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (20, 'Explore Tokyo', 3, 1950, '2018-02-06 00:00:00', '2018-02-13 00:00:00', 20, 'Tokyo’s transportation system can be tricky but once you’ve figured it out, ride on over to the famous Harajuku.  Visit Shibuya and Shinjuku at night for all of the excitement and nightlife.  Marvel at the Sensoji Temple.      ', 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/04/10/13/tokyo-main.jpg?w968h681', 10);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (21, 'Turkey on a Budget', 4, 1700, '2018-01-05 00:00:00', '2018-01-12 00:00:00', 21, 'Turkey is a nation straddling eastern Europe and western Asia with cultural connections to ancient Greek, Persian, Roman, Byzantine and Ottoman empires. Cosmopolitan Istanbul, on the Bosphorus Strait, is home to the iconic Hagia Sophia, with its soaring dome and Christian mosaics, the massive 17th-century Blue Mosque and the circa-1460 Topkapı Palace, former home of sultans. Ankara is Turkey’s modern capital.', 'https://cdn.winsightmedia.com/platform/files/public/2018-07/background/Turkey-Country-Report_1532720642.jpg', 1);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (22, 'Croatia by the Sea', 5, 2100, '2018-09-20 00:00:00', '2018-09-30 00:00:00', 22, 'Croatia is an Eastern European country with a long coastline on the Adriatic Sea. Encompassing more than a thousand islands, it\'s also crossed by the Dinaric Alps. Its inland capital, Zagreb, is distinguished by its medieval Gornji Grad (Upper Town) and diverse museums. The major coastal city Dubrovnik has massive 16th-century walls encircling an Old Town with Gothic and Renaissance buildings.', 'https://www.azamaraclubcruises.com/sites/default/files/heros/pr-dubrovnik-croatia-29-jun-19_0.jpg', 2);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (23, 'Budapest is the Best', 4, 2000, '2018-03-07 00:00:00', '2018-03-15 00:00:00', 23, 'Budapest, Hungary’s capital, is bisected by the River Danube. Its 19th-century Chain Bridge connects the hilly Buda district with flat Pest. A funicular runs up Castle Hill to Buda’s Old Town, where the Budapest History Museum traces city life from Roman times onward. Trinity Square is home to 13th-century Matthias Church and the turrets of the Fishermen’s Bastion, which offer sweeping views.', 'https://www.budapest.com/w/respsliders/bpcompromo02_1_2_1_2.jpg', 1);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (24, 'Go to Lisbon', 5, 1790, '2018-01-01 00:00:00', '2018-01-10 00:00:00', 24, 'Lisbon is Portugal’s hilly, coastal capital city. From imposing São Jorge Castle, the view encompasses the old city’s pastel-colored buildings, Tagus Estuary and Ponte 25 de Abril suspension bridge. Nearby, the National Azulejo Museum displays 5 centuries of decorative ceramic tiles. Just outside Lisbon is a string of Atlantic beaches, from Cascais to Estoril.\n', 'https://www.discoverwalks.com/blog/wp-content/uploads/2018/03/lisbonintwodays-816x538.jpg', 2);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (25, 'Journey to Amsterdam', 4, 2575, '2018-04-05 00:00:00', '2018-04-17 00:00:00', 25, 'Amsterdam is the Netherlands’ capital, known for its artistic heritage, elaborate canal system and narrow houses with gabled facades, legacies of the city’s 17th-century Golden Age. Its Museum District houses the Van Gogh Museum, works by Rembrandt and Vermeer at the Rijksmuseum, and modern art at the Stedelijk. Cycling is key to the city’s character, and there are numerous bike paths.', 'https://flyingpig.nl/__data/assets/image/0019/524044/summer-amsterdam-FP.jpg', 1);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (26, 'Relax in Mallorca', 5, 2400, '2018-05-06 00:00:00', '2018-05-17 00:00:00', 26, 'Mallorca (Majorca) is one of Spain\'s Balearic Islands in the Mediterranean. It\'s known for beach resorts, sheltered coves, limestone mountains and Roman and Moorish remains. Capital Palma has nightlife, the Moorish Almudaina royal palace and 13th-century Santa María Cathedral. Stone-built villages include Pollença, with its art galleries and music festival, and hillside Fornalutx, surrounded by citrus plantations.', 'https://sonbrull.com/wp-content/uploads/2017/09/mirador-sa-creueta-top-mallorca-viewpoints-son-brull-hotel.jpg', 2);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (27, 'My Mexico City Adventure', 4, 2300, '2018-05-01 00:00:00', '2018-05-08 00:00:00', 27, 'Mexico City is the densely populated, high-altitude capital of Mexico. It\'s known for its Templo Mayor (a 13th-century Aztec temple), the baroque Catedral Metropolitana de México of the Spanish conquistadors and the Palacio Nacional, which houses historic murals by Diego Rivera. All of these are situated in and around the Plaza de la Constitución, the massive main square also known as the Zócalo.', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-644105824-1523286673.jpg', 3);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (28, 'Costa Rica Tree House Life', 3, 1900, '2018-05-12 00:00:00', '2018-05-25 00:00:00', 28, 'Costa Rica is a rugged, rainforested Central American country with coastlines on the Caribbean and Pacific. Though its capital, San Jose, is home to cultural institutions like the Pre-Columbian Gold Museum, Costa Rica is known for its beaches, volcanoes, and biodiversity. Roughly a quarter of its area is made up of protected jungle, teeming with wildlife including spider monkeys and quetzal birds.', 'https://jameskaiser.com/wp-content/uploads/2017/08/treehouse-lodge-costa-rica.jpg', 4);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (29, 'Epic India', 5, 1900, '2018-09-06 00:00:00', '2018-09-10 00:00:00', 29, 'Mumbai (formerly called Bombay) is a densely populated city on India’s west coast. A financial center, it\'s India\'s largest city. On the Mumbai Harbour waterfront stands the iconic Gateway of India stone arch, built by the British Raj in 1924. Offshore, nearby Elephanta Island holds ancient cave temples dedicated to the Hindu god Shiva. The city\'s also famous as the heart of the Bollywood film industry.', 'https://blockchaininvestio-c007.kxcdn.com/wp-content/uploads/2018/07/India-bitcoin.jpg', 5);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (30, 'New Zealand Exploration', 3, 3500, '2018-09-06 00:00:00', '2018-09-17 00:00:00', 30, 'Auckland, based around 2 large harbours, is a major city in the north of New Zealand’s North Island. In the centre, the iconic Sky Tower has views of Viaduct Harbour, which is full of superyachts and lined with bars and cafes. Auckland Domain, the city’s oldest park, is based around an extinct volcano and home to the formal Wintergardens. Near Downtown, Mission Bay Beach has a seaside promenade.', 'https://resources.stuff.co.nz/content/dam/images/1/l/b/7/n/k/image.related.StuffLandscapeSixteenByNine.620x349.1lghu5.png/1507765642168.jpg', 6);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (31, 'Australia Holiday', 3, 3000, '2018-01-06 00:00:00', '2018-01-20 00:00:00', 31, 'Sydney, capital of New South Wales and one of Australia\'s largest cities, is best known for its harbourfront Sydney Opera House, with a distinctive sail-like design. Massive Darling Harbour and the smaller Circular Quay port are hubs of waterside life, with the arched Harbour Bridge and esteemed Royal Botanic Garden nearby. Sydney Tower’s outdoor platform, the Skywalk, offers 360-degree views of the city and suburbs.', 'https://dingoos.com/wp-content/uploads/2017/05/ventajas-de-australia-1.jpg', 7);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (32, 'Whiskey Tour in Ireland', 3, 2375, '2018-02-07 00:00:00', '2018-02-17 00:00:00', 32, 'Belfast is Northern Ireland’s capital. It was the birthplace of the RMS Titanic, which famously struck an iceberg and sunk in 1912. This legacy is recalled in the renovated dockyards\' Titanic Quarter, which includes the Titanic Belfast, an aluminium-clad museum reminiscent of a ship’s hull, as well as shipbuilder Harland & Wolff’s Drawing Offices and the Titanic Slipways, which now host open-air concerts.', 'https://www.nationalgeographic.com/content/dam/travel/Guide-Pages/europe/ireland/ireland_NationalGeographic_1561052.ngsversion.1501515053876.adapt.1900.1.jpg', 8);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (33, 'Black Sand in Iceland', 4, 2790, '2018-03-02 00:00:00', '2018-03-10 00:00:00', 33, 'Reynisfjara is a world-famous black-sand beach found on the South Coast of Iceland, just beside the small fishing village of Vík í Mýrdal. With its enormous basalt stacks, roaring Atlantic waves and stunning panoramas, Reynisfjara is widely considered to be the most beautiful example of Iceland\'s black sand beaches.', 'https://feel-planet.com/wp-content/uploads/2015/05/iceland.fell-the-planet.front_.jpg', 9);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (34, 'El Yunque Magic', 4, 2100, '2018-04-04 00:00:00', '2018-04-15 00:00:00', 34, 'Puerto Rico is a Caribbean island and unincorporated U.S. territory with a landscape of mountains, waterfalls and the El Yunque tropical rainforest. In San Juan, the capital and largest city, the Isla Verde area is known for its hotel strip, beach bars and casinos. Its Old San Juan neighborhood features colorful Spanish colonial buildings and El Morro and La Fortaleza, massive, centuries-old fortresses.', 'https://thumbnails.trvl-media.com/TJ73USmIXl3YGBkWzULka_r6pg4=/768x432/images.trvl-media.com/media/content/shared/images/travelguides/destination/500118/El-Yunque-National-Forest-243614.jpg', 10);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (35, 'See Machu Pichu', 5, 2300, '2018-05-05 00:00:00', '2018-05-19 00:00:00', 35, 'Machu Picchu is an Incan citadel set high in the Andes Mountains in Peru, above the Urubamba River valley. Built in the 15th century and later abandoned, it’s renowned for its sophisticated dry-stone walls that fuse huge blocks without the use of mortar, intriguing buildings that play on astronomical alignments and panoramic views. Its exact former use remains a mystery.', 'https://res.cloudinary.com/sagacity/image/upload/c_crop,h_2832,w_4256,x_0,y_0/c_limit,f_auto,fl_lossy,q_80,w_1080/shutterstock_147330278_axratp.jpg', 1);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (36, 'Egyptian Pyramids', 5, 2500, '2018-06-09 00:00:00', '2018-06-21 00:00:00', 36, 'The Egyptian pyramids are ancient pyramid-shaped masonry structures located in Egypt. As of November 2008, sources cite either 118 or 138 as the number of identified Egyptian pyramids. Most were built as tombs for the country\'s pharaohs and their consorts during the Old and Middle Kingdom periods', 'https://images.memphistours.com/large/155784764_4.jpg', 1);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (37, 'Ancient Greece', 5, 3000, '2018-07-08 00:00:00', '2018-07-16 00:00:00', 37, 'Athens is the capital of Greece. It was also at the heart of Ancient Greece, a powerful civilization and empire. The city is still dominated by 5th-century BC landmarks, including the Acropolis, a hilltop citadel topped with ancient buildings like the colonnaded Parthenon temple. The Acropolis Museum, along with the National Archaeological Museum, preserves sculptures, vases, jewelry and more from Ancient Greece', 'https://www.telegraph.co.uk/content/dam/Travel/commerce-partners/cosmos/productimages/wonders-ancient-greece/RESTRICTED-cosmostours-wondersancient-leadasset-TRAVEL-xlarge.jpg', 1);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (38, 'Mt Everest Trek', 4, 3500, '2018-08-20 00:00:00', '2018-08-30 00:00:00', 38, 'Mount Everest, known in Nepali as Sagarmatha and in Tibetan as Chomolungma, is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The international border between Nepal and China runs across its summit point.', 'https://img.purch.com/w/660/aHR0cDovL3d3dy5saXZlc2NpZW5jZS5jb20vaW1hZ2VzL2kvMDAwLzA5Ny8zNzUvb3JpZ2luYWwvZXZlcmVzdC1jbGltYmVyLmpwZw==', 2);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (39, 'Madagascar', 4, 2769, '2018-09-01 00:00:00', '2018-09-11 00:00:00', 39, 'Madagascar is a huge island nation off the southeast coast of Africa. It\'s home to thousands of animal species, such as lemurs, found nowhere else, plus rainforests, beaches and reefs. Near the busy capital, Antananarivo, is Ambohimanga, a hillside complex of royal palaces and burial grounds, as well as the “Avenue of the Baobabs,” a dirt road lined by massive centuries-old trees.', 'https://www.peregrineadventures.com/sites/peregrine/files/styles/low-quality/public/pd/highlight/image/madagascar_lemur_highlight.jpg', 3);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (40, 'Inca Ruins', 4, 2700, '2018-02-06 00:00:00', '2018-02-13 00:00:00', 40, 'The Inca Empire, also known as the Incan Empire and the Inka Empire, was the largest empire in pre-Columbian America. Its political and administrative structure \"was the most sophisticated found among native peoples\" in the Americas.', 'https://www.intltravelnews.com/images/2009/07/big/ecuadoringapira-temple-of-the-sun.jpg', 4);
INSERT INTO `trip` (`id`, `title`, `rating`, `total_cost`, `date_start`, `date_end`, `destination_id`, `review`, `img_link`, `profile_id`) VALUES (41, 'Havana', 3, 2100, '2018-03-06 00:00:00', '2018-03-21 00:00:00', 41, 'Havana is Cuba’s capital city. Spanish colonial architecture in its 16th-century Old Havana core includes the Castillo de la Real Fuerza, a fort and maritime museum. The National Capitol Building is an iconic 1920s landmark. Also in Old Havana is the baroque Catedral de San Cristóbal and Plaza Vieja, whose buildings reflect the city’s vibrant architectural mix.', 'http://sl7feomna9-flywheel.netdna-ssl.com/wp-content/uploads/2013/03/HTC-11.jpg', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `posts`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (1, '<iframe src=\"https://www.thebrokebackpacker.com/backpacking-barcelona-travel-guide/\" width=\"200\" height=\"200\">\n</iframe>', 1, DEFAULT, 1);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (2, '<iframe src=\"https://www.youtube.com/channel/UCS2ezhBvebMx6BUL-4qpadQ\" width=\"200\" height=\"200\">\n</iframe>', 2, DEFAULT, 2);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (3, '<iframe src=\"https://www.thecrazytourist.com/top-25-things-to-do-in-prague/\" width=\"200\" height=\"200\">\n</iframe>', 3, DEFAULT, 3);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (4, '<iframe src=\"https://www.hostelworld.com/hostels/China\" width=\"200\" height=\"200\">\n</iframe>', 4, DEFAULT, 4);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (5, '<iframe src=\"https://www.myswitzerland.com/en-us/interlaken.html\" width=\"200\" height=\"200\">\n</iframe>', 5, DEFAULT, 5);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (6, '<iframe src=\"https://www.lonelyplanet.com/italy/venice\" width=\"200\" height=\"200\">\n</iframe>', 6, DEFAULT, 6);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (7, '<iframe src=\"https://www.independent.co.uk/travel/news-and-advice/paris-car-free-sundays-city-centre-france-pedestrian-a8566991.html\" width=\"200\" height=\"200\">\n</iframe>', 7, DEFAULT, 7);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (8, '<iframe src=\"https://travel.usnews.com/Rome_Italy/Things_To_Do/\" width=\"200\" height=\"200\">\n</iframe>', 8, DEFAULT, 8);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (9, '<iframe src=“images/places/berlinmetro.png“ width=\"200\" height=\"200\">\n</iframe>', 9, DEFAULT, 9);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (10, '<iframe src=“images/places/krakowmap.jpg“ width=\"200\" height=\"200\">\n</iframe>', 10, DEFAULT, 10);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (11, 'Hey I got a job offer to teach in Spain?  Should I take it?  Anyone have experience with that?', 11, DEFAULT, 1);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (12, 'Hey, what’s the best site to use for flights?  Let me know if the comments.  Appreciate the tips.  Check out my trip to Denmark.', 12, DEFAULT, 2);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (13, 'Just got back from Germany, I’m going to Oktoberfest next year, what are your accommodation recommendations?', 13, DEFAULT, 3);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (14, 'Just went to Vienna, check out my run-down for tips and pointers.  Ask me anything, I love talking travel with you guys.', 14, DEFAULT, 4);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (15, 'London was amazing!  Where should I go next?', 15, DEFAULT, 5);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (16, 'If you’re thinking about going to Dubai, check out my trip post and let’s chat.', 16, DEFAULT, 6);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (17, 'I wanna go back to Thailand!  Any adventurous people wanna join next time?', 17, DEFAULT, 7);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (18, 'Just got back from Vietnam and my passport is almost expired, how far in advance should I renew my passport?', 18, DEFAULT, 8);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (19, 'Fun times in Singapore!  What are your 3 must have items to pack when backpacking?', 19, DEFAULT, 9);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (20, 'I’m on my way to China after a fantastic trip in Tokyo, give me some recommendations for places to see!', 20, DEFAULT, 10);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (21, 'Should I get travel insurance?  How much is it?  Does anyone have experience with this?', 21, DEFAULT, 1);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (22, 'Is it safe to travel solo in Portugal?  Just spent an amazing week traveling solo in Croatia.', 22, DEFAULT, 2);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (23, 'Anyone familiar with how to get a visa to travel to China?  Just left Budapest.  ', 23, DEFAULT, 3);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (24, 'Portugal was awesome!  Check out my trip post.', 24, DEFAULT, 4);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (25, 'Anyone fly RyanAir?  How did you like it?  What should I be aware of?  Check out my holiday in Amsterdam.', 25, DEFAULT, 5);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (26, 'Leaving Mallorca.  How much money should I save to travel to Iceland?  ', 26, DEFAULT, 6);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (27, 'I lost my passport in Mexico City!  Among other fascinating tales.  Follow my adventures…', 27, DEFAULT, 7);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (28, 'Anyone every stay in a treehouse?  I did!  In Costa Rica!', 28, DEFAULT, 8);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (29, 'Does anyone take emergency cash when you travel?  How much do you take?', 29, DEFAULT, 9);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (30, 'Hey guys, new to the site, follow my adventures.', 30, DEFAULT, 10);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (31, 'Don’t wonder, WANDER!  Love following all your adventures.', 31, DEFAULT, 1);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (32, 'Did anyone have issues using the passport card?  Is it worth it to get the card?', 32, DEFAULT, 2);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (33, 'Black Sand beach in Iceland was surreal…', 33, DEFAULT, 3);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (34, 'Hey guys, new to the site, follow my adventures.', 34, DEFAULT, 4);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (35, 'Hey guys, check out beautiful Lima!', 35, DEFAULT, 5);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (36, 'Put Egypt on your wishlist for sure!', 36, DEFAULT, 6);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (37, 'Throw any of your questions about Greece at me, just got back, and it was awesome.', 37, DEFAULT, 7);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (38, 'Has anyone used Contiki? Might use it for next trip after I decompress from Mt Everest', 38, DEFAULT, 8);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (39, 'Fun times in Madagascar.', 39, DEFAULT, 9);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (40, 'Went to Ecuador and it was awesome!', 40, DEFAULT, 10);
INSERT INTO `posts` (`id`, `message`, `trip_id`, `create_date`, `prof_id`) VALUES (41, 'I have all the details on travel to Cuba, comment your questions.', 41, DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (1, 'Right on!', 1, 1, DEFAULT);
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (2, 'Nice post!', 2, 2, DEFAULT);
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (3, 'Enjoying your posts', 3, 3, DEFAULT);
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (4, 'You win the internet!', 4, 4, DEFAULT);
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (5, 'Totally want to make my way out there', 5, 5, DEFAULT);
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (6, 'What are your top restaurant picks?', 6, 6, DEFAULT);
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (7, 'How much should I save for this trip?', 7, 7, DEFAULT);
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (8, 'What tour do your recommend?', 8, 8, DEFAULT);
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (9, 'What kind of footwear did you take?', 9, 9, DEFAULT);
INSERT INTO `comment` (`id`, `content`, `post_id`, `prof_id`, `create_date`) VALUES (10, 'How was the metro?', 10, 10, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorites`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (1, 10);
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (2, 9);
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (3, 8);
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (4, 7);
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (5, 6);
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (6, 5);
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (7, 4);
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (8, 3);
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (9, 2);
INSERT INTO `favorites` (`trip_id`, `profile_id`) VALUES (10, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rec_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `rec_type` (`id`, `name`) VALUES (1, 'warning');
INSERT INTO `rec_type` (`id`, `name`) VALUES (2, 'tip');
INSERT INTO `rec_type` (`id`, `name`) VALUES (3, 'resource');

COMMIT;


-- -----------------------------------------------------
-- Data for table `recommendation`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (1, 1, 1, 'https://www.gov.uk/foreign-travel-advice/spain');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (2, 2, 2, 'Walk through all the tents to experience the different themes');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (3, 3, 3, 'https://www.lonelyplanet.com/czech-republic/prague');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (4, 4, 2, 'https://www.hostelworld.com/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (5, 5, 3, 'https://www.busabout.com/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (6, 6, 3, 'https://www.xe.com/currencyconverter/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (7, 7, 1, 'Careful with shifty street vendors');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (8, 8, 2, 'Take the metro');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (9, 9, 3, 'https://www.lonelyplanet.com/germany/berlin');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (10, 10, 3, 'https://www.atlasobscura.com/places/sedlec-ossuary');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (11, 11, 3, 'https://www.eurail.com/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (12, 12, 3, 'https://www.eater.com/maps/best-copenhagen-restaurants-38');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (13, 13, 3, 'https://www.der-dresdner-zwinger.de/de/startseite/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (14, 14, 3, 'http://davidsbeenhere.com/2017/04/12/top-10-things-to-do-in-vienna-austria/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (15, 15, 3, 'https://www.visitlondon.com/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (16, 16, 3, 'https://www.dubai.com/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (17, 17, 3, 'http://www.thailand-guide.com/maps.htm');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (18, 18, 3, 'http://www.vietnam-guide.com/maps/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (19, 19, 3, 'https://www.bbc.com/news/world-asia-15961759');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (20, 20, 3, 'https://www.travelandleisure.com/travel-guide/tokyo');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (21, 21, 2, 'https://travel.state.gov/content/travel/en/traveladvisories/traveladvisories/turkey-travel-advisory.html');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (22, 22, 2, 'https://www.britannica.com/place/Croatia');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (23, 23, 2, 'https://wikitravel.org/en/Budapest');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (24, 24, 2, 'https://lisbonlisboaportugal.com/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (25, 25, 2, 'https://www.iamsterdam.com/en');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (26, 26, 2, 'https://www.lonelyplanet.com/spain/mallorca');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (27, 27, 2, 'https://www.lonelyplanet.com/mexico/mexico-city');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (28, 28, 2, 'https://jameskaiser.com/costa-rica-guide/hotels/tree-house/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (29, 29, 2, 'https://www.lonelyplanet.com/india/travel-tips-and-articles/5-tips-for-india-first-timers/40625c8c-8a11-5710-a052-1479d27705ec');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (30, 30, 2, 'https://www.lonelyplanet.com/new-zealand');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (31, 31, 2, 'https://www.lonelyplanet.com/australia');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (32, 32, 2, 'https://www.lonelyplanet.com/ireland');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (33, 33, 2, 'https://guidetoiceland.is/travel-iceland/drive/reynisfjara');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (34, 34, 2, 'https://islandsofpuertorico.com/puerto-rico-tourism-after-hurricane-maria/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (35, 35, 2, 'https://www.lonelyplanet.com/peru/machu-picchu');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (36, 36, 1, 'Don’t feed the bears');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (37, 37, 1, 'Look both ways when you cross the street');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (38, 38, 3, 'https://www.rmiguides.com/himalaya/everest');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (39, 39, 3, 'https://www.lonelyplanet.com/madagascar');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (40, 40, 3, 'https://www.touropia.com/ancient-inca-ruins/');
INSERT INTO `recommendation` (`id`, `trip_id`, `rec_type_id`, `content`) VALUES (41, 41, 2, 'https://www.lonelyplanet.com/cuba/havana');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `tag` (`id`, `name`) VALUES (1, 'backpacking');
INSERT INTO `tag` (`id`, `name`) VALUES (2, 'leisure');
INSERT INTO `tag` (`id`, `name`) VALUES (3, 'business');
INSERT INTO `tag` (`id`, `name`) VALUES (4, 'study abroad');
INSERT INTO `tag` (`id`, `name`) VALUES (5, 'work visa');
INSERT INTO `tag` (`id`, `name`) VALUES (6, 'vacation');
INSERT INTO `tag` (`id`, `name`) VALUES (7, 'holiday');
INSERT INTO `tag` (`id`, `name`) VALUES (8, 'party');
INSERT INTO `tag` (`id`, `name`) VALUES (9, 'education');
INSERT INTO `tag` (`id`, `name`) VALUES (10, 'gap year');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trip_tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelappdb`;
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (1, 1);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (1, 2);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (2, 1);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (2, 8);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (2, 2);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (3, 4);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (3, 1);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (4, 1);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (4, 2);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (4, 4);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (5, 1);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (6, 8);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (6, 2);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (7, 4);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (8, 6);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (8, 5);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (9, 9);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (9, 10);
INSERT INTO `trip_tag` (`trip_id`, `tag_id`) VALUES (10, 1);

COMMIT;

