import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';

const router = express.Router();

// GET tous les commentaires pour une offre
router.get('/offres/:id/commentaires', async (req, res) => {
  const id_offre = req.params.id;

  try {
    const db = await connectionToDatabase();

    const [comments] = await db.query(
      `SELECT c.commentaire, c.date_commentaire, e.nom AS nom_utilisateur
       FROM commentaires c
       JOIN etudiant e ON c.id_etudiant = e.id
       WHERE c.id_offre = ?
       ORDER BY c.date_commentaire DESC`,
      [id_offre]
    );

    res.json(comments);
  } catch (error) {
    console.error('[ERROR GET COMMENTS]', error);
    res.status(500).json({ message: 'Erreur lors du chargement des commentaires.' });
  }
});

// POST un nouveau commentaire
router.post('/offres/:id/commentaires', async (req, res) => {
  const id_offre = req.params.id;
  const { userId, commentaire } = req.body;

  if (!userId || !commentaire) {
    return res.status(400).json({ message: 'Champs requis manquants.' });
  }

  try {
    const db = await connectionToDatabase();

    const date = new Date().toISOString().split('T')[0];

    await db.query(
      `INSERT INTO commentaires (id_offre, id_etudiant, commentaire, date_commentaire)
       VALUES (?, ?, ?, ?)`,
      [id_offre, userId, commentaire, date]
    );

    res.status(201).json({ message: 'Commentaire ajouté avec succès.' });
  } catch (error) {
    console.error('[ERROR POST COMMENT]', error);
    res.status(500).json({ message: 'Erreur lors de l\'ajout du commentaire.' });
  }
});

export default router;