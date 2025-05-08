import express from 'express';
import multer from 'multer';
import path from 'path';
import fs from 'fs';
import { connectionToDatabase } from '../../lib/db.js';

const router = express.Router();

// 📁 Configuration de Multer pour enregistrer les fichiers sur le disque
const uploadDir = './uploads/postulations';
if (!fs.existsSync(uploadDir)) fs.mkdirSync(uploadDir);

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    const uniqueName = `${Date.now()}-${file.fieldname}${ext}`;
    cb(null, uniqueName);
  }
});

const upload = multer({ storage });

// ✅ Route : postuler à une offre avec CV et lettre de motivation
router.post(
  '/etudiant/postuler',
  upload.fields([
    { name: 'cv', maxCount: 1 },
    { name: 'lettre_motivation', maxCount: 1 },
  ]),
  async (req, res) => {
    try {
      const { id_offre, id_etudiant } = req.body;
      const cvFile = req.files['cv']?.[0];
      const lettreFile = req.files['lettre_motivation']?.[0];

      if (!id_offre || !id_etudiant || !cvFile || !lettreFile) {
        return res.status(400).json({ message: 'Tous les champs sont obligatoires.' });
      }

      const db = await connectionToDatabase();

      // Vérification de l'existence de l'offre
      const [[offerExists]] = await db.query('SELECT 1 FROM offres WHERE id = ?', [id_offre]);
      if (!offerExists) return res.status(400).json({ message: 'Offre non trouvée.' });

      // Vérification de l'existence de l'étudiant
      const [[studentExists]] = await db.query('SELECT 1 FROM etudiant WHERE id = ?', [id_etudiant]);
      if (!studentExists) return res.status(400).json({ message: 'Étudiant non trouvé.' });

      const date_postule = new Date().toISOString().split('T')[0];

      // Insertion de la postulation
      await db.query(
        `INSERT INTO postulations (
          id_offre, id_etudiant, date_postule, statut_postuler, statut_embauche,
          cv, lettre_motivation
        ) VALUES (?, ?, ?, 'En attente', 'En attente', ?, ?)`,
        [
          id_offre,
          id_etudiant,
          date_postule,
          cvFile.filename,
          lettreFile.filename
        ]
      );

      res.status(201).json({ message: 'Candidature envoyée avec succès.' });
    } catch (err) {
      console.error('[ERROR] Erreur serveur:', err);
      res.status(500).json({ message: 'Erreur serveur. Réessayez plus tard.' });
    }
  }
);

// ✅ Route : mise à jour du statut de la postulation
router.put('/admin/valider-etudiant', async (req, res) => {
  const { id_postulation, statut } = req.body;

  const validStatus = ['Accepté', 'Refusé', 'En attente', 'En cours'];

  if (!id_postulation || !validStatus.includes(statut)) {
    return res.status(400).json({ message: 'ID ou statut invalide.' });
  }

  try {
    const db = await connectionToDatabase();

    const [result] = await db.query(
      `UPDATE postulations 
       SET statut_postuler = ? 
       WHERE id = ?`,
      [statut, id_postulation]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Candidature non trouvée.' });
    }

    res.json({ message: `Statut mis à jour vers "${statut}".` });
  } catch (err) {
    console.error('Erreur mise à jour statut candidat :', err);
    res.status(500).json({ message: 'Erreur serveur' });
  }
});

// ✅ Route : récupération des postulations pour une offre
router.get('/admin/postulations', async (req, res) => {
  const { id_offre } = req.query;

  if (!id_offre) {
    return res.status(400).json({ message: 'ID de l\'offre est requis.' });
  }

  try {
    const db = await connectionToDatabase();

    const [postulations] = await db.query(
      `SELECT p.id AS id_postulation, e.nom, e.prenom, e.matricule, p.statut_postuler, 
              p.date_postule, p.cv, p.lettre_motivation
       FROM postulations p
       JOIN etudiant e ON p.id_etudiant = e.id
       WHERE p.id_offre = ?`,
      [id_offre]
    );

    res.json(postulations);
  } catch (err) {
    console.error('Erreur récupération postulations:', err);
    res.status(500).json({ message: 'Erreur serveur' });
  }
});

// ✅ Route : récupération des postulations pour un étudiant
router.get('/etudiant/postulations', async (req, res) => {
  const { id_etudiant } = req.query;

  if (!id_etudiant) {
    return res.status(400).json({ message: 'ID de l\'étudiant est requis.' });
  }

  try {
    const db = await connectionToDatabase();

    const [postulations] = await db.query(
      `SELECT p.id AS id_postulation, o.titre_poste, p.statut_postuler, p.date_postule 
       FROM postulations p
       JOIN offres o ON p.id_offre = o.id
       WHERE p.id_etudiant = ?`,
      [id_etudiant]
    );

    res.json(postulations);
  } catch (err) {
    console.error('Erreur récupération postulations:', err);
    res.status(500).json({ message: 'Erreur serveur' });
  }
});

// ✅ Route : récupération d'une postulation spécifique
router.get('/admin/postulation/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const db = await connectionToDatabase();

    const [postulation] = await db.query(
      `SELECT p.id AS id_postulation, e.nom, e.prenom, e.matricule, p.statut_postuler, 
              p.date_postule, p.cv, p.lettre_motivation
       FROM postulations p
       JOIN etudiant e ON p.id_etudiant = e.id
       WHERE p.id = ?`,
      [id]
    );

    if (!postulation.length) {
      return res.status(404).json({ message: 'Postulation non trouvée.' });
    }

    res.json(postulation[0]);
  } catch (err) {
    console.error('Erreur récupération postulation:', err);
    res.status(500).json({ message: 'Erreur serveur' });
  }
});

// ✅ Route : téléchargement d'un fichier (CV ou lettre de motivation)
router.get('/download/:filename', (req, res) => {
  const { filename } = req.params;
  const filePath = path.join(uploadDir, filename);

  fs.access(filePath, fs.constants.F_OK, (err) => {
    if (err) {
      return res.status(404).json({ message: 'Fichier non trouvé.' });
    }
    res.download(filePath, filename, (err) => {
      if (err) {
        console.error('Erreur lors du téléchargement du fichier:', err);
        res.status(500).json({ message: 'Erreur lors du téléchargement du fichier.' });
      }
    });
  });
});

export default router;
