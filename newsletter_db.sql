-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Erstellungszeit: 01. Feb 2022 um 19:04
-- Server-Version: 5.7.34
-- PHP-Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `newsletter_db`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `newsletter_tbl`
--

CREATE TABLE `newsletter_tbl` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `topic` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `newsletter_tbl`
--

INSERT INTO `newsletter_tbl` (`id`, `user`, `topic`) VALUES
(1, 10, 3),
(2, 10, 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `topics_tbl`
--

CREATE TABLE `topics_tbl` (
  `topic_id` int(11) NOT NULL,
  `topic` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `topics_tbl`
--

INSERT INTO `topics_tbl` (`topic_id`, `topic`) VALUES
(1, 'sport'),
(2, 'reise'),
(3, 'musik'),
(4, 'tiere');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_tbl`
--

CREATE TABLE `user_tbl` (
  `user_id` int(11) NOT NULL,
  `gender` text NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `user_tbl`
--

INSERT INTO `user_tbl` (`user_id`, `gender`, `firstname`, `name`, `email`) VALUES
(9, 'w', 'Biene', 'Maja', 'bm@wabe.de'),
(10, 'm', 'Klaus', 'Kleber', 'kk@news.de');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `newsletter_tbl`
--
ALTER TABLE `newsletter_tbl`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topic` (`topic`),
  ADD KEY `user` (`user`);

--
-- Indizes für die Tabelle `topics_tbl`
--
ALTER TABLE `topics_tbl`
  ADD PRIMARY KEY (`topic_id`);

--
-- Indizes für die Tabelle `user_tbl`
--
ALTER TABLE `user_tbl`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `newsletter_tbl`
--
ALTER TABLE `newsletter_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `topics_tbl`
--
ALTER TABLE `topics_tbl`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `user_tbl`
--
ALTER TABLE `user_tbl`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `newsletter_tbl`
--
ALTER TABLE `newsletter_tbl`
  ADD CONSTRAINT `newsletter_tbl_ibfk_1` FOREIGN KEY (`topic`) REFERENCES `topics_tbl` (`topic_id`),
  ADD CONSTRAINT `newsletter_tbl_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user_tbl` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
