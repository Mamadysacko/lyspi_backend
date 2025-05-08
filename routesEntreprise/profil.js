import express from 'express';
import { connectionToDatabase } from '../lib/db.js';
import multer from 'multer';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const router = express.Router();

// Recréer __dirname pour ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// === Upload config ===
const uploadDir = path.join(__dirname, '../uploads/logo');
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

// === PUT: mise à jour du logo ===
router.put('/entreprise/logo/:id', upload.single('logo'), async (req, res) => {
  const { id } = req.params;

  // Vérification si un fichier a été envoyé
  if (!req.file) {
    return res.status(400).json({ message: 'Aucune image reçue.' });
  }

  const logoPath = '/uploads/logo/' + req.file.filename;

  try {
    const db = await connectionToDatabase();

    // Vérifiez si l'entreprise existe
    const [rows] = await db.execute('SELECT logo FROM entreprise WHERE id = ?', [id]);
    if (rows.length === 0) {
      return res.status(404).json({ message: 'Entreprise non trouvée.' });
    }

    // Supprimez l'ancien logo s'il existe
    if (rows[0].logo) {
      const oldLogoPath = path.join(__dirname, '..', rows[0].logo);
      if (fs.existsSync(oldLogoPath)) {
        fs.unlinkSync(oldLogoPath); // Supprime l'ancien fichier
      }
    }

    // Mettre à jour le logo dans la base de données
    await db.execute('UPDATE entreprise SET logo = ? WHERE id = ?', [logoPath, id]);

    res.json({ message: 'Logo mis à jour avec succès.', logo: logoPath });

  } catch (err) {
    console.error('Erreur mise à jour logo :', err);
    res.status(500).json({ message: 'Erreur serveur.' });
  }
});

// === GET: récupération du logo ===
router.get('/entreprise/logo_get/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const db = await connectionToDatabase();

    // Vérifiez si l'entreprise existe
    const [rows] = await db.execute('SELECT logo FROM entreprise WHERE id = ?', [id]);
    if (rows.length === 0) {
      return res.status(404).json({ message: 'Entreprise non trouvée.' });
    }

    const logoPath = path.join(__dirname, '..', rows[0].logo);

    // Vérifiez si le fichier existe dans le système de fichiers
    if (!fs.existsSync(logoPath)) {
      return res.status(404).json({ message: 'Fichier logo introuvable.' });
    }

    // Retournez le chemin relatif du logo
    res.json({ logo: rows[0].logo });

  } catch (err) {
    console.error('Erreur récupération logo :', err);
    res.status(500).json({ message: 'Erreur serveur.' });
  }
});


router.put('/profil_entreprise/:id', async (req, res) => {
  try {
    const db = await connectionToDatabase();
    const { id } = req.params;

    const {
      nom_complet_user, sigle, description, nom_entreprise, mail,
      user, mot_de_passe, tel, site_web,
      domaine_intervention, id_type_entreprise, id_secteur_geographique, id_domaine_entreprise
    } = req.body;


    // Mise à jour de l'entreprise
    await db.execute(
      `UPDATE entreprise SET 
        nom_complet_user = ?, sigle = ?, description = ?, nom_entreprise = ?, mail = ?, 
        user = ?, mot_de_passe = ?, tel = ?, site_web = ?, 
       domaine_intervention = ?, 
        id_type_entreprise = ?, id_secteur_geographique = ?, id_domaine_entreprise = ?
       WHERE id = ?`,
      [
        nom_complet_user, sigle, description, nom_entreprise, mail,
        user, mot_de_passe, tel, site_web,
         domaine_intervention,
        id_type_entreprise, id_secteur_geographique, id_domaine_entreprise,
        id
      ]
    );
    res.json({ message: 'Entreprise mise à jour avec succès' });
  } catch (err) {
    console.error('Erreur lors de la mise à jour :', err);
    res.status(500).json({ error: 'Erreur lors de la mise à jour' });
  }
});


router.get('/entreprise_get/:id', async (req, res) => {
  const db = await connectionToDatabase();
  const { id } = req.params;

  try {
    const [rows] = await db.execute('SELECT * FROM entreprise WHERE id = ?', [id]);

    if (rows.length === 0) {
      return res.status(404).json({ error: 'Entreprise non trouvée' });
    }

    res.json(rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Erreur serveur' });
  }
});

router.get('/relations/all', async (req, res) => {
  const db = await connectionToDatabase();

  try {
    const [types] = await db.execute('SELECT id, nom FROM type_entreprise');
    const [secteurs] = await db.execute('SELECT id, nom FROM secteur_geographique');
    const [domaines] = await db.execute('SELECT id, nom FROM domaine_entreprise');

    res.json({
      types,
      secteurs,
      domaines
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Erreur récupération des relations' });
  }
});

export default router;