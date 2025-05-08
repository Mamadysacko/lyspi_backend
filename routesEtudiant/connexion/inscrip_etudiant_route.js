import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';
import { sendConfirmationEmail, generateConfirmationCode } from '../../lib/Etudiant/mail_creation.js';
// Mise à jour : maintenant génère un code

const router = express.Router();

router.post('/inscrip_etudiant', async (req, res) => {
  const { matricule, email, user, password } = req.body;

  try {
    const db = await connectionToDatabase();

    // Vérification de l'existence de l'étudiant
    const [etudiantRows] = await db.query(
      `SELECT e.id AS id_etudiant, e.matricule
       FROM etudiant e
       JOIN contact c ON e.id_contact = c.id
       WHERE e.matricule = ? AND c.email = ?`,
      [matricule, email]
    );

    if (etudiantRows.length === 0) {
      return res.status(400).json({ message: "Aucun étudiant trouvé avec ce matricule et cet email" });
    }

    const id_etudiant = etudiantRows[0].id_etudiant;

    // Vérification si déjà inscrit
    const [existingUser] = await db.query(
      'SELECT * FROM inscrip_etudiant WHERE matricule = ? OR email = ?',
      [matricule, email]
    );

    if (existingUser.length > 0) {
      return res.status(400).json({ message: "Cet étudiant est déjà inscrit ou l'email est déjà utilisé" });
    }

    // Génération d’un code de confirmation à 5 chiffres
    const code = generateConfirmationCode(); // génère un code à 5 chiffres

    await sendConfirmationEmail(email, code);

    // Insertion de l'inscription avec le code
    await db.query(
      `INSERT INTO inscrip_etudiant (id_etudiant, matricule, email, user, mot_de_passe, code_confirmation)
       VALUES (?, ?, ?, ?, ?, ?)`,
      [id_etudiant, matricule, email, user, password, code]
    );

    // Création du document lié
    await db.query(
      `INSERT INTO document (id_etudiant)
       VALUES (?)`,
      [id_etudiant]
    );
    await db.query(
      `INSERT INTO statut_etudiant (id_etudiant)
       VALUES (?)`,
      [id_etudiant]
    );
    // Envoi du code par email
    await sendConfirmationEmail(email, code);

    res.status(201).json({
      message: "Utilisateur créé avec succès. Veuillez vérifier votre email pour confirmer votre adresse."
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Erreur du serveur, veuillez réessayer plus tard" });
  }
});

export default router;
