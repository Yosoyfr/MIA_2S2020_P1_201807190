import { Router } from "express";
const router = Router();

import { getPosts, createPost } from "../controllers/posts.controller";

router.route("/").get(getPosts).post(createPost);

export default router;
