const express = require("express");
const app = express();
const clientesRouter = require("./routes/clientes.router.js");

const path = require("path");

// Middleware para archivos estáticos y públicos
app.use(express.static(path.join(__dirname, "public")));

app.use(express.urlencoded({ extended: false}))
app.use(express.json());


app.use("/clientes",clientesRouter)

// Ruta principal, la pagina de inicio
// http://localhost:3000/
app.get("/", (req, res) => {
  res.send("Hola Express");
});




const PORT = 3000;

app.listen(PORT, () => console.log(`http://localhost:${PORT}`));
