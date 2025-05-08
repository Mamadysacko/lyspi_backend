import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';

const router = express.Router();

// ➡️ 3. Récupérer toutes les startups avec toutes les informations associées
router.get('/list/startups', async (req, res) => {
    try {
        const db = await connectionToDatabase();

        const [results] = await db.query(`
            SELECT 
              s.id AS startup_id,
              s.nom AS startup_nom,
              s.site_web,
              s.date_creation,
              s.description,
              s.problematique,
              s.solution,
              s.fichier,
              d.nom AS domaine_nom,
              e.id AS etudiant_id,
              e.matricule,
              e.nom AS etudiant_nom,
              e.prenom AS etudiant_prenom,
              e.sexe,
              e.date_inscription,
              c.tel AS contact_tel,
              c.email AS contact_email,
              l.nom AS licence_nom,
              f.nom AS faculte_nom
            FROM startup s
            JOIN domaine d ON s.id_domaine = d.id
            JOIN etudiant e ON s.id_etudiant = e.id
            LEFT JOIN contact c ON e.id_contact = c.id
            JOIN licence l ON e.id_licence = l.id
            JOIN faculte f ON e.id_departement = f.id
        `);

        if (results.length === 0) {
            return res.status(404).json({ message: "Aucune startup trouvée" });
        }
        

        const BASE_URL = (process.env.BASE_URL || 'http://localhost:3000').replace('/api', '');

        const formatted = results.map(row => ({
            startup: {
                id: row.startup_id,
                nom: row.startup_nom,
                site_web: row.site_web,
                date_creation: row.date_creation,
                description: row.description,
                problematique: row.problematique,
                solution: row.solution,
                domaine: row.domaine_nom,
                fichier_url: row.fichier ? `${BASE_URL}/${row.fichier}` : null,
            },
            etudiant: {
                id: row.etudiant_id,
                nom: row.etudiant_nom,
                prenom: row.etudiant_prenom,
                sexe: row.sexe,
                matricule: row.matricule,
                date_inscription: row.date_inscription,
                contact: {
                    tel: row.contact_tel,
                    email: row.contact_email,
                },
                licence: row.licence_nom,
                faculte: row.faculte_nom,
            }
        }));

        res.status(200).json(formatted);
    } catch (err) {
        console.error("Erreur serveur :", err);
        res.status(500).json({ message: "Erreur serveur" });
    }
});



router.post('/startup/partenaire', async (req, res) => {
    const { startup_id, entreprise_id } = req.body;

    try {
        const db = await connectionToDatabase();

        // Vérification si le partenariat existe déjà
        const [existingPartnership] = await db.query(
            'SELECT * FROM partenaire WHERE startup_id = ? AND entreprise_id = ?',
            [startup_id, entreprise_id]
        );

        if (existingPartnership.length > 0) {
            // Si le partenariat existe déjà, renvoyer une réponse 409 (Conflit)
            return res.status(409).json({ message: 'Le partenariat existe déjà' });
        }

        // Insertion du partenariat
        await db.query(
            'INSERT INTO partenaire (startup_id, entreprise_id) VALUES (?, ?)',
            [startup_id, entreprise_id]
        );

        res.status(201).json({ message: 'Partenariat enregistré avec succès' });
    } catch (error) {
        console.error('Erreur API partenariat :', error);
        res.status(500).json({ message: 'Erreur serveur' });
    }
});
  


router.get('/entreprise/:entreprise_id/partenariats-complets', async (req, res) => {
    const { entreprise_id } = req.params;

    try {
        const db = await connectionToDatabase();
        const [rows] = await db.query(
            'SELECT startup_id FROM partenaire WHERE entreprise_id = ?',
            [entreprise_id]
        );
        res.status(200).json(rows); // chaque row = { startup_id: ... }
    } catch (error) {
        console.error('Erreur récupération des partenariats :', error);
        res.status(500).json({ message: 'Erreur serveur' });
    }
});


// Ajout de l'export par défaut
export default router;