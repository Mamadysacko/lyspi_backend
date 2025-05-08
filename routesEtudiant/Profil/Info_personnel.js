import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';

const router = express.Router();

// Route GET : Récupérer les infos d'un étudiant par ID
router.get('/etudiant_info/:id', async (req, res) => {
    const etudiantId = parseInt(req.params.id, 10);

    if (isNaN(etudiantId)) {
        console.warn('ID invalide fourni:', req.params.id);
        return res.status(400).json({ message: 'ID invalide' });
    }

    console.log(`Tentative de récupération des données de l'étudiant avec ID ${etudiantId}...`);

    try {
        const db = await connectionToDatabase();

        if (!db) {
            return res.status(500).json({ message: 'Échec de la connexion à la base de données.' });
        }

        const [rows] = await db.execute(`
            SELECT 
                e.id AS id_etudiant, 
                e.matricule, 
                e.nom, 
                e.prenom, 
                e.sexe, 
                e.date_naissance, 
                e.lieu_naissance, 
                e.nom_pere, 
                e.nom_mere, 
                e.nationalite, 
                e.situation_matrimoniale, 
                e.date_inscription,
                d.nom AS departement, 
                l.nom AS licence, 
                c.tel, 
                c.email, 
                a.commune, 
                a.quartier
            FROM etudiant e
            LEFT JOIN departement d ON e.id_departement = d.id
            LEFT JOIN licence l ON e.id_licence = l.id
            LEFT JOIN contact c ON e.id_contact = c.id
            LEFT JOIN adresse a ON e.id = a.id_etudiant
            WHERE e.id = ?
        `, [etudiantId]);

        if (rows.length === 0) {
            console.warn(`Aucun étudiant trouvé avec l'ID ${etudiantId}`);
            return res.status(404).json({ message: 'Étudiant non trouvé' });
        }

        console.log(`Données de l'étudiant ${etudiantId} récupérées avec succès.`);

        res.json({
            id: rows[0].id_etudiant, // 👈 frontend attend `id`, donc on peut le mapper ici
            matricule: rows[0].matricule,
            nom: rows[0].nom,
            prenom: rows[0].prenom,
            sexe: rows[0].sexe,
            date_naissance: rows[0].date_naissance,
            lieu_naissance: rows[0].lieu_naissance,
            nom_pere: rows[0].nom_pere,
            nom_mere: rows[0].nom_mere,
            nationalite: rows[0].nationalite,
            situation_matrimoniale: rows[0].situation_matrimoniale,
            date_inscription: rows[0].date_inscription,
            departement: rows[0].departement,
            licence: rows[0].licence,
            tel: rows[0].tel,
            email: rows[0].email,
            adresse: rows[0].commune,
            quartier: rows[0].quartier
        });

    } catch (err) {
        console.error(`Erreur lors de la récupération des données pour l'étudiant ${etudiantId}:`, err);
        res.status(500).json({ message: 'Erreur interne lors de la récupération des données.' });
    }
});

router.put('/etudiant_infomodif/:id', async (req, res) => {
    const etudiantId = parseInt(req.params.id, 10);

    if (isNaN(etudiantId)) {
        console.warn('ID invalide fourni:', req.params.id);
        return res.status(400).json({ message: 'ID invalide' });
    }

    const { tel, email, commune, quartier } = req.body;

    if (!tel && !email && !commune && !quartier) {
        return res.status(400).json({ message: 'Aucun champ à mettre à jour.' });
    }

    try {
        const db = await connectionToDatabase();

        if (!db) {
            return res.status(500).json({ message: 'Échec de la connexion à la base de données.' });
        }

        // Met à jour les infos de contact
        if (tel || email) {
            const fieldsContact = [];
            const valuesContact = [];

            if (tel) {
                fieldsContact.push('tel = ?');
                valuesContact.push(tel);
            }
            if (email) {
                fieldsContact.push('email = ?');
                valuesContact.push(email);
            }

            const sqlContact = `
                UPDATE contact
                SET ${fieldsContact.join(', ')}
                WHERE id = (SELECT id_contact FROM etudiant WHERE id = ?)
            `;
            valuesContact.push(etudiantId);

            console.log('Requête SQL pour contact:', sqlContact);
            console.log('Valeurs pour contact:', valuesContact);

            await db.execute(sqlContact, valuesContact);
        }

        // Met à jour l'adresse
        if (commune || quartier) {
            const fieldsAdresse = [];
            const valuesAdresse = [];

            if (commune) {
                fieldsAdresse.push('commune = ?');
                valuesAdresse.push(commune);
            }
            if (quartier) {
                fieldsAdresse.push('quartier = ?');
                valuesAdresse.push(quartier);
            }

            const sqlAdresse = `
                UPDATE adresse
                SET ${fieldsAdresse.join(', ')}
                WHERE id_etudiant = ?
            `;
            valuesAdresse.push(etudiantId);

            console.log('Requête SQL pour adresse:', sqlAdresse);
            console.log('Valeurs pour adresse:', valuesAdresse);

            await db.execute(sqlAdresse, valuesAdresse);
        }

        res.json({ message: 'Informations mises à jour avec succès.' });
    } catch (err) {
        console.error(`Erreur lors de la mise à jour des données pour l'étudiant ${etudiantId}:`, err);
        res.status(500).json({ message: 'Erreur interne lors de la mise à jour des données.' });
    }
});


export default router;
