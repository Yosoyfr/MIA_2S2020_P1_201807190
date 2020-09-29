import { Request, Response } from "express";

export function indexWelcome(req: Request, res: Response) {
  res.json("Welcome to my API");
}
