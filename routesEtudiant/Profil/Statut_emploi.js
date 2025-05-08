// api/statut_etudiant.js
import express from 'express';
import { connectionToDatabase } from '../../lib/db.js'; // Assurez-vous que ce chemin est correct

const router = express.Router();

// Récupérer le statut d'un étudiant
router.get('/statut_etudiantget/:id_etudiant', async (req, res) => {
  const { id_etudiant } = req.params;
  const query = 'SELECT * FROM statut_etudiant WHERE id_etudiant = ?';

  try {
    const db = await connectionToDatabase();
    const [results] = await db.query(query, [id_etudiant]);
    res.json(results[0] || {}); // Renvoie un objet vide si aucun statut trouvé
  } catch (err) {
    console.error('Erreur lors de la récupération du statut :', err);
    res.status(500).json({ error: 'Erreur serveur' });
  }
});

// Mettre à jour ou insérer le statut d'un étudiant
router.put('/statut_etudiant/:id_etudiant', async (req, res) => {
  const { id_etudiant } = req.params;
  const { nom_entreprise, contact, poste, duree_emploi, type_emploi } = req.body;



  try {
    const db = await connectionToDatabase();

    // Vérifier si le statut existe
    const [existing] = await db.query('SELECT id_etudiant FROM statut_etudiant WHERE id_etudiant = ?', [id_etudiant]);

    if (existing.length > 0) {
      // Mise à jour
      await db.query(`
        UPDATE statut_etudiant
        SET nom_entreprise = ?, contact = ?, poste = ?, duree_emploi = ?, type_emploi = ?
        WHERE id_etudiant = ?
      `, [nom_entreprise, contact, poste, duree_emploi, type_emploi, id_etudiant]);
      res.json({ message: 'Statut mis à jour avec succès.' });
    } else {
      // Insertion
      await db.query(`
        INSERT INTO statut_etudiant (id_etudiant, nom_entreprise, contact, poste, duree_emploi, type_emploi)
        VALUES (?, ?, ?, ?, ?, ?)
      `, [id_etudiant, nom_entreprise, contact, poste, duree_emploi, type_emploi]);
      res.status(201).json({ message: 'Statut ajouté avec succès.' });
    }
  } catch (err) {
    console.error('Erreur lors de la mise à jour ou insertion du statut :', err);
    res.status(500).json({ error: 'Erreur serveur' });
  }
});

export default router;
