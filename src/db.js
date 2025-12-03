import mysql from "mysql2/promise";
import dotenv from "dotenv";

dotenv.config();

let connection;

export async function getConnection() {
  try {
    if (!connection) {
      console.log("Tentando conectar ao banco...");
      connection = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASS,
        database: process.env.DB_NAME,
      });
      console.log("Conectado ao banco de dados!");
    }
    return connection;
  } catch (err) {
    console.error("Erro ao conectar:", err.message);
    process.exit(1);
  }
}
