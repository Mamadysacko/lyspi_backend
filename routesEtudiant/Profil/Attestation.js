// Nouveau fichier par exemple : certAttes.js
import express from 'express';
import multer from 'multer';
import fs from 'fs';
import path from 'path';
import { connectionToDatabase } from '../../lib/db.js';

const router = express.Router();

const uploadDir = 'uploads/certificats';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// Configuration de multer pour les fichiers
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => cb(null, `${Date.now()}-${file.originalname}`)
});
const upload = multer({ storage });

// ➡️ 1. Récupérer tous les types de certificats/attestations
router.get('/types-certificats', async (req, res) => {
  try {
    const db = await connectionToDatabase();
    const [types] = await db.query('SELECT * FROM type_cert_attes');
    res.status(200).json(types);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});

// ➡️ 1. Ajouter un certificat/attestation
router.post('/certificats/register', upload.single('diplome'), async (req, res) => {
  const { id_etudiant, id_type_cert_attes, description, date_obtention, delivre } = req.body;

  // Vérification des champs requis
  if (!id_etudiant || !id_type_cert_attes || !description || !delivre) {
    return res.status(400).json({ message: "Champs requis manquants" });
  }

  try {
    const db = await connectionToDatabase();

    // Vérification si le fichier a bien été téléchargé
    if (!req.file) {
      return res.status(400).json({ message: "Le fichier du diplôme est requis" });
    }

    const diplomePath = `uploads/certificats/${req.file.filename}`;
    const BASE_URL = (process.env.BASE_URL || 'http://localhost:3000').replace('/api', '');

    // Insertion dans la base de données
    await db.query(
      `INSERT INTO cert_attes (id_etudiant, id_type_cert_attes, description, diplome, date_obtention, delivre) 
       VALUES (?, ?, ?, ?, ?, ?)`,
      [id_etudiant, id_type_cert_attes, description, diplomePath, date_obtention || null, delivre]
    );

    res.status(201).json({
      message: "Certificat/Attestation enregistré avec succès",
      data: {
        id_etudiant,
        id_type_cert_attes,
        description,
        diplome_url: `${BASE_URL}/${diplomePath}`,
        date_obtention,
        delivre,
      },
    });
  } catch (err) {
    console.error("Erreur serveur :", err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});

// ➡️ 2. Récupérer les certificats/attestations d'un étudiant
router.get('/certificats/etudiantliste/:id_etudiant', async (req, res) => {
  const { id_etudiant } = req.params;

  if (!id_etudiant) {
    return res.status(400).json({ message: "ID étudiant manquant" });
  }

  try {
    const db = await connectionToDatabase();
    const [certifications] = await db.query(
      `SELECT 
          ca.id, 
          ca.description, 
          ca.diplome, 
          ca.date_obtention, 
          ca.delivre, 
          tca.nom AS type_certificat
       FROM cert_attes ca
       INNER JOIN type_cert_attes tca ON ca.id_type_cert_attes = tca.id
       WHERE ca.id_etudiant = ?`,
      [id_etudiant]
    );

    const BASE_URL = (process.env.BASE_URL || 'http://localhost:3000').replace('/api', '');

    const formattedCertifications = certifications.map(cert => ({
      id: cert.id,
      type_certificat: cert.type_certificat,
      description: cert.description,
      date_obtention: cert.date_obtention,
      delivre: cert.delivre,
      diplome_url: cert.diplome ? `${BASE_URL}/${cert.diplome}` : null
    }));

    res.status(200).json(formattedCertifications);
  } catch (err) {
    console.error("Erreur serveur :", err);
    res.status(500).json({ message: "Erreur serveur" });
  }
});


export default router;
