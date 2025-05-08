-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 08 mai 2025 à 04:03
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `db_lyspi_unc`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `tel` int(11) DEFAULT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `user` varchar(30) NOT NULL,
  `mot_de_passe` varchar(30) NOT NULL,
  `code_confirmation` varchar(6) DEFAULT NULL,
  `mail` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`id`, `tel`, `nom`, `prenom`, `user`, `mot_de_passe`, `code_confirmation`, `mail`) VALUES
(1, NULL, 'sacko', 'mamady', '111', '111', NULL, ''),
(2, NULL, 'kamano', 'ismael', '222', '222', NULL, 'servicesdiecoles@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

CREATE TABLE `adresse` (
  `id` int(11) NOT NULL,
  `id_entreprise` int(11) DEFAULT NULL,
  `id_etudiant` int(11) DEFAULT NULL,
  `commune` varchar(20) NOT NULL,
  `quartier` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`id`, `id_entreprise`, `id_etudiant`, `commune`, `quartier`) VALUES
(1, NULL, 1, 'DIXINN', 'kenien'),
(2, NULL, 2, 'matamjhk', 'ck jhlkcfhlkj'),
(3, NULL, 3, 'gbessia', 'port 1'),
(4, NULL, 4, 'sonfonia', 'focidhè');

-- --------------------------------------------------------

--
-- Structure de la table `aimer`
--

CREATE TABLE `aimer` (
  `id` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `id_offre` int(11) NOT NULL,
  `date` date NOT NULL DEFAULT curdate(),
  `statut` tinyint(1) NOT NULL DEFAULT 0 CHECK (`statut` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `aimer`
--

INSERT INTO `aimer` (`id`, `id_etudiant`, `id_offre`, `date`, `statut`) VALUES
(5, 3, 13, '2025-05-07', 1),
(6, 3, 12, '2025-05-07', 0),
(7, 3, 14, '2025-05-07', 0),
(8, 3, 19, '2025-05-07', 1);

-- --------------------------------------------------------

--
-- Structure de la table `cert_attes`
--

CREATE TABLE `cert_attes` (
  `id` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `id_type_cert_attes` int(11) NOT NULL,
  `description` text NOT NULL,
  `diplome` varchar(100) DEFAULT NULL,
  `date_obtention` date DEFAULT NULL,
  `delivre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cert_attes`
--

INSERT INTO `cert_attes` (`id`, `id_etudiant`, `id_type_cert_attes`, `description`, `diplome`, `date_obtention`, `delivre`) VALUES
(19, 2, 1, 'lsdjlsjk', 'uploads/certificats/1745809237243-dabo.png', '2020-02-02', 'qsflsjflqs'),
(20, 2, 2, 'yuh', 'uploads/certificats/1745809489816-icone unc.jpg', '2020-01-04', 'i');

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

CREATE TABLE `commentaires` (
  `id` int(11) NOT NULL,
  `id_offre` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `commentaire` text NOT NULL,
  `date_commentaire` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `commentaires`
--

INSERT INTO `commentaires` (`id`, `id_offre`, `id_etudiant`, `commentaire`, `date_commentaire`) VALUES
(7, 12, 3, 'bonjour', '2025-05-07'),
(8, 13, 3, 'super', '2025-05-07'),
(9, 19, 3, 'super', '2025-05-07');

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `contact`
--

INSERT INTO `contact` (`id`, `tel`, `email`) VALUES
(1, '0600000001', 'sacko2120@gmail.com'),
(2, '612,,s,1455', 'servicesdiecoles@gmail.com'),
(3, '0600000003', 'abdourahamanekaba23@gmail.com'),
(4, '0600000004', 'soumahb21@gmail.com'),
(5, '0600000005', 'contact5@example.com'),
(6, '0600000006', 'kamanoismael684@gmail.com'),
(7, '0600000007', 'ismaelkamano032@gmail.com'),
(8, '0600000008', 'contact8@example.com'),
(9, '0600000009', 'contact9@example.com'),
(10, '0600000010', 'contact10@example.com');

-- --------------------------------------------------------

--
-- Structure de la table `departement`
--

CREATE TABLE `departement` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `departement`
--

INSERT INTO `departement` (`id`, `nom`) VALUES
(1, 'GENIE INFO_TELECOM'),
(2, 'MIAGE'),
(3, 'ECONOMIE'),
(4, 'SCIENCE COMPTABLE');

-- --------------------------------------------------------

--
-- Structure de la table `departement_licence`
--

CREATE TABLE `departement_licence` (
  `id` int(11) NOT NULL,
  `id_departement` int(11) NOT NULL,
  `id_licence` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `departement_licence`
--

INSERT INTO `departement_licence` (`id`, `id_departement`, `id_licence`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 2, 1),
(6, 2, 2),
(7, 2, 3),
(8, 2, 4),
(9, 3, 1),
(10, 3, 2),
(11, 3, 3),
(12, 4, 1),
(13, 4, 2),
(14, 4, 3);

-- --------------------------------------------------------

--
-- Structure de la table `document`
--

CREATE TABLE `document` (
  `id` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `dipl_baccalaureat` varchar(100) DEFAULT NULL,
  `extrait_naissance` varchar(100) DEFAULT NULL,
  `releve_notes` varchar(100) DEFAULT NULL,
  `dipl_licence` varchar(100) DEFAULT NULL,
  `dipl_master` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `document`
--

INSERT INTO `document` (`id`, `id_etudiant`, `dipl_baccalaureat`, `extrait_naissance`, `releve_notes`, `dipl_licence`, `dipl_master`) VALUES
(1, 4, '/uploads/documents/makossa-1744856507204-516793105.jpg', '/uploads/documents/Capture 5-1744857421287-908083323.PNG', '/uploads/documents/Capture-1744860713441-49349241.PNG', '/uploads/documents/Capture 10-1744858752316-213588778.PNG', '/uploads/documents/Capture 5-1744860312236-911406186.PNG'),
(2, 3, '/uploads/documents/Capture-1744862113485-489517183.PNG', NULL, NULL, NULL, NULL),
(3, 3, NULL, NULL, NULL, NULL, NULL),
(4, 3, NULL, NULL, NULL, NULL, NULL),
(5, 6, '/uploads/documents/dabo-1745154451476-738510962.png', NULL, NULL, NULL, NULL),
(23, 2, '/uploads/documents/icone unc-1745807028138-371685423.jpg', '/uploads/documents/dabo-1745806983630-660858305.png', '/uploads/documents/icone unc-1745808120904-973857301.png', '/uploads/documents/makossa-1745807046466-288882345.jpg', '/uploads/documents/dabo-1745807064718-579924048.png'),
(24, 3, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `domaine`
--

CREATE TABLE `domaine` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `domaine`
--

INSERT INTO `domaine` (`id`, `nom`) VALUES
(1, 'Technologie'),
(2, 'Marketing'),
(3, 'Finance'),
(4, 'Ressources Humaines');

-- --------------------------------------------------------

--
-- Structure de la table `domaine_entreprise`
--

CREATE TABLE `domaine_entreprise` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `domaine_entreprise`
--

INSERT INTO `domaine_entreprise` (`id`, `nom`) VALUES
(1, 'Informatique / TIC'),
(2, 'Construction / BTP'),
(3, 'Commerce / Distribution'),
(4, 'Transport / Logistique'),
(5, 'Agriculture / Agroalimentaire'),
(6, 'Éducation / Formation'),
(7, 'Santé / Médical'),
(8, 'Énergie / Environnement'),
(9, 'Finance / Assurance / Banque'),
(10, 'Conseil / Audit'),
(11, 'Industrie / Production'),
(12, 'Tourisme / Hôtellerie / Restauration'),
(13, 'Communication / Marketing / Publicité'),
(14, 'Immobilier'),
(15, 'Art / Culture / Spectacle'),
(16, 'Télécommunications'),
(17, 'Sécurité / Surveillance'),
(18, 'Humanitaire / ONG / Développement'),
(19, 'Administration publique / Services publics'),
(20, 'Recherche / Innovation / R&D');

-- --------------------------------------------------------

--
-- Structure de la table `entreprise`
--

CREATE TABLE `entreprise` (
  `id` int(11) NOT NULL,
  `nom_complet_user` varchar(50) DEFAULT NULL,
  `sigle` varchar(10) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `nom_entreprise` varchar(35) DEFAULT NULL,
  `mail` varchar(30) NOT NULL,
  `user` varchar(35) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `code_confirmation` varchar(6) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `site_web` varchar(30) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `domaine_intervention` text DEFAULT NULL,
  `id_type_entreprise` int(11) DEFAULT NULL,
  `id_secteur_geographique` int(11) DEFAULT NULL,
  `id_domaine_entreprise` int(11) DEFAULT NULL,
  `id_admin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `entreprise`
--

INSERT INTO `entreprise` (`id`, `nom_complet_user`, `sigle`, `description`, `nom_entreprise`, `mail`, `user`, `mot_de_passe`, `code_confirmation`, `tel`, `site_web`, `logo`, `domaine_intervention`, `id_type_entreprise`, `id_secteur_geographique`, `id_domaine_entreprise`, `id_admin`) VALUES
(11, NULL, NULL, 'ttesb', 'Ma société 1', 'isnnf@gmail.com', '555', '555', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'makkossa', 'null', 'null', 'entreprise de test', 'sss@gmail.com', '111', '111', NULL, '', '', '/uploads/logo/AMI-1746632141348-6124932.PNG', 'jgjghhh', 4, 1, 17, NULL),
(16, 'Mam', 'Sacko', 'dklqsf:s;fqskldfjqsd', 'sackoentreprise', 'servicesdiecoles@gmail.com', '888', '123', NULL, 'jkhkk', 'makossakjhkhk', '/uploads/logo/aminata-1746456818072-641180958.jpg', 'qDSLKQDHJKq', 11, 3, 5, NULL),
(28, NULL, NULL, NULL, 'jksdmùfkmsl', 'servicesdiecoles@gmail.com', '123', '123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

CREATE TABLE `etudiant` (
  `id` int(11) NOT NULL,
  `matricule` varchar(10) NOT NULL,
  `id_departement` int(11) NOT NULL,
  `id_licence` int(11) NOT NULL,
  `id_startup` int(11) DEFAULT NULL,
  `id_contact` int(11) DEFAULT NULL,
  `date_inscription` date NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(35) NOT NULL,
  `sexe` varchar(3) NOT NULL,
  `date_naissance` date NOT NULL,
  `lieu_naissance` varchar(30) NOT NULL,
  `nom_pere` varchar(30) DEFAULT NULL,
  `nom_mere` varchar(30) DEFAULT NULL,
  `nationalite` varchar(20) NOT NULL,
  `situation_matrimoniale` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`id`, `matricule`, `id_departement`, `id_licence`, `id_startup`, `id_contact`, `date_inscription`, `nom`, `prenom`, `sexe`, `date_naissance`, `lieu_naissance`, `nom_pere`, `nom_mere`, `nationalite`, `situation_matrimoniale`) VALUES
(1, 'ETD210001', 1, 4, NULL, 1, '2021-10-06', 'Kouyaté', 'Mariam', 'F', '2004-09-12', 'Faranah', 'Lansana Kouyaté', 'Aminata Kouyaté', 'Guinéenne', 'Célibataire'),
(2, 'ETD210002', 1, 4, NULL, 2, '2021-10-07', 'Sow', 'Aminata', 'M', '2003-12-25', 'Boké', 'Oumar Barry', 'Hawa Barry', 'Guinéenne', 'Célibataire'),
(3, 'ETD210003', 1, 4, NULL, 3, '2021-10-08', 'Diallo', 'Sira', 'F', '2004-02-14', 'Dalaba', 'Mamadou Diallo', 'Sira Bah', 'Guinéenne', 'Célibataire'),
(4, 'ETD210004', 2, 4, NULL, 4, '2021-09-01', 'Seck', 'Modou', 'M', '2003-10-30', 'Louga', 'El Hadji Seck', 'Mame Seck', 'Sénégalais', 'Célibataire'),
(5, 'ETD210005', 2, 4, NULL, 5, '2021-09-01', 'Camara', 'Awa', 'F', '2004-08-05', 'Fatick', 'Oumar Camara', 'Sira Camara', 'Sénégalaise', 'Célibataire'),
(6, 'ETD210006', 2, 4, NULL, 6, '2021-09-01', 'Gaye', 'Alioune', 'M', '2001-05-28', 'Mamou', 'Lansana Cissé', 'Aissatou Cissé', 'Guinéenne', 'Célibataire'),
(7, 'ETD220001', 1, 4, NULL, 7, '2022-10-01', 'Diallo', 'Mamadou', 'M', '2003-05-15', 'Conakry', 'Alpha Diallo', 'Fatou Diallo', 'Guinéenne', 'Célibataire'),
(8, 'ETD220002', 1, 4, NULL, NULL, '2022-10-02', 'Camara', 'Aissatou', 'F', '2004-07-22', 'Kindia', 'Ibrahima Camara', 'Saran Camara', 'Guinéenne', 'Célibataire'),
(9, 'ETD220003', 1, 4, NULL, NULL, '2022-10-03', 'Bah', 'Ousmane', 'M', '2003-11-10', 'Labé', 'Mory Bah', 'Kadiatou Bah', 'Guinéenne', 'Célibataire'),
(10, 'ETD220004', 1, 4, NULL, NULL, '2022-10-04', 'Sylla', 'Fatoumata', 'F', '2004-03-05', 'Mamou', 'Boubacar Sylla', 'Mariam Sylla', 'Guinéenne', 'Célibataire'),
(11, 'ETD220005', 1, 4, NULL, NULL, '2022-10-05', 'Keita', 'Ibrahima', 'M', '2003-06-18', 'Kankan', 'Sekou Keita', 'Nafissatou Keita', 'Guinéenne', 'Célibataire'),
(12, 'ETD220006', 2, 4, NULL, NULL, '2022-09-01', 'Diallo', 'Aminata', 'F', '2004-05-10', 'Dakar', 'Mamadou Diallo', 'Fatou Diallo', 'Sénégalaise', 'Célibataire'),
(13, 'ETD220007', 2, 4, NULL, NULL, '2022-09-01', 'Ba', 'Moussa', 'M', '2003-11-20', 'Thiès', 'Ibrahima Ba', 'Mariam Ba', 'Sénégalais', 'Célibataire'),
(14, 'ETD220008', 2, 4, NULL, NULL, '2022-09-01', 'Ndoye', 'Fatou', 'F', '2004-03-15', 'Saint-Louis', 'Ousmane Ndoye', 'Aissatou Ndoye', 'Sénégalaise', 'Célibataire'),
(15, 'ETD220009', 2, 4, NULL, NULL, '2022-09-01', 'Fall', 'Ibrahima', 'M', '2003-07-18', 'Kaolack', 'Abdou Fall', 'Sokhna Fall', 'Sénégalais', 'Célibataire'),
(16, 'ETD220010', 2, 4, NULL, NULL, '2022-09-01', 'Sarr', 'Khadija', 'F', '2004-09-25', 'Ziguinchor', 'Mamadou Sarr', 'Binta Sarr', 'Sénégalaise', 'Célibataire'),
(17, 'ETD220011', 2, 4, NULL, NULL, '2022-09-01', 'Gaye', 'Alioune', 'M', '2003-06-08', 'Diourbel', 'Cheikh Gaye', 'Ndeye Gaye', 'Sénégalais', 'Célibataire'),
(18, 'ETD220012', 2, 4, NULL, NULL, '2022-09-01', 'Diop', 'Marie', 'F', '2004-12-12', 'Kolda', 'Amadou Diop', 'Seynabou Diop', 'Sénégalaise', 'Célibataire'),
(19, 'ETD220013', 3, 3, NULL, NULL, '2022-09-01', 'Conté', 'Sékou', 'M', '2004-10-25', 'Kouroussa', 'Lamine Conté', 'Bintou Diallo', 'Guinéenne', 'Célibataire'),
(20, 'ETD220014', 3, 3, NULL, NULL, '2022-09-01', 'Kourouma', 'Nafissatou', 'F', '2004-11-18', 'Macenta', 'Moussa Kourouma', 'Aminata Bangoura', 'Guinéenne', 'Célibataire'),
(21, 'ETD220015', 4, 3, NULL, NULL, '2022-09-01', 'Sylla', 'Ali', 'M', '2004-03-14', 'Boké', 'Amadou Sylla', 'Hawa Kaba', 'Guinéenne', 'Célibataire'),
(22, 'ETD220016', 4, 3, NULL, NULL, '2022-09-01', 'Dramé', 'Hawa', 'F', '2004-06-29', 'Faranah', 'Elhadj Dramé', 'Fatoumata Condé', 'Guinéenne', 'Célibataire'),
(23, 'ETD220017', 4, 3, NULL, NULL, '2022-09-01', 'Touré', 'Ibrahima', 'M', '2004-01-23', 'Dabola', 'Sekou Touré', 'Mariam Barry', 'Guinéenne', 'Veuf(ve)'),
(24, 'ETD220018', 4, 3, NULL, NULL, '2022-09-01', 'Condé', 'Aissatou', 'F', '2004-09-17', 'Kankan', 'Moussa Condé', 'Kadija Keita', 'Guinéenne', 'Célibataire'),
(25, 'ETD230001', 1, 3, NULL, NULL, '2023-10-01', 'Barry', 'Saliou', 'M', '2002-04-12', 'Conakry', 'Abdoulaye Barry', 'Hadja Barry', 'Guinéenne', 'Célibataire'),
(26, 'ETD230002', 1, 3, NULL, NULL, '2023-10-02', 'Sow', 'Mariam', 'F', '2003-08-19', 'Boké', 'Ibrahima Sow', 'Aissata Sow', 'Guinéenne', 'Célibataire'),
(27, 'ETD230003', 1, 3, NULL, NULL, '2023-10-03', 'Conte', 'Lamine', 'M', '2002-09-25', 'Faranah', 'Mamadou Conte', 'Aminata Conte', 'Guinéenne', 'Célibataire'),
(28, 'ETD230004', 1, 3, NULL, NULL, '2023-10-04', 'Kaba', 'Nene', 'F', '2003-12-30', 'N’Zérékoré', 'Ousmane Kaba', 'Fatimatou Kaba', 'Guinéenne', 'Célibataire'),
(29, 'ETD230005', 1, 3, NULL, NULL, '2023-10-05', 'Diallo', 'Abdou', 'M', '2002-07-14', 'Coyah', 'Moussa Diallo', 'Binta Diallo', 'Guinéenne', 'Célibataire'),
(30, 'ETD230006', 2, 3, NULL, NULL, '2023-09-01', 'Camara', 'Mohamed', 'M', '2002-08-05', 'Dakar', 'Oumar Camara', 'Aissatou Camara', 'Sénégalais', 'Célibataire'),
(31, 'ETD230007', 2, 3, NULL, NULL, '2023-09-01', 'Ndiaye', 'Awa', 'F', '2003-04-22', 'Kaolack', 'Moussa Ndiaye', 'Fatou Ndiaye', 'Sénégalaise', 'Célibataire'),
(32, 'ETD230008', 2, 3, NULL, NULL, '2023-09-01', 'Faye', 'Serigne', 'M', '2002-02-18', 'Thiès', 'Cheikh Faye', 'Mame Faye', 'Sénégalais', 'Célibataire'),
(33, 'ETD230009', 2, 3, NULL, NULL, '2023-09-01', 'Sene', 'Ndeye', 'F', '2003-10-30', 'Saint-Louis', 'Ibrahima Sene', 'Seynabou Sene', 'Sénégalaise', 'Célibataire'),
(34, 'ETD230010', 2, 3, NULL, NULL, '2023-09-01', 'Kane', 'Alpha', 'M', '2002-06-14', 'Ziguinchor', 'Mamadou Kane', 'Awa Kane', 'Sénégalais', 'Célibataire'),
(35, 'ETD230011', 2, 3, NULL, NULL, '2023-09-01', 'Mboup', 'Mame', 'F', '2003-12-07', 'Diourbel', 'El Hadji Mboup', 'Aissatou Mboup', 'Sénégalaise', 'Célibataire'),
(36, 'ETD230012', 2, 3, NULL, NULL, '2023-09-01', 'Barry', 'Ibrahima', 'M', '2002-05-19', 'Kolda', 'Ousmane Barry', 'Sira Barry', 'Sénégalais', 'Célibataire'),
(37, 'ETD230013', 2, 3, NULL, NULL, '2023-09-01', 'Seck', 'Fatima', 'F', '2003-09-14', 'Dakar', 'Abdou Seck', 'Ndeye Seck', 'Sénégalaise', 'Célibataire'),
(38, 'ETD230014', 2, 3, NULL, NULL, '2023-09-01', 'Gomis', 'Jean', 'M', '2002-11-25', 'Thiès', 'Pierre Gomis', 'Marie Gomis', 'Sénégalais', 'Célibataire'),
(39, 'ETD230015', 3, 3, NULL, NULL, '2023-09-01', 'Diallo', 'Mamadou', 'M', '2004-05-10', 'Conakry', 'Alpha Diallo', 'Fatoumata Bah', 'Guinéenne', 'Célibataire'),
(40, 'ETD230016', 3, 3, NULL, NULL, '2023-09-01', 'Camara', 'Aissatou', 'F', '2004-07-15', 'Kankan', 'Ibrahima Camara', 'Mariam Camara', 'Guinéenne', 'Célibataire'),
(41, 'ETD230017', 3, 3, NULL, NULL, '2023-09-01', 'Barry', 'Ibrahima', 'M', '2004-08-20', 'Kindia', 'Ousmane Barry', 'Hawa Diallo', 'Guinéenne', 'Marié'),
(42, 'ETD230018', 3, 3, NULL, NULL, '2023-09-01', 'Bah', 'Mariama', 'F', '2004-06-11', 'Labé', 'Elhadj Bah', 'Mariam Sow', 'Guinéenne', 'Célibataire'),
(43, 'ETD230019', 3, 3, NULL, NULL, '2023-09-01', 'Sylla', 'Mohamed', 'M', '2004-04-23', 'Mamou', 'Fodé Sylla', 'Aissatou Keita', 'Guinéenne', 'Divorcé'),
(44, 'ETD230020', 3, 3, NULL, NULL, '2023-09-01', 'Keita', 'Fatoumata', 'F', '2004-09-30', 'Nzérékoré', 'Sekou Keita', 'Kadija Sy', 'Guinéenne', 'Célibataire'),
(45, 'ETD230021', 3, 3, NULL, NULL, '2023-09-01', 'Soumah', 'Moussa', 'M', '2004-03-05', 'Boké', 'Amadou Soumah', 'Djenabou Camara', 'Guinéenne', 'Marié'),
(46, 'ETD230022', 3, 3, NULL, NULL, '2023-09-01', 'Touré', 'Hawa', 'F', '2004-12-19', 'Faranah', 'Aboubacar Touré', 'Saran Cissé', 'Guinéenne', 'Célibataire'),
(47, 'ETD230023', 3, 3, NULL, NULL, '2023-09-01', 'Kaba', 'Lansana', 'M', '2004-02-14', 'Dabola', 'Mamadou Kaba', 'Fatoumata Condé', 'Guinéenne', 'Veuf'),
(48, 'ETD230024', 4, 3, NULL, NULL, '2023-09-01', 'Soumah', 'Aboubacar', 'M', '2004-02-15', 'Conakry', 'Mamadou Soumah', 'Fatoumata Camara', 'Guinéenne', 'Célibataire'),
(49, 'ETD230025', 4, 3, NULL, NULL, '2023-09-01', 'Keita', 'Aminata', 'F', '2004-05-20', 'Kankan', 'Sekou Keita', 'Mariam Diallo', 'Guinéenne', 'Marié(e)'),
(50, 'ETD230026', 4, 3, NULL, NULL, '2023-09-01', 'Camara', 'Moussa', 'M', '2004-08-10', 'Kindia', 'Ousmane Camara', 'Aissatou Sy', 'Guinéenne', 'Célibataire'),
(51, 'ETD230027', 4, 3, NULL, NULL, '2023-09-01', 'Bah', 'Fatoumata', 'F', '2004-11-25', 'Labé', 'Alpha Bah', 'Mariama Cissé', 'Guinéenne', 'Divorcé(e)'),
(52, 'ETD230028', 4, 3, NULL, NULL, '2023-09-01', 'Barry', 'Oumar', 'M', '2004-07-07', 'Mamou', 'Mamadou Barry', 'Kadija Sow', 'Guinéenne', 'Célibataire'),
(53, 'ETD230029', 4, 3, NULL, NULL, '2023-09-01', 'Diallo', 'Mariama', 'F', '2004-04-19', 'Nzérékoré', 'Ibrahima Diallo', 'Saran Camara', 'Guinéenne', 'Marié(e)'),
(54, 'ETD240001', 1, 2, NULL, NULL, '2024-10-01', 'Touré', 'Aliou', 'M', '2001-03-11', 'Conakry', 'Sékou Touré', 'Fanta Touré', 'Guinéenne', 'Célibataire'),
(55, 'ETD240002', 1, 2, NULL, NULL, '2024-10-02', 'Bangoura', 'Kadija', 'F', '2002-06-23', 'Kindia', 'Mamadou Bangoura', 'Nene Bangoura', 'Guinéenne', 'Célibataire'),
(56, 'ETD240003', 1, 2, NULL, NULL, '2024-10-03', 'Soumah', 'Mory', 'M', '2001-09-17', 'Kankan', 'Alpha Soumah', 'Mariam Soumah', 'Guinéenne', 'Célibataire'),
(57, 'ETD240004', 1, 2, NULL, NULL, '2024-10-04', 'Dramé', 'Bintou', 'F', '2002-11-09', 'Labé', 'Aboubacar Dramé', 'Kadiatou Dramé', 'Guinéenne', 'Célibataire'),
(58, 'ETD240005', 1, 2, NULL, NULL, '2024-10-05', 'Cissé', 'Mamadou', 'M', '2001-05-28', 'Mamou', 'Lansana Cissé', 'Aissatou Cissé', 'Guinéenne', 'Célibataire'),
(59, 'ETD240006', 2, 2, NULL, NULL, '2024-09-01', 'Sy', 'Moussa', 'M', '2001-03-10', 'Dakar', 'Ousmane Sy', 'Aissatou Sy', 'Sénégalais', 'Marié'),
(60, 'ETD240007', 2, 2, NULL, NULL, '2024-09-01', 'Diakhate', 'Mame Diarra', 'F', '2002-07-20', 'Kaolack', 'Mamadou Diakhate', 'Sokhna Diakhate', 'Sénégalaise', 'Célibataire'),
(61, 'ETD240008', 2, 2, NULL, NULL, '2024-09-01', 'Ly', 'Babacar', 'M', '2001-12-18', 'Saint-Louis', 'Cheikh Ly', 'Fatou Ly', 'Sénégalais', 'Célibataire'),
(62, 'ETD240009', 2, 2, NULL, NULL, '2024-09-01', 'Ndaw', 'Sophie', 'F', '2002-04-15', 'Ziguinchor', 'Ibrahima Ndaw', 'Mame Ndaw', 'Sénégalaise', 'Célibataire'),
(63, 'ETD240010', 2, 2, NULL, NULL, '2024-09-01', 'Toure', 'Abdou', 'M', '2001-09-25', 'Dakar', 'Boubacar Toure', 'Mariama Toure', 'Sénégalais', 'Célibataire'),
(64, 'ETD240011', 3, 2, NULL, NULL, '2024-09-01', 'Baldé', 'Moussa', 'M', '2003-05-10', 'Conakry', 'Elhadj Baldé', 'Kadija Sow', 'Guinéenne', 'Célibataire'),
(65, 'ETD240012', 3, 2, NULL, NULL, '2024-09-01', 'Cissé', 'Aissatou', 'F', '2003-07-15', 'Kankan', 'Sekou Cissé', 'Fatoumata Barry', 'Guinéenne', 'Marié(e)'),
(66, 'ETD240013', 3, 2, NULL, NULL, '2024-09-01', 'Condé', 'Mamadou', 'M', '2003-08-20', 'Kindia', 'Moussa Condé', 'Mariama Keita', 'Guinéenne', 'Célibataire'),
(67, 'ETD240014', 3, 2, NULL, NULL, '2024-09-01', 'Dramé', 'Nafissatou', 'F', '2003-06-11', 'Labé', 'Mamadou Dramé', 'Aissatou Touré', 'Guinéenne', 'Marié(e)'),
(68, 'ETD240015', 3, 2, NULL, NULL, '2024-09-01', 'Doumbouya', 'Alpha', 'M', '2003-04-23', 'Mamou', 'Ibrahima Doumbouya', 'Sira Camara', 'Guinéenne', 'Divorcé(e)'),
(69, 'ETD240016', 3, 2, NULL, NULL, '2024-09-01', 'Fofana', 'Fatou', 'F', '2003-09-30', 'Nzérékoré', 'Sekou Fofana', 'Hawa Diallo', 'Guinéenne', 'Célibataire'),
(70, 'ETD240017', 3, 2, NULL, NULL, '2024-09-01', 'Koïta', 'Oumar', 'M', '2003-03-05', 'Boké', 'Ousmane Koïta', 'Mariama Soumah', 'Guinéenne', 'Veuf(ve)'),
(71, 'ETD240018', 4, 2, NULL, NULL, '2024-09-01', 'Djalo', 'Mamadou', 'M', '2003-04-10', 'Conakry', 'Oumar Djalo', 'Hawa Bah', 'Guinéenne', 'Célibataire'),
(72, 'ETD240019', 4, 2, NULL, NULL, '2024-09-01', 'Keita', 'Fatou', 'F', '2003-05-15', 'Kankan', 'Sekou Keita', 'Sira Camara', 'Guinéenne', 'Marié(e)'),
(73, 'ETD240020', 4, 2, NULL, NULL, '2024-09-01', 'Barry', 'Ibrahima', 'M', '2003-07-22', 'Kindia', 'Mamadou Barry', 'Fatoumata Cissé', 'Guinéenne', 'Célibataire'),
(74, 'ETD240021', 4, 2, NULL, NULL, '2024-09-01', 'Sylla', 'Aissatou', 'F', '2003-02-14', 'Labé', 'Ousmane Sylla', 'Kadija Sow', 'Guinéenne', 'Divorcé(e)'),
(75, 'ETD240022', 4, 2, NULL, NULL, '2024-09-01', 'Bah', 'Mohamed', 'M', '2003-06-30', 'Mamou', 'Elhadj Bah', 'Mariam Cissé', 'Guinéenne', 'Célibataire'),
(76, 'ETD240023', 4, 2, NULL, NULL, '2024-09-01', 'Camara', 'Sira', 'F', '2003-08-19', 'Nzérékoré', 'Mamadou Camara', 'Fatoumata Diallo', 'Guinéenne', 'Marié(e)'),
(77, 'ETD240024', 4, 2, NULL, NULL, '2024-09-01', 'Touré', 'Ali', 'M', '2003-03-24', 'Boké', 'Amadou Touré', 'Hawa Condé', 'Guinéenne', 'Célibataire'),
(78, 'ETD240025', 4, 2, NULL, NULL, '2024-09-01', 'Condé', 'Mariama', 'F', '2003-09-10', 'Faranah', 'Sekou Condé', 'Saran Camara', 'Guinéenne', 'Célibataire'),
(79, 'ETD250001', 1, 1, NULL, NULL, '2025-10-01', 'Diallo', 'Fatima', 'F', '2000-07-07', 'Conakry', 'Mamadou Diallo', 'Aissatou Diallo', 'Guinéenne', 'Mariée'),
(80, 'ETD250002', 1, 1, NULL, NULL, '2025-10-02', 'Keita', 'Sory', 'M', '2001-10-14', 'Faranah', 'Ibrahima Keita', 'Fatoumata Keita', 'Guinéenne', 'Célibataire'),
(81, 'ETD250003', 1, 1, NULL, NULL, '2025-10-03', 'Bah', 'Mamadou', 'M', '2000-12-05', 'Labé', 'Oumar Bah', 'Kadija Bah', 'Guinéenne', 'Célibataire'),
(82, 'ETD250004', 1, 1, NULL, NULL, '2025-10-04', 'Camara', 'Nafissatou', 'F', '2001-04-19', 'Kindia', 'Sékou Camara', 'Mariam Camara', 'Guinéenne', 'Célibataire'),
(83, 'ETD250005', 1, 1, NULL, NULL, '2025-10-05', 'Sylla', 'Ibrahima', 'M', '2000-06-30', 'Kankan', 'Mory Sylla', 'Fatou Sylla', 'Guinéenne', 'Célibataire'),
(84, 'ETD250006', 2, 1, NULL, NULL, '2025-09-01', 'Wade', 'Cheikh', 'M', '2000-02-10', 'Dakar', 'Mamadou Wade', 'Aissatou Wade', 'Sénégalais', 'Marié'),
(85, 'ETD250007', 2, 1, NULL, NULL, '2025-09-01', 'Dieng', 'Astou', 'F', '2001-06-22', 'Thiès', 'Alioune Dieng', 'Sokhna Dieng', 'Sénégalaise', 'Célibataire'),
(86, 'ETD250008', 2, 1, NULL, NULL, '2025-09-01', 'Lamine', 'Serigne', 'M', '2000-11-18', 'Kaolack', 'Omar Lamine', 'Mame Lamine', 'Sénégalais', 'Célibataire'),
(87, 'ETD250009', 2, 1, NULL, NULL, '2025-09-01', 'Sow', 'Aminata', 'F', '2001-03-30', 'Saint-Louis', 'Boubacar Sow', 'Fatima Sow', 'Sénégalaise', 'Mariée'),
(88, 'ETD250010', 2, 1, NULL, NULL, '2025-09-01', 'Diao', 'Mamadou', 'M', '2000-08-14', 'Ziguinchor', 'El Hadj Diao', 'Seynabou Diao', 'Sénégalais', 'Célibataire'),
(89, 'ETD250011', 2, 1, NULL, NULL, '2025-09-01', 'Ba', 'Fatou', 'F', '2001-12-07', 'Diourbel', 'Abdou Ba', 'Mariama Ba', 'Sénégalaise', 'Célibataire'),
(90, 'ETD250012', 2, 1, NULL, NULL, '2025-09-01', 'Diagne', 'Moussa', 'M', '2000-05-19', 'Kolda', 'Cheikh Diagne', 'Adja Diagne', 'Sénégalais', 'Célibataire'),
(91, 'ETD250013', 2, 1, NULL, NULL, '2025-09-01', 'Ngom', 'Ndeye', 'F', '2001-09-14', 'Dakar', 'Malick Ngom', 'Seynabou Ngom', 'Sénégalaise', 'Célibataire'),
(92, 'ETD250014', 2, 1, NULL, NULL, '2025-09-01', 'Fall', 'Jean', 'M', '2000-11-25', 'Thiès', 'Pierre Fall', 'Marie Fall', 'Sénégalais', 'Marié'),
(93, 'ETD250015', 2, 1, NULL, NULL, '2025-09-01', 'Fofana', 'Salif', 'M', '2001-02-17', 'Kaolack', 'Abdoulaye Fofana', 'Fatimata Fofana', 'Sénégalais', 'Célibataire'),
(94, 'ETD250016', 3, 1, NULL, NULL, '2025-09-01', 'Djalo', 'Lamine', 'M', '2002-05-10', 'Conakry', 'Ibrahima Djalo', 'Saran Kaba', 'Guinéenne', 'Célibataire'),
(95, 'ETD250017', 3, 1, NULL, NULL, '2025-09-01', 'Sylla', 'Néné', 'F', '2002-07-15', 'Kankan', 'Moussa Sylla', 'Hawa Keita', 'Guinéenne', 'Marié(e)'),
(96, 'ETD250018', 3, 1, NULL, NULL, '2025-09-01', 'Keita', 'Mohamed', 'M', '2002-08-20', 'Kindia', 'Mamadou Keita', 'Aissatou Barry', 'Guinéenne', 'Célibataire'),
(97, 'ETD250019', 3, 1, NULL, NULL, '2025-09-01', 'Barry', 'Sira', 'F', '2002-06-11', 'Labé', 'Elhadj Barry', 'Fatoumata Cissé', 'Guinéenne', 'Marié(e)'),
(98, 'ETD250020', 3, 1, NULL, NULL, '2025-09-01', 'Camara', 'Alpha', 'M', '2002-04-23', 'Mamou', 'Ousmane Camara', 'Mariama Diallo', 'Guinéenne', 'Divorcé(e)'),
(99, 'ETD250021', 3, 1, NULL, NULL, '2025-09-01', 'Bah', 'Fatimatou', 'F', '2002-09-30', 'Nzérékoré', 'Sekou Bah', 'Mariam Cissé', 'Guinéenne', 'Célibataire'),
(100, 'ETD250022', 3, 1, NULL, NULL, '2025-09-01', 'Touré', 'Ibrahima', 'M', '2002-03-05', 'Boké', 'Amadou Touré', 'Djenabou Condé', 'Guinéenne', 'Veuf(ve)'),
(101, 'ETD250023', 3, 1, NULL, NULL, '2025-09-01', 'Diarra', 'Aissatou', 'F', '2002-12-19', 'Faranah', 'Mamadou Diarra', 'Hawa Camara', 'Guinéenne', 'Célibataire'),
(102, 'ETD250024', 4, 1, NULL, NULL, '2025-09-01', 'Djalo', 'Oumar', 'M', '2002-01-15', 'Conakry', 'Mamadou Djalo', 'Fatoumata Bah', 'Guinéenne', 'Célibataire'),
(103, 'ETD250025', 4, 1, NULL, NULL, '2025-09-01', 'Keita', 'Sira', 'F', '2002-03-20', 'Kankan', 'Sekou Keita', 'Mariam Camara', 'Guinéenne', 'Marié(e)'),
(104, 'ETD250026', 4, 1, NULL, NULL, '2025-09-01', 'Barry', 'Mohamed', 'M', '2002-07-05', 'Kindia', 'Ousmane Barry', 'Aissatou Sy', 'Guinéenne', 'Célibataire'),
(105, 'ETD250027', 4, 1, NULL, NULL, '2025-09-01', 'Camara', 'Fatoumata', 'F', '2002-09-14', 'Labé', 'Mamadou Camara', 'Kadija Sow', 'Guinéenne', 'Divorcé(e)'),
(106, 'ETD250028', 4, 1, NULL, NULL, '2025-09-01', 'Sylla', 'Ali', 'M', '2002-12-25', 'Mamou', 'Elhadj Sylla', 'Mariama Condé', 'Guinéenne', 'Célibataire');

-- --------------------------------------------------------

--
-- Structure de la table `exp_profession`
--

CREATE TABLE `exp_profession` (
  `id` int(11) NOT NULL,
  `id_experience` int(11) NOT NULL,
  `id_contact` int(11) NOT NULL,
  `entreprise` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `faculte`
--

CREATE TABLE `faculte` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `faculte`
--

INSERT INTO `faculte` (`id`, `nom`) VALUES
(1, 'FACULTE DE GENIE'),
(2, 'FACULTE DE SCIENCE ECONOMIQUE ET GESTION');

-- --------------------------------------------------------

--
-- Structure de la table `formation`
--

CREATE TABLE `formation` (
  `id` int(11) NOT NULL,
  `titre` varchar(50) DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `prix` decimal(10,2) DEFAULT NULL,
  `lieu` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `formations`
--

CREATE TABLE `formations` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `localisation` varchar(255) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `prerequis` text NOT NULL,
  `email_contact` varchar(255) NOT NULL,
  `image` varchar(512) DEFAULT NULL,
  `id_entreprise` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `formations`
--

INSERT INTO `formations` (`id`, `titre`, `description`, `localisation`, `date_debut`, `date_fin`, `prerequis`, `email_contact`, `image`, `id_entreprise`) VALUES
(2, 'fsmdfjhqsldfj', 'qsldfjsldkf', 'qsdfljqsdfk', '2025-05-17', '2025-05-23', 'qdsfkjh', 'dfza1998@gmail.com', 'uploads/formations/1746626376503-Capture dâÃ©cran (1).png', 15);

-- --------------------------------------------------------

--
-- Structure de la table `inscrip_etudiant`
--

CREATE TABLE `inscrip_etudiant` (
  `id` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `matricule` varchar(10) NOT NULL,
  `email` varchar(30) NOT NULL,
  `mot_de_passe` varchar(30) NOT NULL,
  `user` varchar(30) NOT NULL,
  `code_confirmation` varchar(255) DEFAULT NULL,
  `email_confirme` tinyint(1) DEFAULT 0,
  `photo_profil` varchar(100) DEFAULT '/uploads/etudiants/profil-1744989283414-306981581-1745796092322-109630191.jpeg',
  `photo_couverture` varchar(100) DEFAULT '/uploads/etudiants/couverture-1744989301155-889501160-1745796102264-91218750.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `inscrip_etudiant`
--

INSERT INTO `inscrip_etudiant` (`id`, `id_etudiant`, `matricule`, `email`, `mot_de_passe`, `user`, `code_confirmation`, `email_confirme`, `photo_profil`, `photo_couverture`) VALUES
(56, 6, 'ETD210006', 'kamanoismael684@gmail.com', '0000', '000', NULL, 1, '/uploads/etudiants/profil-1744989283414-306981581.jpeg', '/uploads/etudiants/couverture-1744989301155-889501160.jpg'),
(59, 2, 'ETD210002', 'servicesdiecoles@gmail.com', '111', '111', NULL, 1, '/uploads/etudiants/Screenshot_20250422-090102-1745405119978-800042949-1745812148609-803020429.png', '/uploads/etudiants/AMI-1746058547467-722918725.PNG'),
(60, 3, 'ETD210003', 'abdourahamanekaba23@gmail.com', '888', '888', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `licence`
--

CREATE TABLE `licence` (
  `id` int(11) NOT NULL,
  `nom` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `licence`
--

INSERT INTO `licence` (`id`, `nom`) VALUES
(1, 'Licence 1'),
(2, 'Licence 2'),
(3, 'Licence 3'),
(4, 'Licence 4');

-- --------------------------------------------------------

--
-- Structure de la table `matiere`
--

CREATE TABLE `matiere` (
  `id` int(11) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `id_licence` int(11) NOT NULL,
  `id_departement` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `matiere`
--

INSERT INTO `matiere` (`id`, `nom`, `id_licence`, `id_departement`) VALUES
(1, 'Intelligence Artificielle', 4, 1),
(2, 'Cybersécurité', 4, 1),
(3, 'Blockchain', 4, 1),
(4, 'DevOps', 4, 1),
(5, 'Virtualisation', 4, 1),
(6, 'Intelligence d’Affaires', 4, 2),
(7, 'Cloud Computing', 4, 2),
(8, 'E-commerce', 4, 2),
(9, 'Innovation technologique', 4, 2),
(10, 'Smart Data', 4, 2),
(11, 'Analyse financière', 3, 3),
(12, 'Marchés financiers', 3, 3),
(13, 'Théorie des jeux', 3, 3),
(14, 'Économétrie', 3, 3),
(15, 'Politique monétaire', 3, 3),
(16, 'Analyse financière', 3, 4),
(17, 'Droit fiscal', 3, 4),
(18, 'Comptabilité internationale', 3, 4),
(19, 'Gestion de trésorerie', 3, 4),
(20, 'Normes IFRS', 3, 4),
(21, 'Gestion de projet IT', 3, 1),
(22, 'Développement Web', 3, 1),
(23, 'Big Data', 3, 1),
(24, 'Machine Learning', 3, 1),
(25, 'IoT', 3, 1),
(26, 'Audit des SI', 3, 2),
(27, 'Sécurité informatique', 3, 2),
(28, 'Droit du numérique', 3, 2),
(29, 'Marketing digital', 3, 2),
(30, 'Gestion des risques IT', 3, 2),
(31, 'Comptabilité analytique', 2, 3),
(32, 'Finance publique', 2, 3),
(33, 'Économie internationale', 2, 3),
(34, 'Fiscalité des entreprises', 2, 3),
(35, 'Gestion budgétaire', 2, 3),
(36, 'Comptabilité financière', 2, 4),
(37, 'Gestion des coûts', 2, 4),
(38, 'Audit et contrôle interne', 2, 4),
(39, 'Fiscalité des entreprises', 2, 4),
(40, 'Logiciels comptables', 2, 4),
(41, 'Mathématiques discrètes', 2, 1),
(42, 'Télécommunications', 2, 1),
(43, 'Sécurité des réseaux', 2, 1),
(44, 'Administration système', 2, 1),
(45, 'Cloud Computing', 2, 1),
(46, 'Finance pour ingénieurs', 2, 2),
(47, 'Analyse de données', 2, 2),
(48, 'Gestion de projet', 2, 2),
(49, 'ERP et SAP', 2, 2),
(50, 'Systèmes décisionnels', 2, 2),
(51, 'Microéconomie', 1, 3),
(52, 'Macroéconomie', 1, 3),
(53, 'Statistiques appliquées', 1, 3),
(54, 'Comptabilité générale', 1, 3),
(55, 'Économie du développement', 1, 3),
(56, 'Introduction à la comptabilité', 1, 4),
(57, 'Mathématiques financières', 1, 4),
(58, 'Droit des affaires', 1, 4),
(59, 'Statistiques appliquées', 1, 4),
(60, 'Économie générale', 1, 4),
(61, 'Algorithmique', 1, 1),
(62, 'Programmation Java', 1, 1),
(63, 'Base de données', 1, 1),
(64, 'Systèmes d’exploitation', 1, 1),
(65, 'Réseaux informatiques', 1, 1),
(66, 'Systèmes d’information', 1, 2),
(67, 'Programmation Python', 1, 2),
(68, 'Conception UML', 1, 2),
(69, 'Gestion de base de données', 1, 2),
(70, 'Développement Web', 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `id_etudiant` int(11) DEFAULT NULL,
  `id_entreprise` int(11) DEFAULT NULL,
  `expediteur` enum('etudiant','entreprise') DEFAULT NULL,
  `contenu` text NOT NULL,
  `date_envoi` datetime DEFAULT current_timestamp(),
  `statut` tinyint(1) NOT NULL DEFAULT 0 CHECK (`statut` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `note`
--

CREATE TABLE `note` (
  `id` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `id_matiere` int(11) NOT NULL,
  `moyenne` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `note`
--

INSERT INTO `note` (`id`, `id_etudiant`, `id_matiere`, `moyenne`) VALUES
(1, 7, 1, 7.00),
(2, 7, 2, 8.00),
(3, 7, 3, 6.00),
(4, 7, 4, 7.00),
(5, 7, 5, 6.00),
(6, 8, 1, 6.00),
(7, 8, 2, 7.00),
(8, 8, 3, 8.00),
(9, 8, 4, 5.00),
(10, 8, 5, 7.00),
(11, 9, 1, 5.00),
(12, 9, 2, 7.00),
(13, 9, 3, 6.00),
(14, 9, 4, 8.00),
(15, 9, 5, 6.00),
(16, 10, 1, 8.00),
(17, 10, 2, 6.00),
(18, 10, 3, 7.00),
(19, 10, 4, 6.00),
(20, 10, 5, 8.00),
(21, 11, 1, 6.00),
(22, 11, 2, 7.00),
(23, 11, 3, 5.00),
(24, 11, 4, 7.00),
(25, 11, 5, 8.00),
(26, 1, 1, 8.00),
(27, 1, 2, 9.00),
(28, 1, 3, 7.00),
(29, 1, 4, 6.00),
(30, 1, 5, 7.00),
(31, 2, 1, 7.00),
(32, 2, 2, 6.00),
(33, 2, 3, 8.00),
(34, 2, 4, 7.00),
(35, 2, 5, 5.00),
(36, 3, 1, 7.00),
(37, 3, 2, 7.00),
(38, 3, 3, 6.00),
(39, 3, 4, 8.00),
(40, 3, 5, 6.00),
(41, 7, 21, 7.50),
(42, 7, 22, 8.20),
(43, 7, 23, 6.50),
(44, 7, 24, 7.80),
(45, 7, 25, 6.30),
(46, 8, 21, 6.70),
(47, 8, 22, 7.50),
(48, 8, 23, 8.30),
(49, 8, 24, 6.80),
(50, 8, 25, 7.00),
(51, 9, 21, 6.00),
(52, 9, 22, 7.20),
(53, 9, 23, 6.90),
(54, 9, 24, 8.10),
(55, 9, 25, 6.40),
(56, 10, 21, 8.10),
(57, 10, 22, 6.80),
(58, 10, 23, 7.60),
(59, 10, 24, 7.00),
(60, 10, 25, 8.50),
(61, 11, 21, 6.40),
(62, 11, 22, 7.00),
(63, 11, 23, 5.70),
(64, 11, 24, 7.50),
(65, 11, 25, 8.00),
(66, 1, 21, 8.20),
(67, 1, 22, 9.00),
(68, 1, 23, 7.40),
(69, 1, 24, 6.90),
(70, 1, 25, 7.80),
(71, 2, 21, 7.60),
(72, 2, 22, 6.90),
(73, 2, 23, 8.20),
(74, 2, 24, 7.00),
(75, 2, 25, 6.50),
(76, 3, 21, 7.40),
(77, 3, 22, 7.80),
(78, 3, 23, 6.60),
(79, 3, 24, 8.00),
(80, 3, 25, 6.90),
(81, 7, 41, 8.20),
(82, 7, 42, 7.50),
(83, 7, 43, 6.80),
(84, 7, 44, 8.30),
(85, 7, 45, 7.00),
(86, 8, 41, 6.50),
(87, 8, 42, 7.80),
(88, 8, 43, 6.00),
(89, 8, 44, 7.50),
(90, 8, 45, 8.10),
(91, 9, 41, 7.00),
(92, 9, 42, 6.80),
(93, 9, 43, 7.10),
(94, 9, 44, 7.50),
(95, 9, 45, 6.90),
(96, 10, 41, 7.80),
(97, 10, 42, 6.90),
(98, 10, 43, 7.30),
(99, 10, 44, 8.00),
(100, 10, 45, 7.20),
(101, 11, 41, 6.80),
(102, 11, 42, 7.00),
(103, 11, 43, 6.50),
(104, 11, 44, 7.30),
(105, 11, 45, 7.90),
(106, 1, 41, 7.90),
(107, 1, 42, 8.20),
(108, 1, 43, 6.70),
(109, 1, 44, 7.00),
(110, 1, 45, 7.60),
(111, 2, 41, 6.50),
(112, 2, 42, 7.30),
(113, 2, 43, 6.90),
(114, 2, 44, 6.80),
(115, 2, 45, 7.40),
(116, 3, 41, 7.30),
(117, 3, 42, 7.10),
(118, 3, 43, 7.40),
(119, 3, 44, 6.90),
(120, 3, 45, 7.20),
(121, 7, 61, 8.50),
(122, 7, 62, 7.30),
(123, 7, 63, 9.00),
(124, 7, 64, 7.50),
(125, 7, 65, 8.20),
(126, 8, 61, 7.20),
(127, 8, 62, 7.80),
(128, 8, 63, 8.50),
(129, 8, 64, 6.80),
(130, 8, 65, 7.40),
(131, 9, 61, 7.00),
(132, 9, 62, 6.80),
(133, 9, 63, 7.50),
(134, 9, 64, 8.00),
(135, 9, 65, 7.20),
(136, 10, 61, 8.10),
(137, 10, 62, 6.90),
(138, 10, 63, 7.80),
(139, 10, 64, 7.40),
(140, 10, 65, 8.30),
(141, 11, 61, 7.30),
(142, 11, 62, 8.00),
(143, 11, 63, 7.90),
(144, 11, 64, 7.00),
(145, 11, 65, 7.50),
(146, 1, 61, 7.70),
(147, 1, 62, 7.60),
(148, 1, 63, 8.30),
(149, 1, 64, 6.50),
(150, 1, 65, 7.90),
(151, 2, 61, 7.40),
(152, 2, 62, 6.70),
(153, 2, 63, 7.20),
(154, 2, 64, 7.80),
(155, 2, 65, 6.90),
(156, 3, 61, 6.90),
(157, 3, 62, 7.50),
(158, 3, 63, 6.80),
(159, 3, 64, 7.20),
(160, 3, 65, 8.00),
(161, 25, 21, 8.10),
(162, 25, 22, 7.50),
(163, 25, 23, 7.80),
(164, 25, 24, 8.30),
(165, 25, 25, 7.90),
(166, 26, 21, 7.70),
(167, 26, 22, 7.20),
(168, 26, 23, 8.00),
(169, 26, 24, 6.80),
(170, 26, 25, 7.50),
(171, 27, 21, 7.30),
(172, 27, 22, 8.10),
(173, 27, 23, 7.90),
(174, 27, 24, 7.40),
(175, 27, 25, 8.20),
(176, 28, 21, 7.60),
(177, 28, 22, 6.90),
(178, 28, 23, 7.50),
(179, 28, 24, 7.00),
(180, 28, 25, 7.30),
(181, 29, 21, 8.40),
(182, 29, 22, 7.90),
(183, 29, 23, 8.10),
(184, 29, 24, 8.00),
(185, 29, 25, 8.30),
(186, 25, 41, 6.80),
(187, 25, 42, 7.20),
(188, 25, 43, 7.40),
(189, 25, 44, 7.00),
(190, 25, 45, 6.90),
(191, 26, 41, 7.50),
(192, 26, 42, 7.10),
(193, 26, 43, 6.90),
(194, 26, 44, 7.20),
(195, 26, 45, 7.40),
(196, 27, 41, 7.00),
(197, 27, 42, 7.50),
(198, 27, 43, 7.30),
(199, 27, 44, 6.80),
(200, 27, 45, 7.60),
(201, 28, 41, 6.70),
(202, 28, 42, 6.90),
(203, 28, 43, 7.10),
(204, 28, 44, 7.00),
(205, 28, 45, 6.80),
(206, 29, 41, 7.90),
(207, 29, 42, 8.00),
(208, 29, 43, 7.70),
(209, 29, 44, 8.20),
(210, 29, 45, 7.80),
(211, 25, 61, 7.50),
(212, 25, 62, 6.80),
(213, 25, 63, 7.20),
(214, 25, 64, 7.00),
(215, 25, 65, 7.40),
(216, 26, 61, 6.90),
(217, 26, 62, 7.10),
(218, 26, 63, 7.50),
(219, 26, 64, 6.80),
(220, 26, 65, 7.30),
(221, 27, 61, 7.40),
(222, 27, 62, 6.90),
(223, 27, 63, 7.00),
(224, 27, 64, 7.20),
(225, 27, 65, 7.60),
(226, 28, 61, 7.00),
(227, 28, 62, 6.70),
(228, 28, 63, 7.20),
(229, 28, 64, 6.90),
(230, 28, 65, 7.10),
(231, 29, 61, 7.80),
(232, 29, 62, 7.50),
(233, 29, 63, 7.40),
(234, 29, 64, 8.00),
(235, 29, 65, 7.90),
(236, 54, 41, 6.50),
(237, 54, 42, 7.10),
(238, 54, 43, 6.80),
(239, 54, 44, 7.30),
(240, 54, 45, 7.00),
(241, 55, 41, 7.20),
(242, 55, 42, 6.90),
(243, 55, 43, 7.00),
(244, 55, 44, 7.50),
(245, 55, 45, 6.80),
(246, 56, 41, 7.00),
(247, 56, 42, 6.70),
(248, 56, 43, 6.80),
(249, 56, 44, 7.10),
(250, 56, 45, 6.90),
(251, 57, 41, 6.80),
(252, 57, 42, 7.20),
(253, 57, 43, 6.90),
(254, 57, 44, 6.60),
(255, 57, 45, 7.40),
(256, 58, 41, 7.40),
(257, 58, 42, 7.30),
(258, 58, 43, 7.00),
(259, 58, 44, 7.50),
(260, 58, 45, 7.20),
(261, 54, 61, 8.00),
(262, 54, 62, 7.50),
(263, 54, 63, 7.80),
(264, 54, 64, 7.20),
(265, 54, 65, 7.60),
(266, 55, 61, 7.90),
(267, 55, 62, 7.80),
(268, 55, 63, 8.00),
(269, 55, 64, 7.40),
(270, 55, 65, 7.50),
(271, 56, 61, 7.70),
(272, 56, 62, 7.30),
(273, 56, 63, 7.50),
(274, 56, 64, 7.60),
(275, 56, 65, 7.20),
(276, 57, 61, 8.10),
(277, 57, 62, 7.70),
(278, 57, 63, 7.40),
(279, 57, 64, 7.50),
(280, 57, 65, 7.80),
(281, 58, 61, 7.90),
(282, 58, 62, 7.60),
(283, 58, 63, 7.80),
(284, 58, 64, 7.20),
(285, 58, 65, 7.40),
(286, 79, 61, 4.90),
(287, 79, 62, 5.00),
(288, 79, 63, 5.30),
(289, 79, 64, 6.20),
(290, 79, 65, 4.80),
(291, 80, 61, 5.40),
(292, 80, 62, 6.00),
(293, 80, 63, 5.60),
(294, 80, 64, 6.10),
(295, 80, 65, 5.20),
(296, 81, 61, 4.20),
(297, 81, 62, 5.10),
(298, 81, 63, 3.90),
(299, 81, 64, 4.50),
(300, 81, 65, 5.00),
(301, 82, 61, 5.50),
(302, 82, 62, 5.70),
(303, 82, 63, 5.30),
(304, 82, 64, 5.80),
(305, 82, 65, 5.60),
(306, 83, 61, 4.60),
(307, 83, 62, 4.90),
(308, 83, 63, 4.70),
(309, 83, 64, 5.20),
(310, 83, 65, 4.80),
(311, 12, 6, 4.80),
(312, 12, 7, 5.20),
(313, 12, 8, 5.50),
(314, 12, 9, 6.00),
(315, 12, 10, 4.70),
(316, 13, 6, 5.30),
(317, 13, 7, 5.60),
(318, 13, 8, 5.80),
(319, 13, 9, 6.20),
(320, 13, 10, 5.00),
(321, 14, 6, 4.50),
(322, 14, 7, 4.90),
(323, 14, 8, 4.70),
(324, 14, 9, 5.10),
(325, 14, 10, 5.00),
(326, 15, 6, 5.00),
(327, 15, 7, 5.30),
(328, 15, 8, 5.60),
(329, 15, 9, 5.90),
(330, 15, 10, 4.80),
(331, 16, 6, 5.50),
(332, 16, 7, 6.00),
(333, 16, 8, 5.30),
(334, 16, 9, 5.60),
(335, 16, 10, 5.20),
(336, 17, 6, 5.40),
(337, 17, 7, 5.20),
(338, 17, 8, 5.50),
(339, 17, 9, 6.10),
(340, 17, 10, 4.90),
(341, 18, 6, 5.00),
(342, 18, 7, 5.40),
(343, 18, 8, 5.80),
(344, 18, 9, 5.70),
(345, 18, 10, 5.30),
(346, 4, 6, 5.10),
(347, 4, 7, 5.60),
(348, 4, 8, 5.30),
(349, 4, 9, 5.80),
(350, 4, 10, 4.70),
(351, 5, 6, 4.80),
(352, 5, 7, 5.20),
(353, 5, 8, 4.90),
(354, 5, 9, 5.10),
(355, 5, 10, 5.00),
(356, 6, 6, 5.30),
(357, 6, 7, 5.10),
(358, 6, 8, 5.40),
(359, 6, 9, 5.20),
(360, 6, 10, 4.60),
(361, 12, 6, 4.80),
(362, 12, 7, 5.20),
(363, 12, 8, 5.50),
(364, 12, 9, 6.00),
(365, 12, 10, 4.70),
(366, 13, 6, 5.30),
(367, 13, 7, 5.60),
(368, 13, 8, 5.80),
(369, 13, 9, 6.20),
(370, 13, 10, 5.00),
(371, 14, 6, 4.50),
(372, 14, 7, 4.90),
(373, 14, 8, 4.70),
(374, 14, 9, 5.10),
(375, 14, 10, 5.00),
(376, 15, 6, 5.00),
(377, 15, 7, 5.30),
(378, 15, 8, 5.60),
(379, 15, 9, 5.90),
(380, 15, 10, 4.80),
(381, 16, 6, 5.50),
(382, 16, 7, 6.00),
(383, 16, 8, 5.30),
(384, 16, 9, 5.60),
(385, 16, 10, 5.20),
(386, 17, 6, 5.40),
(387, 17, 7, 5.20),
(388, 17, 8, 5.50),
(389, 17, 9, 6.10),
(390, 17, 10, 4.90),
(391, 18, 6, 5.00),
(392, 18, 7, 5.40),
(393, 18, 8, 5.80),
(394, 18, 9, 5.70),
(395, 18, 10, 5.30),
(396, 4, 6, 5.10),
(397, 4, 7, 5.60),
(398, 4, 8, 5.30),
(399, 4, 9, 5.80),
(400, 4, 10, 4.70),
(401, 5, 6, 4.80),
(402, 5, 7, 5.20),
(403, 5, 8, 4.90),
(404, 5, 9, 5.10),
(405, 5, 10, 5.00),
(406, 6, 6, 5.30),
(407, 6, 7, 5.10),
(408, 6, 8, 5.40),
(409, 6, 9, 5.20),
(410, 6, 10, 4.60),
(411, 12, 6, 4.80),
(412, 12, 7, 5.20),
(413, 12, 8, 5.50),
(414, 12, 9, 6.00),
(415, 12, 10, 4.70),
(416, 13, 6, 5.30),
(417, 13, 7, 5.60),
(418, 13, 8, 5.80),
(419, 13, 9, 6.20),
(420, 13, 10, 5.00),
(421, 14, 6, 4.50),
(422, 14, 7, 4.90),
(423, 14, 8, 4.70),
(424, 14, 9, 5.10),
(425, 14, 10, 5.00),
(426, 15, 6, 5.00),
(427, 15, 7, 5.30),
(428, 15, 8, 5.60),
(429, 15, 9, 5.90),
(430, 15, 10, 4.80),
(431, 16, 6, 5.50),
(432, 16, 7, 6.00),
(433, 16, 8, 5.30),
(434, 16, 9, 5.60),
(435, 16, 10, 5.20),
(436, 17, 6, 5.40),
(437, 17, 7, 5.20),
(438, 17, 8, 5.50),
(439, 17, 9, 6.10),
(440, 17, 10, 4.90),
(441, 18, 6, 5.00),
(442, 18, 7, 5.40),
(443, 18, 8, 5.80),
(444, 18, 9, 5.70),
(445, 18, 10, 5.30),
(446, 4, 6, 5.10),
(447, 4, 7, 5.60),
(448, 4, 8, 5.30),
(449, 4, 9, 5.80),
(450, 4, 10, 4.70),
(451, 5, 6, 4.80),
(452, 5, 7, 5.20),
(453, 5, 8, 4.90),
(454, 5, 9, 5.10),
(455, 5, 10, 5.00),
(456, 6, 6, 5.30),
(457, 6, 7, 5.10),
(458, 6, 8, 5.40),
(459, 6, 9, 5.20),
(460, 6, 10, 4.60),
(461, 12, 26, 6.50),
(462, 12, 27, 7.20),
(463, 12, 28, 5.50),
(464, 12, 29, 8.00),
(465, 12, 30, 6.00),
(466, 13, 26, 6.00),
(467, 13, 27, 6.80),
(468, 13, 28, 6.50),
(469, 13, 29, 7.50),
(470, 13, 30, 6.20),
(471, 14, 26, 5.20),
(472, 14, 27, 6.00),
(473, 14, 28, 5.80),
(474, 14, 29, 7.00),
(475, 14, 30, 5.50),
(476, 15, 26, 6.50),
(477, 15, 27, 7.00),
(478, 15, 28, 6.70),
(479, 15, 29, 7.20),
(480, 15, 30, 6.30),
(481, 16, 26, 7.00),
(482, 16, 27, 7.50),
(483, 16, 28, 6.80),
(484, 16, 29, 8.00),
(485, 16, 30, 6.90),
(486, 17, 26, 6.80),
(487, 17, 27, 7.30),
(488, 17, 28, 6.60),
(489, 17, 29, 7.80),
(490, 17, 30, 6.70),
(491, 18, 26, 6.20),
(492, 18, 27, 7.00),
(493, 18, 28, 6.50),
(494, 18, 29, 7.30),
(495, 18, 30, 6.40),
(496, 4, 26, 6.30),
(497, 4, 27, 7.10),
(498, 4, 28, 6.20),
(499, 4, 29, 7.00),
(500, 4, 30, 6.00),
(501, 5, 26, 5.60),
(502, 5, 27, 6.30),
(503, 5, 28, 5.90),
(504, 5, 29, 7.10),
(505, 5, 30, 5.80),
(506, 6, 26, 5.70),
(507, 6, 27, 6.20),
(508, 6, 28, 6.00),
(509, 6, 29, 7.00),
(510, 6, 30, 5.50),
(511, 12, 46, 6.80),
(512, 12, 47, 7.30),
(513, 12, 48, 7.50),
(514, 12, 49, 6.20),
(515, 12, 50, 6.70),
(516, 13, 46, 6.50),
(517, 13, 47, 6.80),
(518, 13, 48, 7.00),
(519, 13, 49, 6.50),
(520, 13, 50, 6.90),
(521, 14, 46, 6.00),
(522, 14, 47, 6.20),
(523, 14, 48, 6.50),
(524, 14, 49, 6.10),
(525, 14, 50, 5.80),
(526, 15, 46, 6.70),
(527, 15, 47, 7.20),
(528, 15, 48, 7.30),
(529, 15, 49, 6.80),
(530, 15, 50, 6.50),
(531, 16, 46, 7.00),
(532, 16, 47, 7.50),
(533, 16, 48, 7.80),
(534, 16, 49, 7.20),
(535, 16, 50, 7.00),
(536, 17, 46, 7.10),
(537, 17, 47, 7.30),
(538, 17, 48, 7.00),
(539, 17, 49, 6.90),
(540, 17, 50, 7.00),
(541, 18, 46, 6.20),
(542, 18, 47, 6.50),
(543, 18, 48, 6.80),
(544, 18, 49, 6.30),
(545, 18, 50, 6.40),
(546, 4, 46, 6.00),
(547, 4, 47, 6.30),
(548, 4, 48, 6.50),
(549, 4, 49, 6.20),
(550, 4, 50, 5.90),
(551, 5, 46, 5.70),
(552, 5, 47, 6.10),
(553, 5, 48, 5.90),
(554, 5, 49, 6.00),
(555, 5, 50, 5.80),
(556, 6, 46, 6.10),
(557, 6, 47, 6.40),
(558, 6, 48, 6.20),
(559, 6, 49, 6.50),
(560, 6, 50, 6.00),
(561, 12, 66, 4.80),
(562, 12, 67, 5.20),
(563, 12, 68, 5.50),
(564, 12, 69, 6.00),
(565, 12, 70, 4.70),
(566, 13, 66, 5.30),
(567, 13, 67, 5.60),
(568, 13, 68, 5.80),
(569, 13, 69, 6.20),
(570, 13, 70, 5.00),
(571, 14, 66, 4.50),
(572, 14, 67, 4.90),
(573, 14, 68, 4.70),
(574, 14, 69, 5.10),
(575, 14, 70, 5.00),
(576, 15, 66, 5.00),
(577, 15, 67, 5.30),
(578, 15, 68, 5.60),
(579, 15, 69, 5.90),
(580, 15, 70, 4.80),
(581, 16, 66, 5.50),
(582, 16, 67, 6.00),
(583, 16, 68, 5.30),
(584, 16, 69, 5.60),
(585, 16, 70, 5.20),
(586, 17, 66, 5.40),
(587, 17, 67, 5.20),
(588, 17, 68, 5.50),
(589, 17, 69, 6.10),
(590, 17, 70, 4.90),
(591, 18, 66, 5.00),
(592, 18, 67, 5.40),
(593, 18, 68, 5.80),
(594, 18, 69, 5.70),
(595, 18, 70, 5.30),
(596, 4, 66, 5.10),
(597, 4, 67, 5.60),
(598, 4, 68, 5.30),
(599, 4, 69, 5.80),
(600, 4, 70, 4.70),
(601, 5, 66, 4.80),
(602, 5, 67, 5.20),
(603, 5, 68, 4.90),
(604, 5, 69, 5.10),
(605, 5, 70, 5.00),
(606, 6, 66, 5.30),
(607, 6, 67, 5.10),
(608, 6, 68, 5.40),
(609, 6, 69, 5.20),
(610, 6, 70, 4.60),
(611, 30, 26, 6.30),
(612, 30, 27, 6.50),
(613, 30, 28, 6.70),
(614, 30, 29, 6.80),
(615, 30, 30, 6.40),
(616, 31, 26, 6.60),
(617, 31, 27, 6.90),
(618, 31, 28, 7.00),
(619, 31, 29, 6.70),
(620, 31, 30, 6.80),
(621, 32, 26, 6.40),
(622, 32, 27, 6.80),
(623, 32, 28, 7.10),
(624, 32, 29, 6.60),
(625, 32, 30, 6.20),
(626, 33, 26, 6.50),
(627, 33, 27, 6.70),
(628, 33, 28, 6.90),
(629, 33, 29, 6.40),
(630, 33, 30, 6.30),
(631, 34, 26, 6.20),
(632, 34, 27, 6.40),
(633, 34, 28, 6.60),
(634, 34, 29, 6.00),
(635, 34, 30, 6.10),
(636, 35, 26, 6.30),
(637, 35, 27, 6.50),
(638, 35, 28, 6.80),
(639, 35, 29, 6.60),
(640, 35, 30, 6.20),
(641, 36, 26, 6.70),
(642, 36, 27, 6.90),
(643, 36, 28, 7.00),
(644, 36, 29, 6.50),
(645, 36, 30, 6.80),
(646, 37, 26, 6.40),
(647, 37, 27, 6.80),
(648, 37, 28, 7.10),
(649, 37, 29, 6.70),
(650, 37, 30, 6.50),
(651, 38, 26, 6.90),
(652, 38, 27, 7.10),
(653, 38, 28, 7.30),
(654, 38, 29, 7.00),
(655, 38, 30, 7.20),
(656, 30, 46, 7.10),
(657, 30, 47, 6.80),
(658, 30, 48, 6.90),
(659, 30, 49, 6.50),
(660, 30, 50, 7.00),
(661, 31, 46, 6.70),
(662, 31, 47, 7.00),
(663, 31, 48, 6.80),
(664, 31, 49, 6.90),
(665, 31, 50, 6.50),
(666, 32, 46, 6.90),
(667, 32, 47, 7.10),
(668, 32, 48, 6.70),
(669, 32, 49, 7.00),
(670, 32, 50, 6.80),
(671, 33, 46, 6.50),
(672, 33, 47, 6.80),
(673, 33, 48, 6.70),
(674, 33, 49, 6.90),
(675, 33, 50, 6.60),
(676, 34, 46, 6.30),
(677, 34, 47, 6.60),
(678, 34, 48, 6.50),
(679, 34, 49, 6.70),
(680, 34, 50, 6.40),
(681, 35, 46, 6.80),
(682, 35, 47, 6.90),
(683, 35, 48, 6.70),
(684, 35, 49, 6.40),
(685, 35, 50, 6.50),
(686, 36, 46, 7.00),
(687, 36, 47, 6.90),
(688, 36, 48, 7.10),
(689, 36, 49, 6.80),
(690, 36, 50, 6.60),
(691, 37, 46, 6.60),
(692, 37, 47, 6.80),
(693, 37, 48, 7.00),
(694, 37, 49, 6.70),
(695, 37, 50, 6.90),
(696, 38, 46, 7.20),
(697, 38, 47, 7.10),
(698, 38, 48, 7.30),
(699, 38, 49, 7.00),
(700, 38, 50, 7.20),
(701, 30, 66, 6.50),
(702, 30, 67, 6.90),
(703, 30, 68, 6.70),
(704, 30, 69, 6.80),
(705, 30, 70, 7.00),
(706, 31, 66, 6.80),
(707, 31, 67, 6.60),
(708, 31, 68, 6.90),
(709, 31, 69, 6.70),
(710, 31, 70, 6.80),
(711, 32, 66, 7.00),
(712, 32, 67, 6.70),
(713, 32, 68, 7.10),
(714, 32, 69, 6.90),
(715, 32, 70, 7.00),
(716, 33, 66, 6.60),
(717, 33, 67, 6.80),
(718, 33, 68, 6.70),
(719, 33, 69, 6.90),
(720, 33, 70, 6.50),
(721, 34, 66, 6.50),
(722, 34, 67, 6.60),
(723, 34, 68, 6.80),
(724, 34, 69, 6.70),
(725, 34, 70, 6.60),
(726, 35, 66, 6.70),
(727, 35, 67, 6.50),
(728, 35, 68, 6.80),
(729, 35, 69, 6.60),
(730, 35, 70, 6.70),
(731, 36, 66, 7.10),
(732, 36, 67, 6.90),
(733, 36, 68, 6.80),
(734, 36, 69, 7.00),
(735, 36, 70, 6.80),
(736, 37, 66, 6.90),
(737, 37, 67, 6.80),
(738, 37, 68, 7.00),
(739, 37, 69, 6.60),
(740, 37, 70, 6.90),
(741, 38, 66, 7.20),
(742, 38, 67, 7.00),
(743, 38, 68, 7.10),
(744, 38, 69, 7.30),
(745, 38, 70, 7.00),
(746, 59, 46, 6.50),
(747, 59, 47, 6.70),
(748, 59, 48, 7.00),
(749, 59, 49, 6.80),
(750, 59, 50, 6.90),
(751, 60, 46, 7.00),
(752, 60, 47, 6.80),
(753, 60, 48, 6.90),
(754, 60, 49, 7.20),
(755, 60, 50, 6.70),
(756, 61, 46, 6.80),
(757, 61, 47, 7.00),
(758, 61, 48, 6.70),
(759, 61, 49, 7.10),
(760, 61, 50, 7.00),
(761, 62, 46, 6.70),
(762, 62, 47, 6.90),
(763, 62, 48, 6.80),
(764, 62, 49, 6.50),
(765, 62, 50, 6.60),
(766, 63, 46, 7.10),
(767, 63, 47, 7.00),
(768, 63, 48, 7.20),
(769, 63, 49, 6.90),
(770, 63, 50, 7.00),
(771, 59, 66, 7.20),
(772, 59, 67, 6.90),
(773, 59, 68, 7.00),
(774, 59, 69, 6.80),
(775, 59, 70, 6.70),
(776, 60, 66, 6.90),
(777, 60, 67, 6.80),
(778, 60, 68, 7.10),
(779, 60, 69, 7.00),
(780, 60, 70, 6.60),
(781, 61, 66, 7.00),
(782, 61, 67, 7.20),
(783, 61, 68, 6.90),
(784, 61, 69, 7.10),
(785, 61, 70, 7.00),
(786, 62, 66, 6.80),
(787, 62, 67, 6.70),
(788, 62, 68, 6.90),
(789, 62, 69, 6.80),
(790, 62, 70, 6.50),
(791, 63, 66, 7.10),
(792, 63, 67, 7.30),
(793, 63, 68, 7.20),
(794, 63, 69, 7.00),
(795, 63, 70, 7.10),
(796, 84, 66, 7.40),
(797, 84, 67, 6.80),
(798, 84, 68, 7.00),
(799, 84, 69, 6.90),
(800, 84, 70, 7.20),
(801, 85, 66, 7.00),
(802, 85, 67, 6.90),
(803, 85, 68, 7.20),
(804, 85, 69, 6.80),
(805, 85, 70, 6.70),
(806, 86, 66, 6.90),
(807, 86, 67, 7.10),
(808, 86, 68, 7.00),
(809, 86, 69, 6.80),
(810, 86, 70, 6.60),
(811, 87, 66, 7.30),
(812, 87, 67, 6.70),
(813, 87, 68, 7.10),
(814, 87, 69, 7.00),
(815, 87, 70, 6.80),
(816, 88, 66, 6.80),
(817, 88, 67, 7.00),
(818, 88, 68, 6.90),
(819, 88, 69, 6.70),
(820, 88, 70, 6.60),
(821, 89, 66, 7.00),
(822, 89, 67, 6.80),
(823, 89, 68, 7.10),
(824, 89, 69, 6.90),
(825, 89, 70, 7.00),
(826, 90, 66, 7.20),
(827, 90, 67, 6.90),
(828, 90, 68, 7.00),
(829, 90, 69, 7.10),
(830, 90, 70, 6.80),
(831, 91, 66, 6.80),
(832, 91, 67, 6.70),
(833, 91, 68, 7.20),
(834, 91, 69, 6.90),
(835, 91, 70, 6.50),
(836, 92, 66, 7.30),
(837, 92, 67, 6.90),
(838, 92, 68, 6.80),
(839, 92, 69, 7.00),
(840, 92, 70, 7.10),
(841, 93, 66, 7.00),
(842, 93, 67, 7.10),
(843, 93, 68, 6.90),
(844, 93, 69, 6.80),
(845, 93, 70, 6.70),
(846, 39, 11, 6.00),
(847, 39, 12, 7.00),
(848, 39, 13, 7.50),
(849, 39, 14, 8.00),
(850, 39, 15, 6.50),
(851, 40, 11, 7.00),
(852, 40, 12, 6.50),
(853, 40, 13, 8.50),
(854, 40, 14, 7.50),
(855, 40, 15, 6.00),
(856, 41, 11, 8.00),
(857, 41, 12, 9.00),
(858, 41, 13, 7.00),
(859, 41, 14, 6.50),
(860, 41, 15, 7.50),
(861, 42, 11, 5.50),
(862, 42, 12, 8.00),
(863, 42, 13, 6.50),
(864, 42, 14, 7.00),
(865, 42, 15, 7.50),
(866, 43, 11, 6.50),
(867, 43, 12, 6.00),
(868, 43, 13, 7.00),
(869, 43, 14, 7.50),
(870, 43, 15, 8.00),
(871, 44, 11, 8.50),
(872, 44, 12, 9.00),
(873, 44, 13, 7.00),
(874, 44, 14, 8.00),
(875, 44, 15, 7.00),
(876, 45, 11, 7.50),
(877, 45, 12, 8.50),
(878, 45, 13, 8.00),
(879, 45, 14, 7.00),
(880, 45, 15, 9.00),
(881, 46, 11, 6.50),
(882, 46, 12, 7.00),
(883, 46, 13, 6.00),
(884, 46, 14, 8.50),
(885, 46, 15, 8.00),
(886, 47, 11, 7.00),
(887, 47, 12, 7.50),
(888, 47, 13, 9.00),
(889, 47, 14, 8.00),
(890, 47, 15, 9.50),
(891, 19, 11, 9.50),
(892, 19, 12, 10.00),
(893, 19, 13, 8.50),
(894, 19, 14, 9.00),
(895, 19, 15, 8.00),
(896, 20, 11, 7.50),
(897, 20, 12, 8.00),
(898, 20, 13, 7.00),
(899, 20, 14, 6.00),
(900, 20, 15, 7.00),
(901, 39, 31, 6.50),
(902, 39, 32, 7.00),
(903, 39, 33, 7.50),
(904, 39, 34, 6.00),
(905, 39, 35, 7.00),
(906, 40, 31, 8.00),
(907, 40, 32, 7.50),
(908, 40, 33, 7.00),
(909, 40, 34, 9.00),
(910, 40, 35, 6.50),
(911, 41, 31, 7.00),
(912, 41, 32, 6.00),
(913, 41, 33, 8.00),
(914, 41, 34, 6.50),
(915, 41, 35, 7.00),
(916, 42, 31, 7.50),
(917, 42, 32, 7.00),
(918, 42, 33, 6.00),
(919, 42, 34, 7.50),
(920, 42, 35, 6.50),
(921, 43, 31, 8.00),
(922, 43, 32, 8.50),
(923, 43, 33, 6.50),
(924, 43, 34, 7.00),
(925, 43, 35, 6.00),
(926, 44, 31, 9.00),
(927, 44, 32, 9.50),
(928, 44, 33, 8.50),
(929, 44, 34, 7.50),
(930, 44, 35, 8.00),
(931, 45, 31, 7.00),
(932, 45, 32, 6.50),
(933, 45, 33, 7.50),
(934, 45, 34, 8.00),
(935, 45, 35, 9.00),
(936, 46, 31, 6.00),
(937, 46, 32, 7.00),
(938, 46, 33, 6.50),
(939, 46, 34, 7.50),
(940, 46, 35, 6.00),
(941, 47, 31, 8.50),
(942, 47, 32, 9.00),
(943, 47, 33, 8.00),
(944, 47, 34, 7.50),
(945, 47, 35, 7.00),
(946, 19, 31, 8.00),
(947, 19, 32, 7.50),
(948, 19, 33, 9.00),
(949, 19, 34, 8.50),
(950, 19, 35, 9.50),
(951, 20, 31, 7.00),
(952, 20, 32, 6.50),
(953, 20, 33, 7.50),
(954, 20, 34, 7.00),
(955, 20, 35, 8.00),
(956, 39, 51, 7.00),
(957, 39, 52, 8.00),
(958, 39, 53, 9.00),
(959, 39, 54, 6.00),
(960, 39, 55, 8.00),
(961, 40, 51, 9.00),
(962, 40, 52, 8.00),
(963, 40, 53, 7.00),
(964, 40, 54, 10.00),
(965, 40, 55, 6.00),
(966, 41, 51, 8.00),
(967, 41, 52, 6.00),
(968, 41, 53, 9.00),
(969, 41, 54, 7.00),
(970, 41, 55, 8.00),
(971, 42, 51, 8.00),
(972, 42, 52, 7.00),
(973, 42, 53, 6.00),
(974, 42, 54, 8.00),
(975, 42, 55, 7.00),
(976, 43, 51, 9.00),
(977, 43, 52, 10.00),
(978, 43, 53, 7.00),
(979, 43, 54, 8.00),
(980, 43, 55, 6.00),
(981, 44, 51, 10.00),
(982, 44, 52, 10.00),
(983, 44, 53, 9.00),
(984, 44, 54, 8.00),
(985, 44, 55, 9.00),
(986, 45, 51, 8.00),
(987, 45, 52, 7.00),
(988, 45, 53, 9.00),
(989, 45, 54, 10.00),
(990, 45, 55, 10.00),
(991, 46, 51, 6.00),
(992, 46, 52, 7.00),
(993, 46, 53, 8.00),
(994, 46, 54, 8.00),
(995, 46, 55, 6.00),
(996, 47, 51, 9.00),
(997, 47, 52, 10.00),
(998, 47, 53, 9.00),
(999, 47, 54, 8.00),
(1000, 47, 55, 7.00),
(1001, 19, 51, 9.00),
(1002, 19, 52, 8.00),
(1003, 19, 53, 10.00),
(1004, 19, 54, 9.00),
(1005, 19, 55, 10.00),
(1006, 20, 51, 8.00),
(1007, 20, 52, 7.00),
(1008, 20, 53, 9.00),
(1009, 20, 54, 8.00),
(1010, 20, 55, 9.00),
(1011, 64, 31, 7.00),
(1012, 64, 32, 8.00),
(1013, 64, 33, 6.00),
(1014, 64, 34, 7.00),
(1015, 64, 35, 8.00),
(1016, 65, 31, 9.00),
(1017, 65, 32, 8.00),
(1018, 65, 33, 7.00),
(1019, 65, 34, 9.00),
(1020, 65, 35, 8.00),
(1021, 66, 31, 8.00),
(1022, 66, 32, 7.00),
(1023, 66, 33, 9.00),
(1024, 66, 34, 8.00),
(1025, 66, 35, 9.00),
(1026, 67, 31, 8.00),
(1027, 67, 32, 7.00),
(1028, 67, 33, 8.00),
(1029, 67, 34, 9.00),
(1030, 67, 35, 8.00),
(1031, 68, 31, 7.00),
(1032, 68, 32, 6.00),
(1033, 68, 33, 8.00),
(1034, 68, 34, 7.00),
(1035, 68, 35, 8.00),
(1036, 69, 31, 9.00),
(1037, 69, 32, 8.00),
(1038, 69, 33, 7.00),
(1039, 69, 34, 6.00),
(1040, 69, 35, 7.00),
(1041, 70, 31, 6.00),
(1042, 70, 32, 8.00),
(1043, 70, 33, 7.00),
(1044, 70, 34, 8.00),
(1045, 70, 35, 9.00),
(1046, 64, 51, 6.00),
(1047, 64, 52, 7.00),
(1048, 64, 53, 8.00),
(1049, 64, 54, 7.00),
(1050, 64, 55, 6.00),
(1051, 65, 51, 9.00),
(1052, 65, 52, 8.00),
(1053, 65, 53, 7.00),
(1054, 65, 54, 9.00),
(1055, 65, 55, 8.00),
(1056, 66, 51, 8.00),
(1057, 66, 52, 9.00),
(1058, 66, 53, 6.00),
(1059, 66, 54, 7.00),
(1060, 66, 55, 8.00),
(1061, 67, 51, 7.00),
(1062, 67, 52, 6.00),
(1063, 67, 53, 8.00),
(1064, 67, 54, 7.00),
(1065, 67, 55, 9.00),
(1066, 68, 51, 6.00),
(1067, 68, 52, 5.00),
(1068, 68, 53, 6.00),
(1069, 68, 54, 8.00),
(1070, 68, 55, 7.00),
(1071, 69, 51, 9.00),
(1072, 69, 52, 7.00),
(1073, 69, 53, 8.00),
(1074, 69, 54, 6.00),
(1075, 69, 55, 7.00),
(1076, 70, 51, 7.00),
(1077, 70, 52, 8.00),
(1078, 70, 53, 7.00),
(1079, 70, 54, 9.00),
(1080, 70, 55, 8.00),
(1081, 94, 51, 6.50),
(1082, 94, 52, 7.00),
(1083, 94, 53, 7.50),
(1084, 94, 54, 6.00),
(1085, 94, 55, 7.00),
(1086, 95, 51, 8.00),
(1087, 95, 52, 7.50),
(1088, 95, 53, 6.50),
(1089, 95, 54, 8.00),
(1090, 95, 55, 7.50),
(1091, 96, 51, 7.50),
(1092, 96, 52, 8.00),
(1093, 96, 53, 7.00),
(1094, 96, 54, 7.50),
(1095, 96, 55, 6.50),
(1096, 97, 51, 6.00),
(1097, 97, 52, 7.00),
(1098, 97, 53, 7.50),
(1099, 97, 54, 6.50),
(1100, 97, 55, 8.00),
(1101, 98, 51, 6.50),
(1102, 98, 52, 5.50),
(1103, 98, 53, 6.00),
(1104, 98, 54, 7.00),
(1105, 98, 55, 6.50),
(1106, 99, 51, 8.00),
(1107, 99, 52, 7.00),
(1108, 99, 53, 7.50),
(1109, 99, 54, 6.00),
(1110, 99, 55, 7.50),
(1111, 100, 51, 7.00),
(1112, 100, 52, 6.50),
(1113, 100, 53, 7.00),
(1114, 100, 54, 8.00),
(1115, 100, 55, 6.50),
(1116, 101, 51, 7.50),
(1117, 101, 52, 8.00),
(1118, 101, 53, 6.50),
(1119, 101, 54, 7.50),
(1120, 101, 55, 7.00),
(1121, 48, 16, 6.50),
(1122, 48, 17, 7.00),
(1123, 48, 18, 7.50),
(1124, 48, 19, 6.00),
(1125, 48, 20, 6.50),
(1126, 49, 16, 8.00),
(1127, 49, 17, 7.50),
(1128, 49, 18, 6.50),
(1129, 49, 19, 7.00),
(1130, 49, 20, 7.50),
(1131, 50, 16, 7.50),
(1132, 50, 17, 8.00),
(1133, 50, 18, 7.00),
(1134, 50, 19, 7.50),
(1135, 50, 20, 6.50),
(1136, 51, 16, 6.00),
(1137, 51, 17, 6.50),
(1138, 51, 18, 7.00),
(1139, 51, 19, 6.50),
(1140, 51, 20, 6.00),
(1141, 52, 16, 7.00),
(1142, 52, 17, 7.50),
(1143, 52, 18, 7.50),
(1144, 52, 19, 6.50),
(1145, 52, 20, 7.00),
(1146, 53, 16, 6.50),
(1147, 53, 17, 6.00),
(1148, 53, 18, 6.50),
(1149, 53, 19, 7.00),
(1150, 53, 20, 7.50),
(1151, 21, 16, 7.00),
(1152, 21, 17, 6.50),
(1153, 21, 18, 7.50),
(1154, 21, 19, 7.00),
(1155, 21, 20, 6.00),
(1156, 22, 16, 6.50),
(1157, 22, 17, 7.00),
(1158, 22, 18, 7.00),
(1159, 22, 19, 6.50),
(1160, 22, 20, 6.50),
(1161, 23, 16, 8.00),
(1162, 23, 17, 7.50),
(1163, 23, 18, 8.00),
(1164, 23, 19, 7.50),
(1165, 23, 20, 6.50),
(1166, 24, 16, 7.50),
(1167, 24, 17, 8.00),
(1168, 24, 18, 7.00),
(1169, 24, 19, 7.50),
(1170, 24, 20, 7.00),
(1171, 48, 16, 6.50),
(1172, 48, 17, 7.00),
(1173, 48, 18, 7.50),
(1174, 48, 19, 6.00),
(1175, 48, 20, 6.50),
(1176, 49, 16, 8.00),
(1177, 49, 17, 7.50),
(1178, 49, 18, 6.50),
(1179, 49, 19, 7.00),
(1180, 49, 20, 7.50),
(1181, 50, 16, 7.50),
(1182, 50, 17, 8.00),
(1183, 50, 18, 7.00),
(1184, 50, 19, 7.50),
(1185, 50, 20, 6.50),
(1186, 51, 16, 6.00),
(1187, 51, 17, 6.50),
(1188, 51, 18, 7.00),
(1189, 51, 19, 6.50),
(1190, 51, 20, 6.00),
(1191, 52, 16, 7.00),
(1192, 52, 17, 7.50),
(1193, 52, 18, 7.50),
(1194, 52, 19, 6.50),
(1195, 52, 20, 7.00),
(1196, 53, 16, 6.50),
(1197, 53, 17, 6.00),
(1198, 53, 18, 6.50),
(1199, 53, 19, 7.00),
(1200, 53, 20, 7.50),
(1201, 21, 16, 7.00),
(1202, 21, 17, 6.50),
(1203, 21, 18, 7.50),
(1204, 21, 19, 7.00),
(1205, 21, 20, 6.00),
(1206, 22, 16, 6.50),
(1207, 22, 17, 7.00),
(1208, 22, 18, 7.00),
(1209, 22, 19, 6.50),
(1210, 22, 20, 6.50),
(1211, 23, 16, 8.00),
(1212, 23, 17, 7.50),
(1213, 23, 18, 8.00),
(1214, 23, 19, 7.50),
(1215, 23, 20, 6.50),
(1216, 24, 16, 7.50),
(1217, 24, 17, 8.00),
(1218, 24, 18, 7.00),
(1219, 24, 19, 7.50),
(1220, 24, 20, 7.00),
(1221, 48, 36, 7.00),
(1222, 48, 37, 6.50),
(1223, 48, 38, 6.00),
(1224, 48, 39, 7.50),
(1225, 48, 40, 6.50),
(1226, 49, 36, 7.50),
(1227, 49, 37, 7.00),
(1228, 49, 38, 7.50),
(1229, 49, 39, 7.00),
(1230, 49, 40, 7.50),
(1231, 50, 36, 7.00),
(1232, 50, 37, 6.50),
(1233, 50, 38, 7.00),
(1234, 50, 39, 6.50),
(1235, 50, 40, 6.00),
(1236, 51, 36, 6.50),
(1237, 51, 37, 6.00),
(1238, 51, 38, 6.50),
(1239, 51, 39, 6.00),
(1240, 51, 40, 6.00),
(1241, 52, 36, 7.00),
(1242, 52, 37, 7.00),
(1243, 52, 38, 6.50),
(1244, 52, 39, 7.00),
(1245, 52, 40, 7.00),
(1246, 53, 36, 7.50),
(1247, 53, 37, 7.50),
(1248, 53, 38, 7.00),
(1249, 53, 39, 7.50),
(1250, 53, 40, 7.50),
(1251, 21, 36, 7.00),
(1252, 21, 37, 6.50),
(1253, 21, 38, 7.00),
(1254, 21, 39, 7.00),
(1255, 21, 40, 6.50),
(1256, 22, 36, 6.50),
(1257, 22, 37, 6.50),
(1258, 22, 38, 6.00),
(1259, 22, 39, 6.50),
(1260, 22, 40, 7.00),
(1261, 23, 36, 7.50),
(1262, 23, 37, 7.00),
(1263, 23, 38, 7.50),
(1264, 23, 39, 7.00),
(1265, 23, 40, 7.50),
(1266, 24, 36, 7.00),
(1267, 24, 37, 7.50),
(1268, 24, 38, 7.00),
(1269, 24, 39, 7.50),
(1270, 24, 40, 7.00),
(1271, 48, 56, 6.50),
(1272, 48, 57, 6.00),
(1273, 48, 58, 7.00),
(1274, 48, 59, 6.50),
(1275, 48, 60, 7.00),
(1276, 49, 56, 7.00),
(1277, 49, 57, 6.50),
(1278, 49, 58, 7.50),
(1279, 49, 59, 7.00),
(1280, 49, 60, 7.50),
(1281, 50, 56, 6.00),
(1282, 50, 57, 6.50),
(1283, 50, 58, 6.00),
(1284, 50, 59, 6.00),
(1285, 50, 60, 6.50),
(1286, 51, 56, 6.50),
(1287, 51, 57, 6.00),
(1288, 51, 58, 6.50),
(1289, 51, 59, 6.50),
(1290, 51, 60, 6.00),
(1291, 52, 56, 7.00),
(1292, 52, 57, 7.00),
(1293, 52, 58, 7.50),
(1294, 52, 59, 7.00),
(1295, 52, 60, 7.50),
(1296, 53, 56, 7.50),
(1297, 53, 57, 7.00),
(1298, 53, 58, 7.50),
(1299, 53, 59, 7.50),
(1300, 53, 60, 7.50),
(1301, 21, 56, 7.00),
(1302, 21, 57, 6.50),
(1303, 21, 58, 7.00),
(1304, 21, 59, 6.50),
(1305, 21, 60, 7.00),
(1306, 22, 56, 6.50),
(1307, 22, 57, 6.00),
(1308, 22, 58, 7.00),
(1309, 22, 59, 7.00),
(1310, 22, 60, 7.00),
(1311, 23, 56, 7.00),
(1312, 23, 57, 7.50),
(1313, 23, 58, 7.50),
(1314, 23, 59, 7.00),
(1315, 23, 60, 7.50),
(1316, 24, 56, 7.00),
(1317, 24, 57, 7.00),
(1318, 24, 58, 7.50),
(1319, 24, 59, 7.50),
(1320, 24, 60, 7.00),
(1321, 71, 36, 6.50),
(1322, 71, 37, 6.00),
(1323, 71, 38, 6.50),
(1324, 71, 39, 6.00),
(1325, 71, 40, 6.50),
(1326, 72, 36, 7.00),
(1327, 72, 37, 7.50),
(1328, 72, 38, 7.00),
(1329, 72, 39, 7.00),
(1330, 72, 40, 7.50),
(1331, 73, 36, 6.00),
(1332, 73, 37, 6.50),
(1333, 73, 38, 6.50),
(1334, 73, 39, 6.50),
(1335, 73, 40, 6.00),
(1336, 74, 36, 7.00),
(1337, 74, 37, 7.50),
(1338, 74, 38, 7.00),
(1339, 74, 39, 7.50),
(1340, 74, 40, 7.50),
(1341, 75, 36, 6.50),
(1342, 75, 37, 6.00),
(1343, 75, 38, 6.00),
(1344, 75, 39, 6.50),
(1345, 75, 40, 6.00),
(1346, 76, 36, 7.00),
(1347, 76, 37, 6.50),
(1348, 76, 38, 7.00),
(1349, 76, 39, 7.50),
(1350, 76, 40, 7.00),
(1351, 77, 36, 6.00),
(1352, 77, 37, 6.50),
(1353, 77, 38, 6.50),
(1354, 77, 39, 6.00),
(1355, 77, 40, 6.50),
(1356, 78, 36, 6.50),
(1357, 78, 37, 6.00),
(1358, 78, 38, 6.00),
(1359, 78, 39, 6.50),
(1360, 78, 40, 6.50),
(1361, 71, 56, 7.50),
(1362, 71, 57, 6.00),
(1363, 71, 58, 6.50),
(1364, 71, 59, 7.00),
(1365, 71, 60, 6.50),
(1366, 72, 56, 6.50),
(1367, 72, 57, 7.00),
(1368, 72, 58, 7.50),
(1369, 72, 59, 6.00),
(1370, 72, 60, 6.50),
(1371, 73, 56, 6.00),
(1372, 73, 57, 6.50),
(1373, 73, 58, 6.00),
(1374, 73, 59, 6.50),
(1375, 73, 60, 6.00),
(1376, 74, 56, 7.00),
(1377, 74, 57, 6.50),
(1378, 74, 58, 6.50),
(1379, 74, 59, 6.50),
(1380, 74, 60, 7.00),
(1381, 75, 56, 6.50),
(1382, 75, 57, 6.00),
(1383, 75, 58, 6.50),
(1384, 75, 59, 7.00),
(1385, 75, 60, 6.50),
(1386, 76, 56, 7.00),
(1387, 76, 57, 6.50),
(1388, 76, 58, 6.00),
(1389, 76, 59, 6.50),
(1390, 76, 60, 7.00),
(1391, 77, 56, 6.00),
(1392, 77, 57, 6.50),
(1393, 77, 58, 6.50),
(1394, 77, 59, 6.00),
(1395, 77, 60, 6.50),
(1396, 78, 56, 7.00),
(1397, 78, 57, 6.00),
(1398, 78, 58, 6.50),
(1399, 78, 59, 6.00),
(1400, 78, 60, 6.50),
(1401, 102, 56, 7.00),
(1402, 102, 57, 6.50),
(1403, 102, 58, 6.00),
(1404, 102, 59, 6.50),
(1405, 102, 60, 7.00),
(1406, 103, 56, 7.50),
(1407, 103, 57, 7.00),
(1408, 103, 58, 7.00),
(1409, 103, 59, 7.50),
(1410, 103, 60, 7.00),
(1411, 104, 56, 6.50),
(1412, 104, 57, 7.00),
(1413, 104, 58, 6.00),
(1414, 104, 59, 6.50),
(1415, 104, 60, 6.00),
(1416, 105, 56, 6.00),
(1417, 105, 57, 6.50),
(1418, 105, 58, 6.50),
(1419, 105, 59, 6.00),
(1420, 105, 60, 6.50),
(1421, 106, 56, 7.00),
(1422, 106, 57, 6.50),
(1423, 106, 58, 6.50),
(1424, 106, 59, 7.00),
(1425, 106, 60, 6.50);

-- --------------------------------------------------------

--
-- Structure de la table `offres`
--

CREATE TABLE `offres` (
  `id` int(11) NOT NULL,
  `poste` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `competences` text DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_limite` date DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `fichier` varchar(255) DEFAULT NULL,
  `id_entreprise` int(11) DEFAULT NULL,
  `id_type_offre` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `offres`
--

INSERT INTO `offres` (`id`, `poste`, `description`, `competences`, `date_debut`, `date_limite`, `contact`, `tags`, `fichier`, `id_entreprise`, `id_type_offre`) VALUES
(12, 'ss', 'ss', 'xx', '2037-11-17', '2041-11-18', 'jjdj@gmail.com', 'qqq', '/images/entreprises/1744470251646-logo.png', 16, NULL),
(13, 'ss', 'ss', 'dd', '2041-12-17', '2041-10-18', 'kdd@gmail.com', 'ddd', '/images/entreprises/1744380055379-logo.png', 11, NULL),
(14, 'ss', 'sss', 'ss', '2037-09-16', '2041-07-16', 'kss@gmail.com', 's', '/images/entreprises/1744465500804-1.jpg', 15, NULL),
(17, 'directeur', 'ffhsg', 'ggsggs', '2037-08-14', '2038-07-16', 'gsggshs@gmail.com', 'ss', NULL, 16, NULL),
(18, 'data analyste', 'msdlfjksmlddfk', 'bac +3', '2025-03-17', '2037-06-08', 'dlqjkfs@gmail.com', 'dmlqhjljs', NULL, NULL, NULL),
(19, 'jgjg', 'n,,', 'vnv', '2025-05-01', '2025-05-06', 'jhgj', 'kjghk', 'uploads/offres/1746287216149-Capture dâÃ©cran (1).png', 16, 1),
(20, 'kqjhdfkqsj', 'mamady ', 'bac5', '2025-05-02', '2025-05-23', 'qdf', 'kjghk', 'uploads/offres/1746623170951-Capture dâÃ©cran (1).png', 15, 2),
(21, 'qlfjklfjk', '1234', 'qsf', '2025-05-09', '2025-05-03', 'qdsfqsfsqdf', 'qsfqs', 'uploads/offres/1746624430368-Capture dâÃ©cran (1).png', 15, 2),
(22, 'ismael', 'sdfhskj', 'qsdkfjqksf', '2025-05-22', '2025-05-31', 'mldqshj', 'sdfjkshdf', 'uploads/offres/1746626525376-makossa.jpg', 15, 2),
(23, 'dba', 'lsjdljslf', 'qsdkfdqsfsfsfjqksf', '2025-05-22', '2025-05-31', 'mldqshj', 'sdfjkshdf', 'uploads/offres/1746629238315-AMI.PNG', 15, 1);

-- --------------------------------------------------------

--
-- Structure de la table `partenaire`
--

CREATE TABLE `partenaire` (
  `id` int(11) NOT NULL,
  `startup_id` int(11) DEFAULT NULL,
  `entreprise_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `partenaire`
--

INSERT INTO `partenaire` (`id`, `startup_id`, `entreprise_id`) VALUES
(6, 13, 16),
(7, 18, 16),
(8, 19, 16),
(9, 14, 16);

-- --------------------------------------------------------

--
-- Structure de la table `postulations`
--

CREATE TABLE `postulations` (
  `id` int(11) NOT NULL,
  `id_offre` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `date_postule` date NOT NULL,
  `statut_postuler` enum('En attente','Accepté','Refusé') DEFAULT 'En attente',
  `statut_embauche` enum('En attente','Embauché','Non embauché') DEFAULT 'En attente',
  `cv` varchar(100) NOT NULL,
  `lettre_motivation` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `postulations`
--

INSERT INTO `postulations` (`id`, `id_offre`, `id_etudiant`, `date_postule`, `statut_postuler`, `statut_embauche`, `cv`, `lettre_motivation`) VALUES
(1, 12, 3, '2025-05-07', 'En attente', 'En attente', '1746638609720-cv.pdf', '1746638609795-lettre_motivation.pdf'),
(2, 17, 3, '2025-05-07', 'En attente', 'En attente', '1746638988863-cv.pdf', '1746638988912-lettre_motivation.pdf'),
(3, 12, 3, '2025-05-07', 'En attente', 'En attente', '1746642717730-cv.pdf', '1746642717922-lettre_motivation.pdf'),
(4, 13, 3, '2025-05-07', 'En attente', 'En attente', '1746644986306-cv.pdf', '1746644986354-lettre_motivation.pdf'),
(5, 19, 3, '2025-05-07', 'En attente', 'En attente', '1746648637104-cv.pdf', '1746648637135-lettre_motivation.pdf');

-- --------------------------------------------------------

--
-- Structure de la table `projet_academique`
--

CREATE TABLE `projet_academique` (
  `id` int(11) NOT NULL,
  `id_experience` int(11) NOT NULL,
  `id_contact` int(11) DEFAULT NULL,
  `prof` varchar(30) NOT NULL,
  `matiere` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `publication`
--

CREATE TABLE `publication` (
  `id` int(11) NOT NULL,
  `image` blob NOT NULL,
  `id_offre` int(11) DEFAULT NULL,
  `id_startup` int(11) DEFAULT NULL,
  `id_formation` int(11) DEFAULT NULL,
  `id_aimer` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `id_commentaire` int(11) DEFAULT NULL,
  `date_pub` date NOT NULL DEFAULT curdate(),
  `id_entreprise` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `secteur_geographique`
--

CREATE TABLE `secteur_geographique` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `secteur_geographique`
--

INSERT INTO `secteur_geographique` (`id`, `nom`) VALUES
(5, 'International'),
(1, 'Local'),
(3, 'National'),
(2, 'Régional'),
(4, 'Sous-régional');

-- --------------------------------------------------------

--
-- Structure de la table `startup`
--

CREATE TABLE `startup` (
  `id` int(11) NOT NULL,
  `id_domaine` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `site_web` varchar(255) DEFAULT NULL,
  `date_creation` date NOT NULL,
  `description` text DEFAULT NULL,
  `problematique` text DEFAULT NULL,
  `solution` text DEFAULT NULL,
  `id_etudiant` int(11) NOT NULL,
  `fichier` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `startup`
--

INSERT INTO `startup` (`id`, `id_domaine`, `nom`, `site_web`, `date_creation`, `description`, `problematique`, `solution`, `id_etudiant`, `fichier`) VALUES
(13, 1, 'LJLKL', 'LJKJHK;COM', '0000-00-00', 'OIIOUIIIIIIII', 'GHGHGHYGYYG', 'YUYUUYU', 2, 'uploads/startups/1745835762239-MAMADY SACKO CV(0).pdf'),
(14, 1, 'lkqsjf', 'qskdfjq.com', '2020-02-08', 'kjqfkjqhfklhqklfhqlksf', 'qfqkfqksfhqslkfj', 'skjdhfqlksdjhfqklsfdj', 2, 'uploads/startups/1745983142770-dabo.png'),
(15, 1, 'dfqdsfkj', 'qskldjfhksj.com', '0000-00-00', 'lkdjhfkljqs', 'qdfjklqsdhjkf', 'sjkldhfqskljf', 2, 'uploads/startups/1746010019044-icone unc.jpg'),
(16, 2, 'vsvjklsdvf', 'vfs', '0202-01-01', 'sgdfsdgf', 'sfgssdgds', 'fsgsdf', 2, 'uploads/startups/1746010615430-dabo.png'),
(17, 1, 'ldkjqhfqkl', 'lsf', '0202-01-05', 'qpohflkqjh', 'lqohdflqfkjd', 'qdfhqlsmfds', 2, 'uploads/startups/1746011041720-dabo.png'),
(18, 1, 'mamady saxko', 'dmslfjsdkl', '0000-00-00', 'psujdfmljsfmdjklqfjdfkljqsdlk', 'j jhkljhkl jhk jhk', 'jh jhkg j', 2, 'uploads/startups/1746059640092-AMI.PNG'),
(19, 3, 'jhk', 'iioi', '2020-02-01', 'jhj', 'uh', 'iuuiui', 2, 'uploads/startups/1746271338932-icone unc.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `statut_etudiant`
--

CREATE TABLE `statut_etudiant` (
  `id` int(11) NOT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `id_etudiant` int(11) NOT NULL,
  `nom_entreprise` varchar(50) DEFAULT NULL,
  `poste` varchar(30) DEFAULT NULL,
  `type_emploi` varchar(30) DEFAULT NULL,
  `duree_emploi` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `statut_etudiant`
--

INSERT INTO `statut_etudiant` (`id`, `contact`, `id_etudiant`, `nom_entreprise`, `poste`, `type_emploi`, `duree_emploi`) VALUES
(1, 'sldjkfmls', 2, 'sacqfjq', 'kjhgjkqfjlsqfj', 'stagiaire', NULL),
(2, NULL, 3, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `type_cert_attes`
--

CREATE TABLE `type_cert_attes` (
  `id` int(11) NOT NULL,
  `nom` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type_cert_attes`
--

INSERT INTO `type_cert_attes` (`id`, `nom`) VALUES
(1, 'Certification '),
(2, 'Attestation'),
(3, 'Experience Academique'),
(4, 'Experience Professionnell');

-- --------------------------------------------------------

--
-- Structure de la table `type_entreprise`
--

CREATE TABLE `type_entreprise` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type_entreprise`
--

INSERT INTO `type_entreprise` (`id`, `nom`) VALUES
(7, 'Association'),
(9, 'Auto-entrepreneur'),
(8, 'Coopérative'),
(14, 'Entreprise artisanale'),
(11, 'Entreprise individuelle'),
(13, 'Entreprise industrielle'),
(5, 'Entreprise publique'),
(10, 'Entreprise sociale'),
(4, 'Grande entreprise'),
(3, 'Multinationale'),
(6, 'ONG'),
(2, 'PME'),
(12, 'Société de services'),
(1, 'Startup');

-- --------------------------------------------------------

--
-- Structure de la table `type_offre`
--

CREATE TABLE `type_offre` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type_offre`
--

INSERT INTO `type_offre` (`id`, `nom`) VALUES
(1, 'Offre'),
(2, 'Stage');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `adresse`
--
ALTER TABLE `adresse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_adresse_entreprise` (`id_entreprise`),
  ADD KEY `fk_adresse_etudiant` (`id_etudiant`);

--
-- Index pour la table `aimer`
--
ALTER TABLE `aimer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aimer_ibfk_1` (`id_etudiant`),
  ADD KEY `fk_aimer_offre` (`id_offre`);

--
-- Index pour la table `cert_attes`
--
ALTER TABLE `cert_attes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cert_attes_etudiant` (`id_etudiant`),
  ADD KEY `fk_cert_attes_type` (`id_type_cert_attes`);

--
-- Index pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commentaires_ibfk_1` (`id_offre`),
  ADD KEY `commentaires_ibfk_2` (`id_etudiant`);

--
-- Index pour la table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `departement`
--
ALTER TABLE `departement`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `departement_licence`
--
ALTER TABLE `departement_licence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_departement_licence_departement` (`id_departement`),
  ADD KEY `fk_departement_licence_licence` (`id_licence`);

--
-- Index pour la table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_document_etudiant` (`id_etudiant`);

--
-- Index pour la table `domaine`
--
ALTER TABLE `domaine`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `domaine_entreprise`
--
ALTER TABLE `domaine_entreprise`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `entreprise`
--
ALTER TABLE `entreprise`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_type_entreprise` (`id_type_entreprise`),
  ADD KEY `fk_secteur_geographique` (`id_secteur_geographique`),
  ADD KEY `fk_domaine_entreprise` (`id_domaine_entreprise`),
  ADD KEY `fk_admin` (`id_admin`);

--
-- Index pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_etudiant_departement` (`id_departement`),
  ADD KEY `fk_etudiant_licence` (`id_licence`),
  ADD KEY `fk_etudiant_startup` (`id_startup`),
  ADD KEY `fk_etudiant_contact` (`id_contact`);

--
-- Index pour la table `exp_profession`
--
ALTER TABLE `exp_profession`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_exp_profession_experience` (`id_experience`),
  ADD KEY `fk_exp_profession_contact` (`id_contact`);

--
-- Index pour la table `faculte`
--
ALTER TABLE `faculte`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `formation`
--
ALTER TABLE `formation`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `formations`
--
ALTER TABLE `formations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_formations_entreprise` (`id_entreprise`);

--
-- Index pour la table `inscrip_etudiant`
--
ALTER TABLE `inscrip_etudiant`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `inscrip_etudiant_email_matricule` (`email`,`matricule`),
  ADD KEY `fk_inscrip_etudiant_etudiant` (`id_etudiant`);

--
-- Index pour la table `licence`
--
ALTER TABLE `licence`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `matiere`
--
ALTER TABLE `matiere`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_matiere_licence` (`id_licence`),
  ADD KEY `fk_matiere_departement` (`id_departement`);

--
-- Index pour la table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_message_etudiant` (`id_etudiant`),
  ADD KEY `fk_message_entreprise` (`id_entreprise`);

--
-- Index pour la table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_note_etudiant` (`id_etudiant`),
  ADD KEY `fk_note_matiere` (`id_matiere`);

--
-- Index pour la table `offres`
--
ALTER TABLE `offres`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entreprise_id` (`id_entreprise`),
  ADD KEY `fk_type_offre` (`id_type_offre`);

--
-- Index pour la table `partenaire`
--
ALTER TABLE `partenaire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `startup_id` (`startup_id`),
  ADD KEY `entreprise_id` (`entreprise_id`);

--
-- Index pour la table `postulations`
--
ALTER TABLE `postulations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_offre` (`id_offre`),
  ADD KEY `id_etudiant` (`id_etudiant`);

--
-- Index pour la table `projet_academique`
--
ALTER TABLE `projet_academique`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_projet_academique_experience` (`id_experience`),
  ADD KEY `fk_projet_academique_contact` (`id_contact`);

--
-- Index pour la table `publication`
--
ALTER TABLE `publication`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_publication_offre` (`id_offre`),
  ADD KEY `fk_publication_startup` (`id_startup`),
  ADD KEY `fk_publication_formation` (`id_formation`),
  ADD KEY `fk_publication_aimer` (`id_aimer`),
  ADD KEY `fk_publication_commentaire` (`id_commentaire`),
  ADD KEY `fk_publication_entreprise` (`id_entreprise`);

--
-- Index pour la table `secteur_geographique`
--
ALTER TABLE `secteur_geographique`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nom` (`nom`);

--
-- Index pour la table `startup`
--
ALTER TABLE `startup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_startup_domaine` (`id_domaine`);

--
-- Index pour la table `statut_etudiant`
--
ALTER TABLE `statut_etudiant`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_statut_etudiant_etudiant` (`id_etudiant`);

--
-- Index pour la table `type_cert_attes`
--
ALTER TABLE `type_cert_attes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `type_entreprise`
--
ALTER TABLE `type_entreprise`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nom` (`nom`);

--
-- Index pour la table `type_offre`
--
ALTER TABLE `type_offre`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `adresse`
--
ALTER TABLE `adresse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `aimer`
--
ALTER TABLE `aimer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `cert_attes`
--
ALTER TABLE `cert_attes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `commentaires`
--
ALTER TABLE `commentaires`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `departement`
--
ALTER TABLE `departement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `departement_licence`
--
ALTER TABLE `departement_licence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `document`
--
ALTER TABLE `document`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `domaine`
--
ALTER TABLE `domaine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `domaine_entreprise`
--
ALTER TABLE `domaine_entreprise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `entreprise`
--
ALTER TABLE `entreprise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `etudiant`
--
ALTER TABLE `etudiant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT pour la table `exp_profession`
--
ALTER TABLE `exp_profession`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `faculte`
--
ALTER TABLE `faculte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `formation`
--
ALTER TABLE `formation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `formations`
--
ALTER TABLE `formations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `inscrip_etudiant`
--
ALTER TABLE `inscrip_etudiant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT pour la table `licence`
--
ALTER TABLE `licence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `matiere`
--
ALTER TABLE `matiere`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `note`
--
ALTER TABLE `note`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1426;

--
-- AUTO_INCREMENT pour la table `offres`
--
ALTER TABLE `offres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `partenaire`
--
ALTER TABLE `partenaire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `postulations`
--
ALTER TABLE `postulations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `projet_academique`
--
ALTER TABLE `projet_academique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `publication`
--
ALTER TABLE `publication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `secteur_geographique`
--
ALTER TABLE `secteur_geographique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `startup`
--
ALTER TABLE `startup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `statut_etudiant`
--
ALTER TABLE `statut_etudiant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `type_cert_attes`
--
ALTER TABLE `type_cert_attes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `type_entreprise`
--
ALTER TABLE `type_entreprise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `type_offre`
--
ALTER TABLE `type_offre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `adresse`
--
ALTER TABLE `adresse`
  ADD CONSTRAINT `fk_adresse_entreprise` FOREIGN KEY (`id_entreprise`) REFERENCES `inscrip_entreprise` (`id`),
  ADD CONSTRAINT `fk_adresse_etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`);

--
-- Contraintes pour la table `aimer`
--
ALTER TABLE `aimer`
  ADD CONSTRAINT `aimer_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`),
  ADD CONSTRAINT `fk_aimer_offre` FOREIGN KEY (`id_offre`) REFERENCES `offres` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cert_attes`
--
ALTER TABLE `cert_attes`
  ADD CONSTRAINT `fk_cert_attes_etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`),
  ADD CONSTRAINT `fk_cert_attes_type` FOREIGN KEY (`id_type_cert_attes`) REFERENCES `type_cert_attes` (`id`);

--
-- Contraintes pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD CONSTRAINT `commentaires_ibfk_1` FOREIGN KEY (`id_offre`) REFERENCES `offres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commentaires_ibfk_2` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `departement_licence`
--
ALTER TABLE `departement_licence`
  ADD CONSTRAINT `fk_departement_licence_departement` FOREIGN KEY (`id_departement`) REFERENCES `departement` (`id`),
  ADD CONSTRAINT `fk_departement_licence_licence` FOREIGN KEY (`id_licence`) REFERENCES `licence` (`id`);

--
-- Contraintes pour la table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `fk_document_etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`);

--
-- Contraintes pour la table `entreprise`
--
ALTER TABLE `entreprise`
  ADD CONSTRAINT `fk_admin` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id`),
  ADD CONSTRAINT `fk_domaine_entreprise` FOREIGN KEY (`id_domaine_entreprise`) REFERENCES `domaine_entreprise` (`id`),
  ADD CONSTRAINT `fk_secteur_geographique` FOREIGN KEY (`id_secteur_geographique`) REFERENCES `secteur_geographique` (`id`),
  ADD CONSTRAINT `fk_type_entreprise` FOREIGN KEY (`id_type_entreprise`) REFERENCES `type_entreprise` (`id`);

--
-- Contraintes pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `fk_etudiant_contact` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id`),
  ADD CONSTRAINT `fk_etudiant_departement` FOREIGN KEY (`id_departement`) REFERENCES `departement` (`id`),
  ADD CONSTRAINT `fk_etudiant_licence` FOREIGN KEY (`id_licence`) REFERENCES `licence` (`id`),
  ADD CONSTRAINT `fk_etudiant_startup` FOREIGN KEY (`id_startup`) REFERENCES `startup` (`id`);

--
-- Contraintes pour la table `exp_profession`
--
ALTER TABLE `exp_profession`
  ADD CONSTRAINT `fk_exp_profession_contact` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id`),
  ADD CONSTRAINT `fk_exp_profession_experience` FOREIGN KEY (`id_experience`) REFERENCES `experience` (`id`);

--
-- Contraintes pour la table `formation`
--
ALTER TABLE `formation`
  ADD CONSTRAINT `fk_formation_entreprise` FOREIGN KEY (`id`) REFERENCES `entreprise` (`id`);

--
-- Contraintes pour la table `formations`
--
ALTER TABLE `formations`
  ADD CONSTRAINT `fk_formations_entreprise` FOREIGN KEY (`id_entreprise`) REFERENCES `entreprise` (`id`);

--
-- Contraintes pour la table `inscrip_etudiant`
--
ALTER TABLE `inscrip_etudiant`
  ADD CONSTRAINT `fk_inscrip_etudiant_etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`);

--
-- Contraintes pour la table `matiere`
--
ALTER TABLE `matiere`
  ADD CONSTRAINT `fk_matiere_departement` FOREIGN KEY (`id_departement`) REFERENCES `departement` (`id`),
  ADD CONSTRAINT `fk_matiere_licence` FOREIGN KEY (`id_licence`) REFERENCES `licence` (`id`);

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `fk_message_entreprise` FOREIGN KEY (`id_entreprise`) REFERENCES `entreprise` (`id`),
  ADD CONSTRAINT `fk_message_etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`);

--
-- Contraintes pour la table `note`
--
ALTER TABLE `note`
  ADD CONSTRAINT `fk_note_etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`),
  ADD CONSTRAINT `fk_note_matiere` FOREIGN KEY (`id_matiere`) REFERENCES `matiere` (`id`);

--
-- Contraintes pour la table `offres`
--
ALTER TABLE `offres`
  ADD CONSTRAINT `fk_type_offre` FOREIGN KEY (`id_type_offre`) REFERENCES `type_offre` (`id`),
  ADD CONSTRAINT `offres_ibfk_1` FOREIGN KEY (`id_entreprise`) REFERENCES `entreprise` (`id`);

--
-- Contraintes pour la table `partenaire`
--
ALTER TABLE `partenaire`
  ADD CONSTRAINT `partenaire_ibfk_1` FOREIGN KEY (`startup_id`) REFERENCES `startup` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `partenaire_ibfk_2` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprise` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `postulations`
--
ALTER TABLE `postulations`
  ADD CONSTRAINT `postulations_ibfk_1` FOREIGN KEY (`id_offre`) REFERENCES `offres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `postulations_ibfk_2` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projet_academique`
--
ALTER TABLE `projet_academique`
  ADD CONSTRAINT `fk_projet_academique_contact` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id`),
  ADD CONSTRAINT `fk_projet_academique_experience` FOREIGN KEY (`id_experience`) REFERENCES `experience` (`id`);

--
-- Contraintes pour la table `publication`
--
ALTER TABLE `publication`
  ADD CONSTRAINT `fk_publication_aimer` FOREIGN KEY (`id_aimer`) REFERENCES `aimer` (`id`),
  ADD CONSTRAINT `fk_publication_commentaire` FOREIGN KEY (`id_commentaire`) REFERENCES `commentaire` (`id`),
  ADD CONSTRAINT `fk_publication_entreprise` FOREIGN KEY (`id_entreprise`) REFERENCES `entreprise` (`id`),
  ADD CONSTRAINT `fk_publication_formation` FOREIGN KEY (`id_formation`) REFERENCES `formation` (`id`),
  ADD CONSTRAINT `fk_publication_offre` FOREIGN KEY (`id_offre`) REFERENCES `offre` (`id`),
  ADD CONSTRAINT `fk_publication_startup` FOREIGN KEY (`id_startup`) REFERENCES `startup` (`id`);

--
-- Contraintes pour la table `startup`
--
ALTER TABLE `startup`
  ADD CONSTRAINT `fk_startup_domaine` FOREIGN KEY (`id_domaine`) REFERENCES `domaine` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `statut_etudiant`
--
ALTER TABLE `statut_etudiant`
  ADD CONSTRAINT `fk_statut_etudiant_etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
