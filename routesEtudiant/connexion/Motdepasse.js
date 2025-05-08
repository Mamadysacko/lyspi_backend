// routes/passwordReset.js
import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';
import { sendConfirmationCode } from '../../lib/Etudiant/mail_motPasse.js';
import { sendPasswordUpdatedEmail } from '../../lib/Etudiant/mail_motPasse.js';
// Assurez-vous que cette fonction est exportée

const router = express.Router();

// Étape 1 : Envoi du code par email
router.post('/sendcode', sendConfirmationCode);

// Étape 2 : Vérification du code
router.get('/verifycode', async (req, res) => {
  const { email, code } = req.query;

  if (!email || !code) {
    return res.status(400).json({ message: "Email et code requis." });
  }

  try {
    const db = await connectionToDatabase();
    const [rows] = await db.query(
      'SELECT * FROM inscrip_etudiant WHERE email = ? AND code_confirmation = ?',
      [email, code]
    );

    if (rows.length === 0) {
      return res.status(400).json({ message: "Code invalide ou expiré." });
    }

    res.json({ message: "Code validé avec succès." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erreur serveur." });
  }
});

// Étape 3 : Mise à jour du mot de passe

router.post('/updatepassword', async (req, res) => {
  const { email, code, password } = req.body;

  if (!email || !code || !password) {
    return res.status(400).json({ error: "Champs manquants." });
  }

  try {
    const db = await connectionToDatabase();

    const [rows] = await db.query(
      `SELECT * FROM inscrip_etudiant WHERE email = ? AND code_confirmation = ?`,
      [email, code]
    );

    if (rows.length === 0) {
      return res.status(400).json({ error: "Code invalide ou expiré." });
    }

    // Hash du mot de passe avant de le stocker

    await db.query(
      `UPDATE inscrip_etudiant SET mot_de_passe = ?, code_confirmation = NULL WHERE email = ?`,
      [password, email]
    );

    // Envoi de l'email de confirmation
    await sendPasswordUpdatedEmail(email);

    res.json({ message: "Mot de passe mis à jour avec succès." });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Erreur serveur. Veuillez réessayer plus tard." });
  }

});

export default router;
