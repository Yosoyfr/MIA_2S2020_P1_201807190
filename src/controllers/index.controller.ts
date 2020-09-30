import { Request, Response } from "express";

class Controllers {
  constructor() {}

  public async indexWelcome(req: Request, res: Response): Promise<Response> {
    return res.json("Welcome to my API");
  }

  public async query1(req: Request, res: Response): Promise<Response> {
    return res.json("query1");
  }

  public async query2(req: Request, res: Response): Promise<Response> {
    return res.json("query2");
  }

  public async query3(req: Request, res: Response): Promise<Response> {
    return res.json("query3");
  }

  public async query4(req: Request, res: Response): Promise<Response> {
    return res.json("query4");
  }

  public async query5(req: Request, res: Response): Promise<Response> {
    return res.json("query5");
  }

  public async query6(req: Request, res: Response): Promise<Response> {
    return res.json("query6");
  }

  public async query7(req: Request, res: Response): Promise<Response> {
    return res.json("query7");
  }

  public async query8(req: Request, res: Response): Promise<Response> {
    return res.json("query8");
  }

  public async query9(req: Request, res: Response): Promise<Response> {
    return res.json("query9");
  }

  public async query10(req: Request, res: Response): Promise<Response> {
    return res.json("query10");
  }
}

const indexController = new Controllers();

export default indexController;
