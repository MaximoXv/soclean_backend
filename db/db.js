const mysql = require("mysql2");

const connection = mysql.createConnection({
    host: process.env.MYSQL_ADDON_HOST,
    user: process.env.MYSQL_ADDON_USER,
    password: process.env.MYSQL_ADDON_PASSWORD,
    database: process.env.MYSQL_ADDON_DB,
});

connection.connect((error)=>{
    if(error){
        return console.log(error);
    }
    console.log("Conectados");
});

module.exports = connection;