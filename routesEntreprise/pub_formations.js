import express from 'express';
import multer from 'multer';
import fs from 'fs';
import path from 'path';
import { connectionToDatabase } from '../lib/db.js';

const router = express.Router();

// 📁 Dossier de stockage pour les images des formations
const uploadDir = 'uploads/formations';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// 📦 Configuration de multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => cb(null, `${Date.now()}-${file.originalname}`)
});
const upload = multer({ storage });

/** ➕ Ajouter une formation **/
router.post('/publier/formation', upload.single('image'), async (req, res) => {
  const {
    titre,
    description,
    localisation,
    date_debut,
    date_fin,
    prerequis,
    email_contact,
    id_entreprise
  } = req.body;

  if (!titre || !description || !localisation || !date_debut || !date_fin || !prerequis || !email_contact || !id_entreprise || !req.file) {
    return res.status(400).json({ message: "Champs requis manquants" });
  }

  try {
    const db = await connectionToDatabase();
    const imagePath = `${uploadDir}/${req.file.filename}`;
    const BASE_URL = (process.env.BASE_URL || 'http://localhost:3000').replace('/api', '');

    await db.query(
      `INSERT INTO formations (titre, description, localisation, date_debut, date_fin, prerequis, email_contact, image, id_entreprise)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [titre, description, localisation, date_debut, date_fin, prerequis, email_contact, imagePath, id_entreprise]
    );

    res.status(201).json({
      message: "Formation enregistrée avec succès",
      data: {
        titre,
        description,
        localisation,
        date_debut,
        date_fin,
        prerequis,
        email_contact,
        id_entreprise,
        image_url: `${BASE_URL}/${imagePath}`
      }
    });
  } catch (err) {
    console.error("Erreur lors de l'enregistrement de la formation :", err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});

/** 📄 Récupérer toutes les formations **/
router.get('/formations', async (req, res) => {
  try {
    const db = await connectionToDatabase();
    const [formations] = await db.query('SELECT * FROM formations');
    res.status(200).json(formations);
  } catch (err) {
    console.error("Erreur lors de la récupération des formations :", err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});

export default router;
