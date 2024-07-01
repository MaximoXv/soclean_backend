const express = require("express");
const app = express();
const clientesRouter = require("./routes/clientes.router.js");
const dotenv = require('dotenv');
dotenv.config();

const path = require("path");

const PORT = process.env.MYSQL_ADDON_PORT || 3000;


app.use(express.static(path.join(__dirname, "public")));

app.use(express.urlencoded({ extended: false}))
app.use(express.json());


app.use("/clientes",clientesRouter)


app.get("/", (req, res) => {
  res.send("Hola Express");
});





app.listen(PORT, () => console.log(`http://localhost:${PORT}`));
