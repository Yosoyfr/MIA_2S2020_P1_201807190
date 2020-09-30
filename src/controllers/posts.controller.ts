import { Request, Response } from "express";

import { connect } from "../database";

//Interface
import { Post } from "../interfaces/Post";

export async function getPosts(req: Request, res: Response): Promise<Response> {
  const conn = await connect();
  const posts = await conn.query("SELECT * FROM posts");
  return res.json(posts[0]);
}

export async function createPost(req: Request, res: Response) {
  const newPost: Post = req.body;
  const conn = await connect();
  await conn.query("INSERT INTO posts SET ?", [newPost]);
  return res.json({
    message: "Post Created",
  });
}
