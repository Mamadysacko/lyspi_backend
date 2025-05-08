// routes/offres.js
import express from 'express'; 
import multer from 'multer';
import fs from 'fs';
import path from 'path';
import { connectionToDatabase } from '../lib/db.js';

const router = express.Router();

// 📁 Dossier de stockage
const uploadDir = 'uploads/offres';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// 📦 Configuration de multer pour l'upload de fichiers
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => cb(null, `${Date.now()}-${file.originalname}`)
});
const upload = multer({ storage });

/** ➕ Ajouter une offre **/
router.post('/publier/offres', upload.single('fichier'), async (req, res) => {
  const { poste, description, competences, date_debut, date_limite, contact, tags, id_entreprise, id_type_offre } = req.body;

  if (!poste || !description || !date_debut || !date_limite || !contact || !id_entreprise || !id_type_offre || !req.file) {
    return res.status(400).json({ message: "Champs requis manquants" });
  }

  try {
    const db = await connectionToDatabase();
    const fichierPath = `${uploadDir}/${req.file.filename}`;
    const BASE_URL = (process.env.BASE_URL || 'http://localhost:3000').replace('/api', '');

    await db.query(
      `INSERT INTO offres (poste, description, competences, date_debut, date_limite, contact, tags, fichier, id_entreprise, id_type_offre)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [poste, description, competences, date_debut, date_limite, contact, tags, fichierPath, id_entreprise, id_type_offre]
    );

    res.status(201).json({
      message: "Offre enregistrée avec succès",
      data: {
        poste,
        description,
        competences,
        date_debut,
        date_limite,
        contact,
        tags,
        id_entreprise,
        id_type_offre,
        fichier_url: `${BASE_URL}/${fichierPath}`
      }
    });
  } catch (err) {
    console.error("Erreur lors de l'enregistrement de l'offre :", err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});

/** 📄 Récupérer tous les types d’offres **/
router.get('/types-offres', async (req, res) => {
  try {
    const db = await connectionToDatabase();
    const [types] = await db.query('SELECT * FROM type_offre');
    res.status(200).json(types);
  } catch (err) {
    console.error("Erreur lors de la récupération des types d'offres :", err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});

export default router;
