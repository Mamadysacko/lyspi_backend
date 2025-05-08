import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';

const router = express.Router();

// POST pour liker ou unliker une offre
router.post('/offres/:id/like', async (req, res) => {
  const id_offre = req.params.id;
  const { userId } = req.body;

  if (!userId) {
    return res.status(400).json({ message: 'ID utilisateur requis.' });
  }

  try {
    const db = await connectionToDatabase();

    // Vérifie que l'offre existe dans offres_emploi
    const [offerExists] = await db.query(
      'SELECT id FROM offres WHERE id = ?',
      [id_offre]
    );

    if (offerExists.length === 0) {
      return res.status(404).json({ message: 'Offre introuvable dans la base.' });
    }

    // Vérifie si l'utilisateur a déjà liké cette offre
    const [rows] = await db.query(
      'SELECT * FROM aimer WHERE id_etudiant = ? AND id_offre = ?',
      [userId, id_offre]
    );

    let liked;
    if (rows.length > 0) {
      // L'utilisateur a déjà une ligne => on toggle le statut
      const currentStatut = rows[0].statut;
      const newStatut = currentStatut === 1 ? 0 : 1;
      liked = newStatut === 1;

      await db.query(
        'UPDATE aimer SET statut = ?, date = CURDATE() WHERE id_etudiant = ? AND id_offre = ?',
        [newStatut, userId, id_offre]
      );
    } else {
      // Premier like : on insère une nouvelle ligne
      liked = true;
      await db.query(
        'INSERT INTO aimer (id_etudiant, id_offre, date, statut) VALUES (?, ?, CURDATE(), 1)',
        [userId, id_offre]
      );
    }

    // Recalculer le nombre total de likes actifs
    const [likeCount] = await db.query(
      'SELECT COUNT(*) AS total FROM aimer WHERE id_offre = ? AND statut = 1',
      [id_offre]
    );

    const nbLikes = likeCount[0].total;

    res.json({ liked, nbLikes });
  } catch (error) {
    console.error('[ERROR LIKE]', error);
    res.status(500).json({ message: 'Erreur serveur.' });
  }
});

// GET pour vérifier si l'utilisateur a liké l'offre
router.get('/offres/:id/like/:userId', async (req, res) => {
  const { id, userId } = req.params;

  try {
    const db = await connectionToDatabase();
    const [rows] = await db.query(
      'SELECT statut FROM aimer WHERE id_offre = ? AND id_etudiant = ?',
      [id, userId]
    );

    const statut = rows.length > 0 ? rows[0].statut : 0;
    res.json({ statut });
  } catch (error) {
    console.error('[ERROR CHECK LIKE]', error);
    res.status(500).json({ message: 'Erreur serveur.' });
  }
});

export default router;