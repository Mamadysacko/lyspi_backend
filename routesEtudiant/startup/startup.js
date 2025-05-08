import express from 'express';
import multer from 'multer';
import fs from 'fs';
import path from 'path';
import { connectionToDatabase } from '../../lib/db.js';

const router = express.Router();

// Répertoire pour le téléchargement des fichiers
const uploadDir = 'uploads/startups';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// Configuration de multer pour les fichiers
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => cb(null, `${Date.now()}-${file.originalname}`)
});
const upload = multer({ storage });

// ➡️ 1. Récupérer tous les domaines disponibles
router.get('/domaines', async (req, res) => {
  try {
    const db = await connectionToDatabase();
    const [domaines] = await db.query('SELECT * FROM domaine');
    res.status(200).json(domaines);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});

// ➡️ 2. Ajouter une nouvelle startup
router.post('/startups/register', upload.single('fichier'), async (req, res) => {
  const { id_domaine, nom, site_web, date_creation, description, problematique, solution, id_etudiant } = req.body;

  // Vérification des champs requis
  if (!id_domaine || !nom || !date_creation || !description || !problematique || !solution || !id_etudiant || !req.file) {
    return res.status(400).json({ message: "Champs requis manquants" });
  }

  try {
    const db = await connectionToDatabase();

    // Vérification si le fichier a bien été téléchargé
    if (!req.file) {
      return res.status(400).json({ message: "Le fichier est requis" });
    }

    const fichierPath = `uploads/startups/${req.file.filename}`;
    const BASE_URL = (process.env.BASE_URL || 'http://localhost:3000').replace('/api', '');

    // Insertion dans la base de données
    await db.query(
      `INSERT INTO startup (id_domaine, nom, site_web, date_creation, description, problematique, solution, id_etudiant, fichier) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [id_domaine, nom, site_web, date_creation, description, problematique, solution, id_etudiant, fichierPath]
    );

    res.status(201).json({
      message: "Startup enregistrée avec succès",
      data: {
        id_domaine,
        nom,
        site_web,
        date_creation,
        description,
        problematique,
        solution,
        id_etudiant,
        fichier_url: `${BASE_URL}/${fichierPath}`,
      },
    });
  } catch (err) {
    console.error("Erreur serveur :", err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});



// ➡️ 4. Récupérer les startups avec les informations de l'entreprise partenaire
router.get('/startups/partenaires/:idEtudiant', async (req, res) => {
  const { idEtudiant } = req.params;

  try {
    const db = await connectionToDatabase();

    const [results] = await db.query(
      `SELECT 
         s.id AS startup_id,
         s.nom AS startup_nom,
         s.description,
         s.date_creation,
         s.site_web,
         s.fichier,
         d.nom AS domaine_nom,
         e.nom_entreprise,
         e.mail,
         e.description AS entreprise_description
       FROM startup s
       JOIN domaine d ON s.id_domaine = d.id
       LEFT JOIN partenaire p ON s.id = p.startup_id
       LEFT JOIN entreprise e ON p.entreprise_id = e.id
       WHERE s.id_etudiant = ?`,
      [idEtudiant]
    );

    const BASE_URL = (process.env.BASE_URL || 'http://localhost:3000').replace('/api', '');

    const startups = results.map(row => ({
      id: row.startup_id,
      nom: row.startup_nom,
      description: row.description,
      date_creation: row.date_creation,
      site_web: row.site_web,
      domaine_nom: row.domaine_nom,
      fichier_url: row.fichier ? `${BASE_URL}/${row.fichier}` : null,
      entreprise: row.nom_entreprise ? {
        nom: row.nom_entreprise,
        mail: row.mail,
        description: row.entreprise_description
      } : null
    }));

    res.status(200).json(startups);
  } catch (err) {
    console.error("Erreur lors de la récupération des partenaires :", err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});


export default router;