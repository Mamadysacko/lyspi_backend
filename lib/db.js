import mysql from "mysql2/promise";

let connection;

export const connectionToDatabase = async () => {
    if (!connection) {
        try {
            connection = await mysql.createConnection({
                host: process.env.DB_HOST,
                user: process.env.DB_USER,
                password: process.env.DB_PASSWORD,
                database: process.env.DB_NAME,
            });

            // Tester la connexion
            await connection.ping();  // Utilise `ping` pour tester la connexion
            console.log("Connexion à la base de données réussie!"); // Afficher ce message si la connexion réussit
        } catch (err) {
            console.error("Erreur de connexion à la base de données:", err.message);
        
        }
    }
    return connection;
};
