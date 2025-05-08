import express from 'express';
import multer from 'multer';
import fs from 'fs';
import path from 'path';
import { connectionToDatabase } from '../lib/db.js';

const router = express.Router();

// Crée le dossier s'il n'existe pas
const uploadDir = 'images/entreprises';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
  console.log(`[INFO] Dossier '${uploadDir}' créé`);
}

// Configuration de stockage avec Multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const uniqueName = `${Date.now()}-${file.originalname}`;
    cb(null, uniqueName);
  }
});

// Filtrer uniquement les images
const fileFilter = (req, file, cb) => {
  const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp'];
  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Seuls les fichiers image sont autorisés !'), false);
  }
};

const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 5 * 1024 * 1024 } // max 5MB
});

// Route d'inscription entreprise avec image
router.post('/entreprise/register', upload.single('photo'), async (req, res) => {
  console.log('[INFO] Requête reçue pour l\'inscription de l\'entreprise');

  const { nom_entreprise, mail, user, password } = req.body;

  if (!nom_entreprise || !mail || !user || !password) {
    console.error('[ERROR] Tous les champs sont requis pour l\'inscription');
    return res.status(400).json({ message: "Tous les champs sont requis" });
  }

  try {
    const db = await connectionToDatabase();
    const [userRows] = await db.query('SELECT * FROM entreprise WHERE user = ?', [user]);

    if (userRows.length > 0) {
      return res.status(409).json({ message: "Utilisateur déjà existant" });
    }

    const [adminRows] = await db.query('SELECT id FROM admin WHERE user = ?', ['kamano']);
    if (adminRows.length === 0) {
      return res.status(404).json({ message: "Administrateur non trouvé" });
    }

    const id_admin = adminRows[0].id;

    // Récupère l'URL de l'image ou null
    const photoUrl = req.file ? `images/entreprises/${req.file.filename}` : null;
    console.log('[INFO] Image enregistrée :', photoUrl);

    await db.query(
      `INSERT INTO entreprise (id_admin, nom_entreprise, mail, user, mot_de_passe, photo) 
       VALUES (?, ?, ?, ?, ?, ?)`,
      [id_admin, nom_entreprise, mail, user, password, photoUrl]
    );

    return res.status(201).json({ message: "Entreprise créée avec succès" });

  } catch (err) {
    console.error('[ERROR] Erreur lors de l\'inscription:', err.message);
    return res.status(500).json({ message: "Erreur du serveur, veuillez réessayer plus tard" });
  }
});

export default router;