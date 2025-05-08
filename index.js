// backend/index.js

import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';
import morgan from 'morgan';

// Résoudre __dirname en ES module
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);


dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(morgan((tokens, req, res) => {
  return [
    tokens.method(req, res), // Méthode HTTP (GET, POST, etc.)
    tokens.url(req, res),    // URL de la requête
    tokens.status(req, res), // Statut HTTP
 
  ].join(' ');
}));

// Servir les fichiers statiques (images, docs, etc.)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
app.use('/uploads', express.static(path.join(__dirname, 'public', 'uploads')));


// Importation des routes etudiant
import inscripEtudiantRoutes from './routesEtudiant/connexion/inscrip_etudiant_route.js';
import confirmationRoutes from './routesEtudiant/connexion/confirmation_route.js';
import MotdepasseRoutes from './routesEtudiant/connexion/Motdepasse.js';
import loginEtudiantRoutes from './routesEtudiant/connexion/login_etudiant_route.js';
import PersonalInfoRoutes from './routesEtudiant/Profil/Info_personnel.js';
import DocumentsRoutes from './routesEtudiant/Profil/Documents.js';
import Cert_attestationRoutes from './routesEtudiant/Profil/Attestation.js';
import etudiantPhotoRoutes from './routesEtudiant/Profil/Profil_photo.js';
import experienceRoutes from './routesEtudiant/Profil/experience.js';
import statut_etudiant from './routesEtudiant/Profil/Statut_emploi.js';
import performence from './routesEtudiant/Profil/performence.js';
import startupRoutes from './routesEtudiant/startup/startup.js';
import contacterRoutes from './routesEtudiant/Profil/contacter.js';
import getoffre from './routesEtudiant/offre/get_offres_route.js';
import aimer from './routesEtudiant/offre/aimer.js';
import postuler from './routesEtudiant/offre/postuler.js';  
import commentaires from './routesEtudiant/offre/commentaires.js';

// Importation des routes entreprise
import PasseOublie from './routesEntreprise/PasseOublie.js';
import login_entrepriseRoutes from './routesEntreprise/login_entreprise_route.js';
import pub_formationsRoutes from './routesEntreprise/pub_formations.js';
import pub_offre_emploiRoutes from './routesEntreprise/pub_offre_emploi.js';
import startup_Routes from './routesEntreprise/startup/afficher_startup.js';
import  profil  from './routesEntreprise/profil.js';
import  contact_entrepriseRoutes  from './routesEntreprise/contacter.js';


// Importation des routes admin
import PasseOublie_admin from './routesAdmin/PasseOublie_admin.js';
import login_adminRoutes from './routesAdmin/login_admin.js';
import creation_entrepriseRoutes from './routesAdmin/creation_entreprise.js';
import envoi_creation_entreprise from './routesAdmin/message_creation.js';
// Préfixe d'API
const apiPrefix = '/api';

// Enregistrement des routes
app.use(apiPrefix, inscripEtudiantRoutes);
app.use(apiPrefix, confirmationRoutes);
app.use(apiPrefix, MotdepasseRoutes);
app.use(apiPrefix, loginEtudiantRoutes);
app.use(apiPrefix, PersonalInfoRoutes);
app.use(apiPrefix, DocumentsRoutes);
app.use(apiPrefix, Cert_attestationRoutes);
app.use(apiPrefix, PasseOublie);
app.use(apiPrefix, PasseOublie_admin);
app.use(apiPrefix, etudiantPhotoRoutes);
app.use(apiPrefix, experienceRoutes);
app.use(apiPrefix, statut_etudiant);
app.use(apiPrefix, performence);
app.use(apiPrefix, startupRoutes);
app.use(apiPrefix, login_entrepriseRoutes);
app.use(apiPrefix, pub_formationsRoutes);
app.use(apiPrefix, pub_offre_emploiRoutes);
app.use(apiPrefix, contacterRoutes);
app.use(apiPrefix, startup_Routes);
app.use(apiPrefix, login_adminRoutes);
app.use(apiPrefix, creation_entrepriseRoutes);
app.use(apiPrefix, envoi_creation_entreprise);
app.use(apiPrefix, profil);
app.use(apiPrefix, getoffre);
app.use(apiPrefix, contact_entrepriseRoutes);
app.use(apiPrefix, postuler);
app.use(apiPrefix, aimer);
app.use(apiPrefix, commentaires);
// Route 404 (optionnelle)
app.use((req, res) => {
  res.status(404).json({ message: 'Route non trouvée' });
});

// Démarrage du serveur
app.listen(PORT, () => {
  console.log(`[INFO] Serveur démarré sur le port ${PORT}`);
});
