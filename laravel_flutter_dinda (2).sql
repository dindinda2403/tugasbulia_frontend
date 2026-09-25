-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 25, 2026 at 06:11 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel_flutter_dinda`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_07_20_071800_create_products_table', 2),
(5, '2026_08_21_052200_create_personal_access_tokens_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 3, 'flutter', '2c8c3a384f328e25b515fa17c5e2757908f3ca67929db1810b6bee362fde70de', '[\"*\"]', NULL, NULL, '2026-08-24 07:48:53', '2026-08-24 07:48:53'),
(2, 'App\\Models\\User', 3, 'flutter', '10491716c356af9b9f28dce10829a6b0e4b5e979252432a982700792ad7a5193', '[\"*\"]', NULL, NULL, '2026-08-28 02:59:39', '2026-08-28 02:59:39'),
(3, 'App\\Models\\User', 3, 'flutter', '9d5361386869b497869b07b4500ac3eb0c9e4125516ae639d95dec2d32225643', '[\"*\"]', NULL, NULL, '2026-08-28 02:59:39', '2026-08-28 02:59:39'),
(4, 'App\\Models\\User', 3, 'flutter', '3a41968ca988a0978c38a67aeba9aad9b28dee18c121251e3d382a176ed88313', '[\"*\"]', NULL, NULL, '2026-08-28 03:00:58', '2026-08-28 03:00:58'),
(5, 'App\\Models\\User', 3, 'flutter', 'f1b623dc237bee51a847c467426a64d854a0e06ad8e7a1f7dabf4e1435c79532', '[\"*\"]', NULL, NULL, '2026-08-28 03:03:05', '2026-08-28 03:03:05'),
(6, 'App\\Models\\User', 3, 'flutter', '93e01741c42b684147b49ada2716b3a09cc6eef008471eb9a704f484358c22b6', '[\"*\"]', NULL, NULL, '2026-08-28 03:12:12', '2026-08-28 03:12:12'),
(7, 'App\\Models\\User', 3, 'flutter', 'b2e8d10617cade075367f7c27c53de81855db58d1a5cef772adecbe4ddd6d62a', '[\"*\"]', NULL, NULL, '2026-08-28 03:13:07', '2026-08-28 03:13:07'),
(8, 'App\\Models\\User', 3, 'flutter', '108027a37842eb54278a044496d3bf5f2e2c49b68e57d3b957615aaac54171ec', '[\"*\"]', NULL, NULL, '2026-08-28 03:17:29', '2026-08-28 03:17:29'),
(9, 'App\\Models\\User', 3, 'flutter', '4949137ef581894ece418b7b324adc4b124bc23d9168ce884e8e0cb5542162c9', '[\"*\"]', NULL, NULL, '2026-08-28 03:28:27', '2026-08-28 03:28:27'),
(10, 'App\\Models\\User', 3, 'flutter', 'ac93dab595c4a3544ccab9ef5631c3cee26b3761164b8cccce107646bc6e8497', '[\"*\"]', NULL, NULL, '2026-08-28 03:34:03', '2026-08-28 03:34:03'),
(11, 'App\\Models\\User', 3, 'flutter', '2da5153ce28dccbc46bee95db24c34c7eeecc7986520923a1317150e509c77a6', '[\"*\"]', '2026-08-28 03:39:33', NULL, '2026-08-28 03:39:33', '2026-08-28 03:39:33'),
(12, 'App\\Models\\User', 3, 'flutter', 'e6f4622514c6c69476a0ded5f0b6388fdba8a4006748c37de0de5e0b3313c6e1', '[\"*\"]', '2026-09-25 02:30:29', NULL, '2026-09-01 02:35:44', '2026-09-25 02:30:29'),
(13, 'App\\Models\\User', 3, 'flutter', 'b7dcf5d123f006fe1650c243602ca8184144bb4f187b4a60ffe744520458e120', '[\"*\"]', '2026-09-01 02:43:18', NULL, '2026-09-01 02:42:58', '2026-09-01 02:43:18'),
(14, 'App\\Models\\User', 3, 'flutter', 'c7335dd91d3efb2939cad85d16617ee4b60a42d87a285203a5cc43540d296d85', '[\"*\"]', '2026-09-11 02:50:33', NULL, '2026-09-11 02:50:33', '2026-09-11 02:50:33'),
(15, 'App\\Models\\User', 3, 'flutter', '8de2c45223a4bef449e5f6ad9d5f8f8875df99e6be3845fa89fd0c5fee24ff99', '[\"*\"]', '2026-09-11 02:56:17', NULL, '2026-09-11 02:56:16', '2026-09-11 02:56:17'),
(16, 'App\\Models\\User', 3, 'flutter', '5202bd6af2646dd74bf31532b44cfd09dc88f8f64bb711fa5dd3b88f0ec32502', '[\"*\"]', '2026-09-11 03:05:23', NULL, '2026-09-11 03:05:22', '2026-09-11 03:05:23'),
(17, 'App\\Models\\User', 3, 'flutter', '545e5e4eda64155e0766d3a738d066e2f38a1cf9c580c5194109e695f4a6c932', '[\"*\"]', '2026-09-11 03:43:34', NULL, '2026-09-11 03:38:38', '2026-09-11 03:43:34'),
(18, 'App\\Models\\User', 3, 'flutter', '47174eef1a523d52888bd5bec27b9efb43a6e7ba1360930cee97d4aa948aecc3', '[\"*\"]', '2026-09-18 02:14:06', NULL, '2026-09-18 02:02:12', '2026-09-18 02:14:06'),
(19, 'App\\Models\\User', 3, 'flutter', '5d0011df1161a9b8b630f2a8c55ca05e09949ccc443f6ff74a9a7dc448ecb85b', '[\"*\"]', '2026-09-18 02:23:37', NULL, '2026-09-18 02:22:58', '2026-09-18 02:23:37'),
(20, 'App\\Models\\User', 3, 'flutter', '65fc860782f93d3ef5bd35c56f71e87293347897f6db1a887396a30d59f5cc4e', '[\"*\"]', '2026-09-18 02:32:26', NULL, '2026-09-18 02:31:00', '2026-09-18 02:32:26'),
(21, 'App\\Models\\User', 3, 'flutter', 'c1845c7a03bc7201cf0b08e810017b4a0376c1db2fe32d474aeb496e56b7a8b4', '[\"*\"]', '2026-09-25 02:31:28', NULL, '2026-09-25 02:31:28', '2026-09-25 02:31:28');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` double NOT NULL,
  `stok` int NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `gambar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `nama`, `harga`, `stok`, `deskripsi`, `gambar`, `created_at`, `updated_at`) VALUES
(10, 'mini fan goojodog', 215000, 1, 'kipas angin turbo', 'products/1789104252.jpg', '2026-08-03 18:51:26', '2026-09-11 02:45:20'),
(11, 'Bracelets Aesthetic', 15000, 2, 'bracelet aesthetic y2k', 'products/1789104851.jpg', '2026-09-11 02:34:11', '2026-09-11 02:34:11'),
(12, 'snoopy', 12000, 1, 'snoopy imur gemes', 'products/1789709546.png', '2026-09-18 02:23:37', '2026-09-18 02:32:26');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 'dinda', 'dinda@gmail.com', NULL, '$2y$12$cdaVrLf4cxRfw6baUaJZoOUn1mMb01WybOPzvyBNVv/815BwPH.HG', NULL, '2026-08-24 07:43:28', '2026-08-24 07:43:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
