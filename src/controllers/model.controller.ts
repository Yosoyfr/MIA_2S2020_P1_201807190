import { Request, Response } from "express";

class ModelController {
  constructor() {}

  public async deleteTemporaryTable(
    req: Request,
    res: Response
  ): Promise<Response> {
    return res.json("Delete Temporary Table");
  }

  public async deleteModel(req: Request, res: Response): Promise<Response> {
    return res.json("Delete Model");
  }

  public async loadDataInTemporaryTable(
    req: Request,
    res: Response
  ): Promise<Response> {
    return res.json("Load Data in temporary table");
  }

  public async loadDataInModel(req: Request, res: Response): Promise<Response> {
    return res.json("Load Data in model");
  }
}

const temporaryController = new ModelController();

export default temporaryController;
