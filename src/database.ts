import mysql from "mysql";

export async function connect() {
  const connection = await mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "12345",
    database: "prueba",
  });
  return connection;
}
