import express from 'express';
import nodemailer from 'nodemailer';

const router = express.Router();

// Transporteur de mail
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'sacko2120@gmail.com',
    pass: 'qzij pgak kahn owkl', // Utiliser un mot de passe d'application sécurisé
  },
});

// Envoi d'email sans base de données
router.post('/envoi/EntrepriseInfo', async (req, res) => {
  const { nom_entreprise, mail, user, mot_de_passe } = req.body;

  // Vérification des champs obligatoires
  if (!nom_entreprise || !mail || !user || !mot_de_passe) {
    return res.status(400).json({ message: 'Tous les champs sont requis.' });
  }

  try {
    // Contenu de l'email
    const htmlContent = `
      <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f9f9f9; padding: 20px; border-radius: 10px; color: #2c3e50; line-height: 1.8; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); max-width: 600px;">
        <h2 style="color: #2980b9;">Création de votre compte entreprise – LYSPI</h2>
        <p>Bonjour,</p>
        <p>Votre compte entreprise a été créé avec succès sur la plateforme <strong>LYSPI</strong>. Veuillez trouver ci-dessous les informations de connexion de votre entreprise :</p>
        <p><strong>Nom de l'entreprise :</strong> ${nom_entreprise}</p>
        <p><strong>Email :</strong> ${mail}</p>
        <p><strong>Nom d'utilisateur :</strong> ${user}</p>
        <p><strong>Mot de passe provisoire :</strong> ${mot_de_passe}</p>
  
        <p style="color: #e74c3c;"><strong>⚠️ Pour des raisons de sécurité, il est impératif que vous changiez ce mot de passe et voir même user aussi dès votre première connexion.</strong></p>
  
        <p>Nous vous remercions pour votre confiance et restons disponibles pour toute assistance complémentaire.</p>
        <p style="margin-top: 30px;">Cordialement,<br>L’équipe LYSPI</p>
      </div>
    `;
  
    await transporter.sendMail({
      from: 'sacko2120@gmail.com',
      to: mail,
      subject: `Informations de votre compte entreprise - ${nom_entreprise}`,
      html: htmlContent,
    });
  
    res.status(200).json({ message: 'Email envoyé avec succès.' });
  }
   catch (error) {
    console.error('Erreur lors de l\'envoi de l\'email :', error);
    res.status(500).json({ message: 'Erreur lors de l\'envoi de l\'email.' });
  }
});

export default router;
