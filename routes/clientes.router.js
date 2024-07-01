const express = require("express");
const router = express.Router();

const controller = require("../controllers/clientes.controller");


router.get("/", controller.getAllElements);


router.get("/:id", controller.getElementById);

router.post("/", controller.createClient)


router.put("/:id", controller.updateClient)


router.delete("/:id", controller.deleteClient)


module.exports = router;