import { Router } from "express";
const router = Router();

import indexController from "../controllers/index.controller";

router.route("/").get(indexController.indexWelcome);

router.route("/consulta1").get(indexController.query1);
router.route("/consulta2").get(indexController.query2);
router.route("/consulta3").get(indexController.query3);
router.route("/consulta4").get(indexController.query4);
router.route("/consulta5").get(indexController.query5);
router.route("/consulta6").get(indexController.query6);
router.route("/consulta7").get(indexController.query7);
router.route("/consulta8").get(indexController.query8);
router.route("/consulta9").get(indexController.query9);
router.route("/consulta10").get(indexController.query10);

export default router;
