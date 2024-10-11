import express from "express";
import bodyParser from "body-parser";
import pg from "pg";
import axios from "axios";

const port=4000; //port
const app=express();

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

//configuring the postgres database
const db = new pg.Client({
    user:"postgres",
    password:"sahan123",
    port:5432,
    database:"world",
    host:"localhost"
});

//connecting to the database
db.connect();

//sending the user datas initially
app.get("/initial-get", async(req,res)=>{
    try{
    const all_user_query= await db.query("SELECT users.user_id, users.first_name, users.last_name, users.color FROM users ORDER BY user_id DeSC");
    const first_user_id = all_user_query.rows[0].user_id;
    const all_user_data = all_user_query.rows;
    try{
        const firstUser_country_query = await db.query("SELECT user_id, country_code from visited_countries WHERE user_id = $1",[first_user_id]);
        const first_user_country = firstUser_country_query.rows;
        res.json({allUsers:all_user_data, first_user_cont:first_user_country})
    }catch(error){
        res.status(500).json({error:'error while fetching initial countries'});
    }
    }catch(error){
       res.status(500).json({error:'error while getting initial users'});
    }
});

//function get info about new-ly added user
async function newUser_data(id) {
    const all_user_query= await db.query("SELECT users.user_id, users.first_name, users.last_name, users.color FROM users where user_id = $1",[id]);
    return all_user_query.rows;

};

// post request to add new-user to users table 
app.post("/add-user", async(req,res)=>{
    const fname= req.body.fname;
    const lname= req.body.lname;
    const user_color=req.body.favcolor;
    if(fname && lname && user_color){
        try{
            const newUser=await db.query("INSERT INTO users (first_name, last_name, color) values ($1,$2,$3) RETURNING user_id,first_name,last_name,color;",[fname,lname,user_color]); //
            res.json(newUser.rows);
        }catch(error){
            res.status(500).json({error:'there was an error while inserting the data'});
        }
    }else{
        res.status(500).json({error:'all the field are required'});
    }
});

app.post("/get-user/:id", async(req,res)=>{
    const id= req.params.id;
    try{
        const user_data = await db.query("select country_code from visited_countries where user_id = $1",[id]);
        res.json(user_data);
    }catch(error){
        res.status(500).json({error:'there was ane rror while retrieving the data'});
    }
});

//function check country_code
async function checkCode(country_name) {
    try{
    const country_req= await db.query("select country_code from countries where LOWER(country_name) like '%' ||$1||'%'",[country_name]);
    if(country_req.rows.length>0){
        const country_id = country_req.rows[0].country_code;
        return country_id;
    }else{
        throw 'Country Not found';
    } 
    }catch(error){
        return error;
    }
};

//check and then insert
async function checkExist(id,country_code) {
    try{
        const check = await db.query("SELECT * FROM visited_countries WHERE user_id = $1 AND country_code = $2;",[id,country_code]);
        const length = check.rows.length;
        if(length<1){
            try{
                const insert = await db.query("INSERT INTO visited_countries (user_id, country_code) values ($1,$2) RETURNING user_id,country_code",[id,country_code]);
                return insert;
            }catch(error){
                return error;
            }
        }else{
            throw 'Country laready exists';
        }
    }catch(error){
        return error;
    }
    

}

//to add newcountry
app.post("/add-country/:id", async(req,res)=>{
    const id = req.params.id;
    const country_name = req.body.country_name;
    try{
        const country_code = await checkCode(country_name);
        if(country_code.length===2){
            const check = await db.query("SELECT * FROM visited_countries WHERE user_id = $1 AND country_code = $2;",[id,country_code]);
            const length = check.rows.length;
            if(length<1){
                try{
                    const insert = await db.query("INSERT INTO visited_countries (user_id, country_code) values ($1,$2) RETURNING user_id,country_code",[id,country_code]);
                    res.status(200).json(insert.rows);
                }catch(error){
                    
                }
            }else{
                throw 'Country already Exists';
            }
        }else{
            throw 'country not found';
        }    
    }catch(error){
        res.send(error)
    }
})

//listening to port
app.listen(port,()=>{
    console.log("listening to port:",port);
});

