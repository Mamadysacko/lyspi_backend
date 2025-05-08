import express from 'express';
import { connectionToDatabase } from '../../lib/db.js'; // Assurez-vous que le chemin est correct

const router = express.Router();

// Endpoint pour la confirmation de l'email avec un code à 5 chiffres
router.get('/confirm', async (req, res) => {
  const { code } = req.query; // Récupère le code de confirmation passé dans l'URL

  if (!code) {
    return res.status(400).json({ error: "Code de confirmation manquant." });
  }

  if (!/^\d{5}$/.test(code)) {
    return res.status(400).json({ error: "Code de confirmation invalide." });
  }

  try {
    const db = await connectionToDatabase();

    // Vérifier si le code existe dans la base de données
    const [rows] = await db.query(
      `SELECT * FROM inscrip_etudiant WHERE code_confirmation = ?`,
      [code]
    );

    if (rows.length === 0) {
      return res.status(400).json({ error: "Code invalide ou expiré." });
    }

    // Mise à jour : email confirmé et suppression du code
    await db.query(
      `UPDATE inscrip_etudiant 
       SET email_confirme = TRUE, code_confirmation = NULL 
       WHERE code_confirmation = ?`,
      [code]
    );

    res.json({ message: "Votre adresse e-mail a été confirmée avec succès !" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Erreur serveur. Veuillez réessayer plus tard." });
  }
});

export default router;