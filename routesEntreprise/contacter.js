import express from 'express';
import { connectionToDatabase } from '../lib/db.js';
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
router.post('/entreprise/sendContactMessage', async (req, res) => {
  const { id, objet, message } = req.body;

  // Vérifier si les informations nécessaires sont présentes
  if (!id || !objet || !message) {
    return res.status(400).json({ message: 'Tous les champs sont requis.' });
  }

  try {
    const db = await connectionToDatabase();

    // Récupération des informations de l'entreprise à partir de son ID
    const [rows] = await db.query(
      'SELECT nom_complet_user, description, nom_entreprise, mail, tel, site_web FROM entreprise WHERE id = ?',
      [id]
    );

    if (rows.length === 0) {
      return res.status(404).json({ message: "Entreprise introuvable." });
    }

    const entreprise = rows[0];
    const { nom_complet_user, description, nom_entreprise, mail, tel, site_web } = entreprise;

    // Création du contenu HTML pour l'email
    const htmlContent = `
      <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f9f9f9; padding: 20px; border-radius: 10px; color: #2c3e50; line-height: 1.8; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); max-width: 600px;">
        <h2 style="color: #2980b9;">Message d’une entreprise – LYSPI</h2>
        <p><strong>Nom complet de l'utilisateur :</strong> ${nom_complet_user}</p>
        <p><strong>Nom de l'entreprise :</strong> ${nom_entreprise}</p>
        <p><strong>Description :</strong></p>
        <div style="background-color: #ecf0f1; padding: 15px; border-radius: 5px; margin-top: 5px;">
          ${description}
        </div>
        <p><strong>Email :</strong> ${mail}</p>
        <p><strong>Téléphone :</strong> ${tel}</p>
        <p><strong>Site web :</strong> ${site_web}</p>
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
      to: mail, // Destinataire (email de l'entreprise)
      subject: `Message de ${nom_complet_user} - ${objet}`,
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