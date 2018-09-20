CREATE TABLE `division` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(20) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `category` (
	`id` int NOT NULL AUTO_INCREMENT,
	`category_name` varchar(45) NOT NULL,
	`division_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `formula_detail` (
	`id` int NOT NULL AUTO_INCREMENT,
	`detail` longtext NOT NULL,
	`category_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `tips_and_tricks` (
	`id` int NOT NULL AUTO_INCREMENT,
	`title` varchar(50),
	`formula_id` int NOT NULL,
	`content` longtext NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `feedback` (
	`id` int NOT NULL AUTO_INCREMENT,
	`content` longtext NOT NULL,
	`time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `error_feedback` (
	`id` int NOT NULL AUTO_INCREMENT,
	`content` longtext NOT NULL,
	`formula_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `question` (
	`id` int NOT NULL AUTO_INCREMENT,
	`content` longtext NOT NULL,
	`category_id` int NOT NULL,
	`is_answered` bit NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `question_choices` (
	`id` int NOT NULL AUTO_INCREMENT,
	`question_id` int NOT NULL,
	`content` varchar(255) NOT NULL,
	`is_correct` bit NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `user_question_answer` (
	`id` int NOT NULL AUTO_INCREMENT,
	`question_id` int NOT NULL,
	`choice_id` int NOT NULL,
	`answer_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `example` (
	`id` int NOT NULL AUTO_INCREMENT,
	`formula_id` int NOT NULL,
	`content` longtext NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `category` ADD CONSTRAINT `category_fk0` FOREIGN KEY (`division_id`) REFERENCES `division`(`id`);

ALTER TABLE `formula_detail` ADD CONSTRAINT `formula_detail_fk0` FOREIGN KEY (`category_id`) REFERENCES `category`(`id`);

ALTER TABLE `tips_and_tricks` ADD CONSTRAINT `tips_and_tricks_fk0` FOREIGN KEY (`formula_id`) REFERENCES `formula_detail`(`id`);

ALTER TABLE `error_feedback` ADD CONSTRAINT `error_feedback_fk0` FOREIGN KEY (`formula_id`) REFERENCES `formula_detail`(`id`);

ALTER TABLE `question` ADD CONSTRAINT `question_fk0` FOREIGN KEY (`category_id`) REFERENCES `category`(`id`);

ALTER TABLE `question_choices` ADD CONSTRAINT `question_choices_fk0` FOREIGN KEY (`question_id`) REFERENCES `question`(`id`);

ALTER TABLE `user_question_answer` ADD CONSTRAINT `user_question_answer_fk0` FOREIGN KEY (`question_id`) REFERENCES `question`(`id`);

ALTER TABLE `user_question_answer` ADD CONSTRAINT `user_question_answer_fk1` FOREIGN KEY (`choice_id`) REFERENCES `question_choices`(`id`);

ALTER TABLE `example` ADD CONSTRAINT `example_fk0` FOREIGN KEY (`formula_id`) REFERENCES `formula_detail`(`id`);

