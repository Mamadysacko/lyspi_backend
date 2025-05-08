import express from 'express';
import { connectionToDatabase } from '../lib/db.js';

const router = express.Router();

// Route pour créer un compte entreprise
router.post('/creer-entreprise', async (req, res) => {
  const { nom_entreprise, mail, user, mot_de_passe, id_admin } = req.body;

  // Validation des données reçues
  if (!nom_entreprise || !mail || !user || !mot_de_passe || !id_admin) {
    return res.status(400).json({ message: 'Tous les champs sont obligatoires' });
  }

  try {
    // Connexion à la base de données
    const db = await connectionToDatabase();
    

    // Préparation de la requête SQL
    const query = `
      INSERT INTO entreprise (nom_entreprise, mail, user, mot_de_passe, id_admin)
      VALUES (?, ?, ?, ?, ?)
    `;
    const values = [nom_entreprise, mail, user, mot_de_passe, id_admin];

    // Exécution de la requête
    const [result] = await db.query(query, values);

    // Réponse de succès
    return res.status(201).json({
      message: 'Entreprise créée avec succès',
      entrepriseId: result.insertId,
    });
  } catch (error) {
    console.error('Erreur lors de la création de l\'entreprise :', error);
    return res.status(500).json({ message: 'Erreur serveur' });
  }
});

export default router;
