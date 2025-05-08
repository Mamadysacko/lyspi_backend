// routes/sendCode.js
import nodemailer from 'nodemailer';
import { connectionToDatabase } from '../db.js';

export const generateCode = () => {
  return Math.floor(10000 + Math.random() * 90000).toString(); // 5 chiffres
};

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'sacko2120@gmail.com',
    pass: 'qzij pgak kahn owkl',
  },
});

export async function sendConfirmationCode(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Méthode non autorisée' });
  }

  const { email } = req.body;
  if (!email) return res.status(400).json({ message: 'Email requis' });

  const code = generateCode();

  try {
    const db = await connectionToDatabase();

    // Vérifie si l’utilisateur existe
    const [rows] = await db.query(
      'SELECT * FROM inscrip_etudiant WHERE email = ?',
      [email]
    );

    if (rows.length === 0) {
      return res.status(404).json({ message: "Utilisateur introuvable." });
    }

    // Mise à jour du code dans la base
    await db.query(
      'UPDATE inscrip_etudiant SET code_confirmation = ? WHERE email = ?',
      [code, email]
    );

    const htmlContent = `
      <div style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;">
        <p>Bonjour,</p>
        <p>Voici votre code de vérification pour réinitialiser votre mot de passe sur <strong>LYPI</strong> :</p>
        <p style="font-size: 24px; font-weight: bold; color: #007BFF;">${code}</p>
        <p>Ce code expirera bientôt.</p>
        <p>— L’équipe LYPI</p>
      </div>
    `;

    await transporter.sendMail({
      from: 'sacko2120@gmail.com',
      to: email,
      subject: 'Code de vérification - LYPI',
      html: htmlContent,
    });

    res.status(200).json({ message: 'Code envoyé par email.' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erreur serveur. Réessayez plus tard." });
  }
}

export async function sendPasswordUpdatedEmail(email) {
  if (!email) {
    console.error('Email requis pour envoyer la notification.');
    return;
  }

  try {
    const db = await connectionToDatabase();

    // Requête pour récupérer les informations de l'utilisateur
    const [rows] = await db.query(
      'SELECT user FROM inscrip_etudiant WHERE email = ?',
      [email]
    );

    if (rows.length === 0) {
      console.error("Utilisateur introuvable pour l'email :", email);
      return;
    }

    const userName = rows[0].user; // Récupération du nom de l'utilisateur

    const htmlContent = `
      <div style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;">
        <p>Bonjour ${userName},</p>
        <p>Votre mot de passe a été réinitialisé avec succès sur <strong>LYPI</strong>.</p>
        <p>Si vous n'êtes pas à l'origine de cette modification, veuillez nous contacter immédiatement.</p>
        <p>— L’équipe LYPI</p>
      </div>
    `;

    await transporter.sendMail({
      from: 'sacko2120@gmail.com',
      to: email,
      subject: 'Confirmation de réinitialisation de mot de passe - LYPI',
      html: htmlContent,
    });

    console.log('Email de confirmation envoyé avec succès à', userName);
  } catch (error) {
    console.error('Erreur lors de l’envoi de l’email de confirmation :', error);
  }
}