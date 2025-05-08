import express from 'express';
import { connectionToDatabase } from '../lib/db.js';

const router = express.Router();

// Route de connexion pour l'admin
router.post('/admin_login', async (req, res) => {
  console.log('[INFO] Requête reçue pour la connexion admin');

  if (!req.body) {
    console.error('[ERROR] Le corps de la requête est vide');
    return res.status(400).json({ message: "Le corps de la requête est vide" });
  }

  const { user, mot_de_passe } = req.body;

  if (!user || !mot_de_passe) {
    console.error('[ERROR] Nom d\'utilisateur ou mot de passe manquant');
    return res.status(400).json({ message: "Nom d'utilisateur et mot de passe requis" });
  }

  try {
    console.log(`[INFO] Connexion à la base de données pour l'admin: ${user}`);

    const db = await connectionToDatabase();
    const [rows] = await db.query(
      'SELECT * FROM admin WHERE user = ? AND mot_de_passe = ?',
      [user, mot_de_passe]
    );

    if (rows.length === 0) {
      console.warn(`[WARN] Admin non trouvé ou informations incorrectes : ${user}`);
      return res.status(400).json({ message: "Nom d'utilisateur ou mot de passe incorrect" });
    }

    const idAdmin = rows[0].id;
    console.log(`[INFO] ID admin : ${idAdmin}`);

    res.status(200).json({
      message: "Connexion admin réussie",
      id_admin: idAdmin
    });

  } catch (error) {
    console.error('[ERROR] Erreur serveur:', error);
    res.status(500).json({ message: 'Erreur du serveur, veuillez réessayer plus tard' });
  }
});

export default router;
