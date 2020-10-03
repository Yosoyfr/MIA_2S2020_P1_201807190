import { Request, Response } from "express";
import { connect } from "../database";

class ModelController {
  constructor() {}

  public async deleteDataTemporaryTable(req: Request, res: Response) {
    const conn = await connect();
    await conn.query(
      `
      TRUNCATE TABLE temporal
    `,
      (err, result) => {
        if (err) res.json({ error: "Error 404" });
        res.send({ message: "The temporary table was dropped" });
      }
    );
  }

  public async deleteModel(req: Request, res: Response) {
    const conn = await connect();
    await conn.query(
      `
      CALL prueba.eliminarModelo()
    `,
      (err, result) => {
        if (err) res.json({ error: "Error 404" });
        res.send({ message: "The model was dropped" });
      }
    );
  }

  public async loadDataInTemporaryTable(req: Request, res: Response) {
    const conn = await connect();
    await conn.query(`
      TRUNCATE TABLE temporal
    `);
    await conn.query(
      `
      LOAD DATA LOCAL INFILE '/home/yosoyfr/Descargas/DataCenterData.csv'
      INTO TABLE temporal
      FIELDS TERMINATED BY ';'
      LINES TERMINATED BY '\n'
      IGNORE 1 LINES
      (nombre_compania,contacto_compania,correo_compania,telefono_compania,tipo,nombre,correo,telefono,@FECHA,direccion,ciudad,codigo_postal,region,producto,categoria_producto,cantidad,precio_unitario)
      SET fecha_registro = STR_TO_DATE(@FECHA,'%d/%m/%Y')
    `,
      (err, result) => {
        if (err) res.json({ error: "Error 404" });
        res.send({ message: "The data is loaded in the temporary table" });
      }
    );
  }

  public async loadDataInModel(req: Request, res: Response) {
    const conn = await connect();
    await conn.query(`
      CALL prueba.eliminarModelo()
    `);
    await conn.query(
      `
      CALL prueba.cargarModelo()
    `,
      (err, result) => {
        if (err) res.json({ error: "Error 404" });
        res.send({ message: "The data is loaded in the model" });
      }
    );
  }
}

const temporaryController = new ModelController();

export default temporaryController;
