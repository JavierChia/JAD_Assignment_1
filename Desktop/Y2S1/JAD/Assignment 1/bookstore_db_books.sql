-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: bookstore_db
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `publication_date` date NOT NULL,
  `ISBN` varchar(255) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `rating` int NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'To Kill A MockingBird','Harper Lee',12.99,100,'J. B. Lippincott & Co.','1960-07-11','9780446310789','-6-9-',4,'To Kill A Mockingbird is both a young girl\'s coming-of-age story and a darker drama about the roots and consequences of racism and prejudice, probing how good and evil can coexist within a single community or individual.'),(2,'Pride and Prejudice','Jane Austen',9.99,50,'T. Egerton, Whitehall','1813-01-28','9780141439518','-3-10-',5,'Pride and Prejudice is a classic novel that follows the romantic entanglements of the Bennet sisters and explores themes of love, marriage, and societal expectations.'),(3,'1984','George Orwell',10.99,75,'Secker & Warburg','1949-06-08','9780451524935','-3-7-',5,'1984 depicts a totalitarian society ruled by the Party, led by Big Brother. The novel explores themes of government surveillance, thought control, and the power of language.'),(4,'The Great Gatsby','F. Scott Fitzgerald',11.99,60,'Charles Scribner\'s Sons','1925-04-10','9780743273565','-2-8-',4,'The Great Gatsby is set in the Jazz Age and follows the elusive millionaire Jay Gatsby and his obsession with the beautiful Daisy Buchanan. The novel explores themes of wealth, love, and the American Dream.'),(5,'The Catcher in the Rye','J.D. Salinger',9.99,80,'Little, Brown and Company','1951-07-16','9780316769174','-5-9-',4,'The Catcher in the Rye is a novel narrated by Holden Caulfield, a teenager struggling with identity, alienation, and the phoniness of the adult world.'),(6,'Harry Potter and the Philosopher\'s Stone','J.K. Rowling',14.99,120,'Bloomsbury Publishing','1997-06-26','9780747532743','-1-6-',5,'Harry Potter and the Philosopher\'s Stone is the first book in the Harry Potter series, introducing the magical world of Hogwarts, Harry Potter, and his battle against the dark wizard Lord Voldemort.'),(7,'The Hobbit','J.R.R. Tolkien',13.99,90,'George Allen & Unwin','1937-09-21','9780007440832','-1-6-',5,'The Hobbit follows the adventures of Bilbo Baggins, a hobbit who embarks on a quest to reclaim the dwarves\' homeland from the dragon Smaug. It is set in Tolkien\'s Middle-earth and serves as a prelude to The Lord of the Rings.'),(8,'Moby-Dick','Herman Melville',11.99,70,'Richard Bentley','1851-10-18','9780142437247','-6-8-',4,'Moby-Dick is an epic tale of Captain Ahab\'s obsessive pursuit of the white whale. It explores themes of obsession, fate, and the human struggle against nature.'),(9,'Jane Eyre','Charlotte Brontë',10.99,60,'Smith, Elder & Co.','1847-10-16','9780141441146','-2-8-',5,'Jane Eyre is a story of a young woman who overcomes the challenges of her troubled childhood and finds love, independence, and self-discovery.'),(10,'The Lord of the Rings','J.R.R. Tolkien',24.99,100,'George Allen & Unwin','1954-07-29','9780261102385','-1-6-',5,'The Lord of the Rings is an epic fantasy trilogy that follows the quest to destroy the One Ring and defeat the dark lord Sauron. It explores themes of heroism, friendship, and the corrupting influence of power.');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-03 14:47:18
