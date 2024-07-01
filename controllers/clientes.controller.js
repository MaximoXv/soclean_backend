const db = require("../db/db");

const getAllElements = (req,res)=>{
    const sql = `SELECT clientes.id ,clientes.nombre, tipos_de_clientes.tipo_de_cliente AS categoria ,clientes.inicio_contrato,clientes.plazo_contrato,servicios.tipo_de_servicio AS servicio FROM clientes
JOIN tipos_de_clientes ON clientes.fk_tipocliente = tipos_de_clientes.id
JOIN servicios ON clientes.fk_servicio = servicios.id
ORDER BY clientes.id ASC`;
    db.query(sql, (error,rows)=>{
        console.log(rows);
        if(error){
            console.log(error);
            return res.status(500).json({
                error: "Intente mas tarde"
            });
        }
        res.json(rows)
    })
}

const getElementById = (req,res)=>{

    const {id} = req.params;

    const sql = `SELECT clientes.id ,clientes.nombre, tipos_de_clientes.tipo_de_cliente AS categoria ,clientes.inicio_contrato,clientes.plazo_contrato,servicios.tipo_de_servicio AS servicio FROM clientes
JOIN tipos_de_clientes ON clientes.fk_tipocliente = tipos_de_clientes.id
JOIN servicios ON clientes.fk_servicio = servicios.id WHERE clientes.id = ?`;
    db.query(sql,[id], (error,rows)=>{
        console.log(rows);
        if(error){
            console.log(error);
            return res.status(500).json({
                error: "Intente mas tarde"
            });
        }

        if(rows.length === 0){
            return res.status(404).json({ message: "No existe"})
        }

        res.json(rows[0])
    })
}


const createClient = (req,res)=>{

    const {nombre,fk_tipocliente,inicio_contrato,plazo_contrato,fk_servicio} = req.body;

    const sql = 'INSERT INTO clientes (nombre,fk_tipocliente,inicio_contrato,plazo_contrato,fk_servicio) VALUES (?,?,?,?,?)';
    db.query(sql,[nombre,fk_tipocliente,inicio_contrato,plazo_contrato,fk_servicio], (error,result)=>{
        console.log(result);
        if(error){
            console.log(error);
            return res.status(500).json({
                error: "Intente mas tarde"
            });
        }

        const cliente = {...req.body, id: result.insertId};

        res.json(cliente);
    })
}

const updateClient = (req,res)=>{
    const {id} = req.params;    
    const {nombre,fk_tipocliente,inicio_contrato,plazo_contrato,fk_servicio} = req.body;

    const sql = 'UPDATE clientes SET nombre = ?, fk_tipocliente = ?, inicio_contrato = ?,plazo_contrato = ?, fk_servicio = ? WHERE id = ?';
    db.query(sql,[nombre,fk_tipocliente,inicio_contrato,plazo_contrato,fk_servicio,id], (error,result)=>{
        console.log(result);
        if(error){
            console.log(error);
            return res.status(500).json({
                error: "Intente mas tarde"
            });
        }

        if(result.affectedRows === 0){
            return res.status(404).json({ message: "No existe"})
        }

        const cliente = {...req.body, ...req.params};

        res.json(cliente);
    })
}

const deleteClient = (req,res)=>{
    const {id} = req.params;

    const sql = 'DELETE FROM clientes WHERE id = ?';
    db.query(sql,[id], (error,result)=>{
        console.log(result);
        if(error){
            console.log(error);
            return res.status(500).json({
                error: "Intente mas tarde"
            });
        }

        if(result.affectedRows === 0){
            return res.status(404).json({ message: "No existe"})
        }


        res.json({message: "Registro borrado"});
    })
}


module.exports = {
    getAllElements,getElementById, createClient, updateClient,deleteClient
}