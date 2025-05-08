import nodemailer from 'nodemailer';

export const generateConfirmationCode = () => {
  return Math.floor(10000 + Math.random() * 90000).toString(); // Code de 5 chiffres
};

export const sendConfirmationEmail = async (email, code) => {
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'sacko2120@gmail.com',
      pass: 'qzij pgak kahn owkl' // Remplace par ton mot de passe d'application
    }
  });

  const mailOptions = {
    from: 'sacko2120@gmail.com',
    to: email,
    subject: 'Votre code de confirmation - LYPI (UNC)',
    html: `
      <div style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;">
        <p>Bonjour,</p>
        <p>
          Merci de vous être inscrit(e) à <strong>LYPI</strong> (Insertion des Étudiants dans la Vie Professionnelle) au compte de <strong>UNC</strong>.
        </p>
        <p>
          Pour finaliser votre inscription, veuillez entrer le code de confirmation suivant :
        </p>
        <p style="font-size: 20px; font-weight: bold; color: #007BFF;">Code : ${code}</p>
        <p>
          Ce code est valide pour une durée limitée. Si vous n’êtes pas à l’origine de cette demande, vous pouvez ignorer ce message.
        </p>
        <p>
          L’équipe <strong>LYPI (UNC)</strong> vous souhaite la bienvenue et vous remercie de votre confiance.
        </p>
        <p>Cordialement,<br>L’équipe LYPI</p>
      </div>
    `
  };

  try {
    await transporter.sendMail(mailOptions);
  } catch (err) {
    console.error("Erreur lors de l'envoi de l'email : ", err);
    throw err;
  }
};
