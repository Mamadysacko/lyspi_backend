import express from 'express';
import { connectionToDatabase } from '../../lib/db.js'; // Import de la fonction de connexion à la base de données

const router = express.Router();

router.post('/etudiant_login', async (req, res) => {
  console.log('[INFO] Requête reçue pour la connexion');

  // Vérification si le corps de la requête est vide
  if (!req.body) {
    console.error('[ERROR] Le corps de la requête est vide');
    return res.status(400).json({ message: "Le corps de la requête est vide" });
  }

  const { user, password } = req.body;

  // Vérification des champs requis
  if (!user || !password) {
    console.error('[ERROR] Nom d\'utilisateur ou mot de passe manquant');
    return res.status(400).json({ message: "Nom d'utilisateur et mot de passe sont requis" });
  }

  try {
    console.log(`[INFO] Connexion à la base de données pour l'utilisateur: ${user}`);

    const db = await connectionToDatabase();
    const [userRows] = await db.query(
      'SELECT * FROM inscrip_etudiant WHERE user = ? AND mot_de_passe = ? AND email_confirme = 1',
      [user, password]
    );

    // Vérification si l'utilisateur existe et si les informations sont correctes
    if (userRows.length === 0) {
      console.warn(`[WARN] Utilisateur non trouvé ou informations incorrectes : ${user}`);
      return res.status(400).json({ message: "Nom d'utilisateur, mot de passe " });
    }

    console.log(`[INFO] Utilisateur trouvé et confirmé : ${JSON.stringify(userRows[0])}`);

    // Stockage et affichage de l'id_etudiant
    const idEtudiant = userRows[0].id_etudiant;
    console.log(`[INFO] ID étudiant : ${idEtudiant}`);

    res.status(200).json({ 
      message: "Connexion réussie",
      id_etudiant: idEtudiant // Retourne uniquement l'id_etudiant
    });
  } catch (error) {
    console.error('[ERROR] Erreur serveur:', error);
    res.status(500).json({ message: 'Erreur du serveur, veuillez réessayer plus tard' });
  }
});

export default router;