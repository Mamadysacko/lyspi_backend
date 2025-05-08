import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';
import nodemailer from 'nodemailer';

const router = express.Router();

// Création du transporteur pour l'email avec Nodemailer
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'sacko2120@gmail.com',
    pass: 'qzij pgak kahn owkl', // Utilisez un mot de passe ou une clé d'application sécurisée
  },
});

// Fonction pour envoyer un message de contact
router.post('/sendContactMessage', async (req, res) => {
  const { id, objet, message } = req.body;

  // Vérifier si les informations nécessaires sont présentes
  if (!id || !objet || !message) {
    return res.status(400).json({ message: 'Tous les champs sont requis.' });
  }

  try {
    const db = await connectionToDatabase();

    // Récupération des informations de l'étudiant à partir de son ID
    const [rows] = await db.query(
      'SELECT e.matricule, e.nom, e.prenom, c.tel, c.email FROM etudiant e LEFT JOIN contact c ON e.id_contact = c.id WHERE e.id = ?',
      [id]
    );

    if (rows.length === 0) {
      return res.status(404).json({ message: "Étudiant introuvable." });
    }

    const student = rows[0];
    const { matricule, nom, prenom, tel, email: studentEmail } = student;

    // Création du contenu HTML pour l'email
    const htmlContent = `
      <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f9f9f9; padding: 20px; border-radius: 10px; color: #2c3e50; line-height: 1.8; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); max-width: 600px;">
  <h2 style="color: #2980b9;">Message d’un étudiant – LYSPI</h2>
  <p><strong>Nom :</strong> ${nom} ${prenom}</p>
  <p><strong>Matricule :</strong> ${matricule}</p>
  <p><strong>Téléphone :</strong> ${tel}</p>
  <p><strong>Objet :</strong> <em>${objet}</em></p>
  <p><strong>Message :</strong></p>
  <div style="background-color: #ecf0f1; padding: 15px; border-radius: 5px; margin-top: 5px;">
    ${message}
  </div>
</div>

    `;

    // Envoi de l'email
    await transporter.sendMail({
      from: 'sacko2120@gmail.com',
      to: `${studentEmail}`, // Destinataire
      subject: `Message de ${nom} ${prenom} - ${objet}`,
      html: htmlContent,
    });

    // Réponse du serveur
    res.status(200).json({ message: 'Message envoyé avec succès.' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erreur serveur. Réessayez plus tard." });
  }
});

export default router;
