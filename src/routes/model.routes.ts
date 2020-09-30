import { Router } from "express";
const router = Router();

import temporaryController from "../controllers/model.controller";

router.route("/eliminarTemporal").get(temporaryController.deleteTemporaryTable);
router.route("/eliminarModelo").get(temporaryController.deleteModel);

router
  .route("/cargarTemporal")
  .get(temporaryController.loadDataInTemporaryTable);
router.route("/cargarModelo").get(temporaryController.loadDataInModel);

export default router;
