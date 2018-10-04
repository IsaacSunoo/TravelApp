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
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (2, 'SteveS', 'password', 'SS@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (3, 'JorgeS', 'password', 'JS@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (4, 'GeorgeD', 'password', 'GD@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (5, 'BrockL', 'password', 'BL@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (6, 'AndyC', 'password', 'AC@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (7, 'TateC', 'password', 'TC@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (8, 'ArnoldF', 'password', 'AF@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (9, 'JeffC', 'password', 'JC@wander.com', 1, 'standard');
INSERT INTO `user` (`id`, `name`, `password`, `email`, `active`, `role`) VALUES (10, 'GillW', 'password', 'GW@wander.com', 1, 'standard');

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
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (1, 1, 'James', 'Gill', 'images/UserPics/James_Gill.png', 1, 'I like turtles and hockey.  I love trying new foods and meeting new people.  I’ve never been to Argentina but I have been to Alaska and that was fun.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (2, 2, 'Steve', 'Striker', 'images/UserPics/Steve_Striker.png', 2, 'I’m in tech and super busy but when I find the time, I like a good adventure and shredding the gnar.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (3, 3, 'Jorge', 'Sims', 'images/UserPics/Jorge_Sims.png', 3, 'I’m in school for now but planning an epic adventure in Switzerland when I’m done.  Looking forward to celebrating and taking some time to adventure.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (4, 4, 'George', 'Danger', 'images/UserPics/George_Danger.png', 4, 'My name is Danger which is fitting that I love to swim with sharks.  My dog’s name is Carbon and he follows me on all over the globe.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (5, 5, 'Brock', 'Lee', 'images/UserPics/Brock_Lee.png', 5, 'I have a strong name which matches my strong desire to travel, adventure, kick butt and take names.  I plan to visit every country ever invented.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (6, 6, 'Andy', 'Conling', 'images/UserPics/Andy_Conling.png', 6, 'I take pictures of my adventures to build up my social media platform.  Go follow my insta to see my travels.  I love meeting like-minded travelers.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (7, 7, 'Tate', 'Channer', 'images/UserPics/Tate_Channer.png', 7, 'I haven’t traveled much but I’m planning an epic journey for the near future.  I’m hoping this community will inspire me to reach that goal.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (8, 8, 'Arnold', 'Farms', 'images/UserPics/Arnold_Farms.png', 8, 'I’m here to share my travels with you fine folks.  Let’s get together and adventure!');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (9, 9, 'Jeff', 'Collins', 'images/UserPics/Jeff_Collins.png', 9, 'My life is a journey.  I’m here to find people to travel with and be inspired.');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `img_link`, `location_id`, `bio`) VALUES (10, 10, 'Gill', 'Walberg', 'images/UserPics/Gill_Walberg.png', 10, 'I like tacos.');

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

