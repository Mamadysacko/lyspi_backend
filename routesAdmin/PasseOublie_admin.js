// routes/passwordReset.js
import express from 'express';
import { connectionToDatabase } from '../lib/db.js';
import { sendConfirmationCode } from '../lib/Admin/mail_PasseOublie_admin.js';
import { sendPasswordUpdatedEmail } from '../lib/Admin/mail_PasseOublie_admin.js';

const router = express.Router();

// Étape 1 : Envoi du code par email
router.post('/admin/sendcode', sendConfirmationCode);

// Étape 2 : Vérification du code
router.get('/admin/verifycode', async (req, res) => {
  const { mail, code } = req.query;

  if (!mail || !code) {
    return res.status(400).json({ message: "Email et code requis." });
  }

  try {
    const db = await connectionToDatabase();
    const [rows] = await db.query(
      'SELECT * FROM admin WHERE mail = ? AND code_confirmation = ?',
      [mail, code]
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
router.post('/admin/updatepassword', async (req, res) => {
  const { mail, code, password } = req.body;

  if (!mail || !code || !password) {
    return res.status(400).json({ error: "Champs manquants." });
  }

  try {
    const db = await connectionToDatabase();

    const [rows] = await db.query(
      `SELECT * FROM admin WHERE mail = ? AND code_confirmation = ?`,
      [mail, code]
    );

    if (rows.length === 0) {
      return res.status(400).json({ error: "Code invalide ou expiré." });
    }

    await db.query(
      `UPDATE admin SET mot_de_passe = ?, code_confirmation = NULL WHERE mail = ?`,
      [password, mail]
    );

    // Envoi de l'email de confirmation
    await sendPasswordUpdatedEmail(mail);

    res.json({ message: "Mot de passe mis à jour avec succès." });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Erreur serveur. Veuillez réessayer plus tard." });
  }
});

export default router;