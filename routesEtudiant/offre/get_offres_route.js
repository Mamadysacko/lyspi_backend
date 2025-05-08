// routes/etudiant/get_offres_route.js

import express from 'express';
import { connectionToDatabase } from '../../lib/db.js';

const router = express.Router();

router.get('/get_offres', async (req, res) => {
  try {
      const db = await connectionToDatabase();

      const [results] = await db.query(`
          SELECT 
              o.id AS offre_id,
              o.poste,
              o.description,
              o.competences,
              o.date_debut,
              o.date_limite,
              o.contact,
              o.tags,
              o.fichier,
              toffre.nom AS type_offre_nom,

              e.id AS entreprise_id,
              e.nom_complet_user,
              e.sigle,
              e.description AS entreprise_description,
              e.nom_entreprise,
              e.mail,
              e.tel,
              e.site_web,
              e.logo,
              e.domaine_intervention,
              t.nom AS type_entreprise_nom,
              s.nom AS secteur_geographique_nom,
              d.nom AS domaine_entreprise_nom

          FROM offres o
          LEFT JOIN entreprise e ON o.id_entreprise = e.id
          LEFT JOIN type_offre toffre ON o.id_type_offre = toffre.id
          LEFT JOIN type_entreprise t ON e.id_type_entreprise = t.id
          LEFT JOIN secteur_geographique s ON e.id_secteur_geographique = s.id
          LEFT JOIN domaine_entreprise d ON e.id_domaine_entreprise = d.id
      `);

      if (results.length === 0) {
          return res.status(404).json({ message: "Aucune offre trouvée" });
      }

      const BASE_URL = (process.env.BASE_URL || 'http://localhost:3000').replace('/api', '');

      const formatted = results.map(row => ({
          offre: {
              id: row.offre_id,
              poste: row.poste,
              description: row.description,
              competences: row.competences,
              date_debut: row.date_debut,
              date_limite: row.date_limite,
              contact: row.contact,
              tags: row.tags,
              fichier_url: row.fichier ? `${BASE_URL}/${row.fichier}` : null,
              type_offre: row.type_offre_nom
          },
          entreprise: {
              id: row.entreprise_id,
              nom_complet_user: row.nom_complet_user,
              sigle: row.sigle,
              description: row.entreprise_description,
              nom_entreprise: row.nom_entreprise,
              mail: row.mail,
              tel: row.tel,
              site_web: row.site_web,
              logo_url: row.logo ? `${BASE_URL}${row.logo}` : null,
              domaine_intervention: row.domaine_intervention,
              type_entreprise: row.type_entreprise_nom,
              secteur_geographique: row.secteur_geographique_nom,
              domaine_entreprise: row.domaine_entreprise_nom
          }
      }));

      res.status(200).json(formatted);
  } catch (error) {
      console.error('Erreur serveur :', error);
      res.status(500).json({ message: 'Erreur serveur' });
  }
});


export default router;
