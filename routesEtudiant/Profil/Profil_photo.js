import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';
import multer from 'multer';
import path from 'path';
import fs from 'fs';

const router = express.Router();

// === Upload config ===
const uploadDir = './uploads/etudiants';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    const baseName = path.basename(file.originalname, ext);
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, baseName + '-' + uniqueSuffix + ext);
  }
});

const upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const allowed = /jpeg|jpg|png|gif/;
    const validMime = allowed.test(file.mimetype);
    const validExt = allowed.test(path.extname(file.originalname).toLowerCase());
    if (validMime && validExt) cb(null, true);
    else cb(new Error('Seules les images sont autorisées (jpeg, jpg, png, gif)'));
  }
});

// === GET: infos nom, prénom, matricule ===
router.get('/etudiant_info_nom/:id', async (req, res) => {
  const etudiantId = parseInt(req.params.id, 10);

  if (isNaN(etudiantId)) {
    console.warn('ID invalide fourni:', req.params.id);
    return res.status(400).json({ message: 'ID invalide' });
  }

  console.log(`Tentative de récupération des informations de l'étudiant avec ID ${etudiantId}...`);

  try {
    const db = await connectionToDatabase();

    if (!db) {
      return res.status(500).json({ message: 'Échec de la connexion à la base de données.' });
    }

    const [rows] = await db.execute(`
      SELECT 
        nom, 
        prenom, 
        matricule
      FROM etudiant
      WHERE id = ?
    `, [etudiantId]);

    if (rows.length === 0) {
      console.warn(`Aucun étudiant trouvé avec l'ID ${etudiantId}`);
      return res.status(404).json({ message: 'Étudiant non trouvé' });
    }

    console.log(`Données de l'étudiant ${etudiantId} récupérées avec succès.`);

    res.json({
      nom: rows[0].nom,
      prenom: rows[0].prenom,
      matricule: rows[0].matricule
    });

  } catch (err) {
    console.error(`Erreur lors de la récupération des données de l'étudiant ${etudiantId}:`, err);
    res.status(500).json({ message: 'Erreur interne lors de la récupération des données.' });
  }
});

// === PUT: mise à jour des images ===
router.put('/etudiant/photo/:id_etudiant', upload.fields([
  { name: 'photo_profil', maxCount: 1 },
  { name: 'photo_couverture', maxCount: 1 }
]), async (req, res) => {
  const { id_etudiant } = req.params;
  let updates = [];
  let values = [];

  if (req.files['photo_profil']) {
    const pathProfil = '/' + req.files['photo_profil'][0].path.replace(/\\/g, '/');
    updates.push('photo_profil = ?');
    values.push(pathProfil);
  }

  if (req.files['photo_couverture']) {
    const pathCouverture = '/' + req.files['photo_couverture'][0].path.replace(/\\/g, '/');
    updates.push('photo_couverture = ?');
    values.push(pathCouverture);
  }

  if (updates.length === 0) {
    return res.status(400).json({ message: 'Aucune image reçue.' });
  }

  values.push(id_etudiant);
  const sql = `UPDATE inscrip_etudiant SET ${updates.join(', ')} WHERE id_etudiant = ?`;

  try {
    const db = await connectionToDatabase();

    if (!db) {
      return res.status(500).json({ message: 'Échec de la connexion à la base de données.' });
    }

    const [result] = await db.execute(sql, values);
    res.json({ message: 'Images mises à jour avec succès.' });

  } catch (err) {
    console.error('Erreur mise à jour images :', err);
    res.status(500).json({ message: 'Erreur serveur' });
  }
});

// === GET: récupération des images ===
router.get('/etudiant/photo/:id_etudiant', async (req, res) => {
  const { id_etudiant } = req.params;
  const sql = 'SELECT photo_profil, photo_couverture FROM inscrip_etudiant WHERE id_etudiant = ?';

  try {
    const db = await connectionToDatabase();

    if (!db) {
      return res.status(500).json({ message: 'Échec de la connexion à la base de données.' });
    }

    const [rows] = await db.execute(sql, [id_etudiant]);

    if (rows.length === 0) {
      return res.status(404).json({ message: 'Étudiant non trouvé' });
    }

    res.json(rows[0]);

  } catch (err) {
    console.error('Erreur récupération images :', err);
    res.status(500).json({ message: 'Erreur serveur' });
  }
});

export default router;
