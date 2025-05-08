import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';
import multer from 'multer';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const router = express.Router();

// === Upload config ===
const uploadDir = path.join(__dirname, '../../uploads/documents');
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

// === PUT: mise à jour des images ===
router.put('/etudiant/documents_put/:id_etudiant', upload.fields([
  { name: 'dipl_baccalaureat', maxCount: 1 },
  { name: 'extrait_naissance', maxCount: 1 },
  { name: 'releve_notes', maxCount: 1 },
  { name: 'dipl_licence', maxCount: 1 },
  { name: 'dipl_master', maxCount: 1 }
]), async (req, res) => {
  const { id_etudiant } = req.params;
  let updates = [];
  let values = [];

  const fields = ['dipl_baccalaureat', 'extrait_naissance', 'releve_notes', 'dipl_licence', 'dipl_master'];

  fields.forEach(field => {
    if (req.files[field]) {
      const filePath = '/uploads/documents/' + req.files[field][0].filename;
      updates.push(`${field} = ?`);
      values.push(filePath);
    }
  });

  if (updates.length === 0) {
    return res.status(400).json({ message: 'Aucun document reçu.' });
  }

  values.push(id_etudiant);
  const sql = `UPDATE document SET ${updates.join(', ')} WHERE id_etudiant = ?`;

  try {
    const db = await connectionToDatabase();

    if (!db) {
      return res.status(500).json({ message: 'Échec de la connexion à la base de données.' });
    }

    const [result] = await db.execute(sql, values);
    res.json({ message: 'Documents mis à jour avec succès.' });

  } catch (err) {
    console.error('Erreur mise à jour documents :', err);
    res.status(500).json({ message: 'Erreur serveur' });
  }
});

// === GET: récupération des images ===
router.get('/etudiant/documents/:id_etudiant', async (req, res) => {
  const { id_etudiant } = req.params;
  const sql = `
    SELECT 
      dipl_baccalaureat, 
      extrait_naissance, 
      releve_notes, 
      dipl_licence, 
      dipl_master 
    FROM document 
    WHERE id_etudiant = ?
  `;

  try {
    const db = await connectionToDatabase();

    if (!db) {
      return res.status(500).json({ message: 'Échec de la connexion à la base de données.' });
    }

    const [rows] = await db.execute(sql, [id_etudiant]);

    if (rows.length === 0) {
      return res.status(404).json({ message: 'Documents non trouvés pour cet étudiant.' });
    }

    // Renvoyer les chemins tels qu'ils sont stockés en base
    res.json(rows[0]);

  } catch (err) {
    console.error('Erreur récupération documents :', err);
    res.status(500).json({ message: 'Erreur serveur' });
  }
});




export default router;