import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';

const router = express.Router();

// Route 1 : Moyenne générale + Mention par Licence pour un étudiant spécifique
router.get('/licences/moyennes/:id_etudiant', async (req, res) => {
  const { id_etudiant } = req.params;

  try {
    const db = await connectionToDatabase();

    const [rows] = await db.query(`
      SELECT 
        l.nom AS licence,
        ROUND(AVG(n.moyenne), 2) AS moyenne_generale,
        CASE
          WHEN ROUND(AVG(n.moyenne), 2) >= 8 THEN 'Très Bien'
          WHEN ROUND(AVG(n.moyenne), 2) >= 7 THEN 'Bien'
          WHEN ROUND(AVG(n.moyenne), 2) >= 6 THEN 'Assez Bien'
          WHEN ROUND(AVG(n.moyenne), 2) >= 5 THEN 'Passable'
          ELSE 'Médiocre'
        END AS mention
      FROM 
        note n
      INNER JOIN matiere m ON n.id_matiere = m.id
      INNER JOIN licence l ON m.id_licence = l.id
      WHERE n.id_etudiant = ?
      GROUP BY 
        l.id
      ORDER BY 
        l.id;
    `, [id_etudiant]);

    res.json(rows);
  } catch (error) {
    console.error('Erreur lors de la récupération des moyennes :', error);
    res.status(500).json({ error: 'Erreur serveur' });
  }
});

// Route 2 : Meilleure matière par Licence pour un étudiant spécifique
router.get('/licences/top-matiere/:id_etudiant', async (req, res) => {
  const { id_etudiant } = req.params;

  try {
    const db = await connectionToDatabase();

    const [rows] = await db.query(`
      SELECT 
        l.nom AS licence,
        m.nom AS matiere,
        MAX(n.moyenne) AS meilleure_note
      FROM 
        note n
      INNER JOIN matiere m ON n.id_matiere = m.id
      INNER JOIN licence l ON m.id_licence = l.id
      WHERE n.id_etudiant = ?
      GROUP BY 
        l.id, m.nom
      ORDER BY 
        l.id;
    `, [id_etudiant]);

    res.json(rows);
  } catch (error) {
    console.error('Erreur lors de la récupération des meilleures matières :', error);
    res.status(500).json({ error: 'Erreur serveur' });
  }
});

export default router;