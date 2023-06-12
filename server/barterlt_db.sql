-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2023 at 04:38 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barterlt_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `apps_items`
--

CREATE TABLE `apps_items` (
  `item_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_desc` varchar(200) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `item_price` float NOT NULL,
  `item_qty` int(5) NOT NULL,
  `item_con` varchar(50) NOT NULL,
  `item_trade` varchar(50) NOT NULL,
  `item_lat` varchar(50) NOT NULL,
  `item_long` varchar(50) NOT NULL,
  `item_state` varchar(50) NOT NULL,
  `item_locality` varchar(50) NOT NULL,
  `item_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `apps_items`
--

INSERT INTO `apps_items` (`item_id`, `user_id`, `item_name`, `item_desc`, `item_type`, `item_price`, `item_qty`, `item_con`, `item_trade`, `item_lat`, `item_long`, `item_state`, `item_locality`, `item_date`) VALUES
(1, 3, 'Speaker', 'Good sound', 'Electronics', 59.9, 1, '8/10', 'Earphone', '4.189535', '100.71115', 'Perak', 'Sitiawan', '2023-06-11 21:11:40.685921'),
(3, 3, 'Bicycle', 'Expensive', 'Automotive', 69.9, 1, '10/10', 'Green color bicycle', '4.58283', '101.06917', 'Perak', 'Ipoh', '2023-06-11 21:20:47.889467'),
(4, 3, 'Table Tennis Racket', 'Butterfly RDJ-S1 FL Shakehand Racket', 'Sports & Fitness', 79.9, 3, 'Good, New', 'STIGA Pro Carbon+ Racket', '4.58283', '101.06917', 'Perak', 'Ipoh', '2023-06-12 17:51:46.888659'),
(6, 3, 'Sofa', 'White color, cotton', 'Home & Furniture', 299.9, 1, '7/10', 'Table', '4.70602', '101.127535', 'Perak', 'Chemor', '2023-06-12 18:49:14.584636'),
(8, 2, 'PS4', 'HIgh game resolution, awesome gaming power', 'Toys & Games', 2100, 1, '9/10', 'Nintendo Switch', '4.7087567', '101.1247883', 'Perak', 'Chemor', '2023-06-12 20:44:59.970806'),
(9, 1, 'Apple Pencil', '2nd Generation', 'Electronics', 499.9, 1, '10/10', 'Pink Color Apple Pencil', '4.58283', '101.06917', 'Perak', 'Ipoh', '2023-06-12 22:33:55.497309');

-- --------------------------------------------------------

--
-- Table structure for table `apps_user`
--

CREATE TABLE `apps_user` (
  `user_id` int(5) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_phone` varchar(12) NOT NULL,
  `user_pass` varchar(40) NOT NULL,
  `user_otp` varchar(5) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `apps_user`
--

INSERT INTO `apps_user` (`user_id`, `user_email`, `user_name`, `user_phone`, `user_pass`, `user_otp`, `user_datereg`) VALUES
(1, 'ch3ngw3n0331@gmail.com', 'chengwen', '0182129139', '1916b1b5e0a7f751366b0f136d7884cd7de07777', '61543', '0000-00-00 00:00:00.000000'),
(2, 'kaizhi@gmail.com', 'Chong Kai Zhi', '0174563270', 'bb8933d75e560b0c73868154d6aeb68e5d07e4d1', '51201', '0000-00-00 00:00:00.000000'),
(3, 'huiyi@gmail.com', 'huiyiooi', '0145214590', '331c121e56f555aa4c8e4eabb3af4b1985f8cbb8', '36274', '2023-05-22 13:15:11.827998');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apps_items`
--
ALTER TABLE `apps_items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `apps_user`
--
ALTER TABLE `apps_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apps_items`
--
ALTER TABLE `apps_items`
  MODIFY `item_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `apps_user`
--
ALTER TABLE `apps_user`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
