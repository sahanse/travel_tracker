import express from "express";
import bodyParser from "body-parser";
import axios from "axios";

const port =3000;
const app=express();
const apiUrl='http://localhost:4000';

app.use(express.static("public"));
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

//to store the data received from root
let rootData=null;

//to store the new_user-data
let newUser=null;

//initial get state
app.get("/", async(req,res)=>{
    try{
        const initial_get= await axios.get(apiUrl+'/initial-get');
        const userData = initial_get.data.allUsers;
        const first_user_cont = initial_get.data.first_user_cont;
        const user_fname = userData[0].first_name;
        const user_lname = userData[0].last_name;
        const user_id= userData[0].user_id;
        const user_name = `${user_fname} ${user_lname}`;
        const country_total= first_user_cont.length;
        const country_arr = [];
        const color = userData[0].color;
        first_user_cont.forEach((country)=>{
            country_arr.push(country.country_code);
        });
        res.render("index.ejs",{
            users_data:userData,
            countries:country_arr,
            curr_user_name:user_name,
            curr_total:country_total,
            user_id:user_id,
            color:color,
            
            all_user:true,
        });
        rootData=userData;
    }catch(error){
        res.render("index.ejs")
    }
});

//for redirecting to new user form
app.get("/add-user",(req,res)=>{
    res.render("new-user.ejs");
});


//post request to create new user
app.post("/add-new-user", async(req,res)=>{
    const fname = req.body.fname;
    const lname =req.body.lname;
    const favcolor =req.body.favcolor;
    if(fname && lname && favcolor){
        try{
            const adding_user = await axios.post(apiUrl + '/add-user',req.body);
            const new_user_data= adding_user.data;
            try{
                const user_fname = new_user_data[0].first_name;
                const user_lname = new_user_data[0].last_name;
                const user_name = `${user_fname} ${user_lname}`;
                const country_total= 0;
                const color = new_user_data[0].color;
                const user_id = new_user_data[0].user_id;
                res.redirect("/")
            }catch(error){
                res.status(500).json({error:'there was an error'});
            }
        }catch(error){
            res.status(500).json({error:'error while inserting the data from client'})
        }
    }else{
       res.status(500).json({error:'blocked by client side validation'});
    }
});

app.get("/home",(req,res)=>{
    res.redirect("/");
});

//getting user specific choosen data
app.get("/get-user/:id",async(req,res)=>{
    const id = req.params.id;
    try{
        const get_data_id = await axios.post(apiUrl+`/get-user/${id}`);
        const received_data=get_data_id.data.rows;
        const user_data = rootData;
        let user_fname = null;
        let user_lname = null;
        let user_name = null;
        let country_arr = [];
        let country_total= received_data.length;
        let  color =null;
        let error_data="enter country name";
        if(req.query.error){
            error_data=req.query.error;
        };
        
        console.log("the error is:",error_data)
        await received_data.forEach((code)=>{
            country_arr.push(code.country_code);
        });

       await user_data.forEach((user)=>{
            if(user.user_id==id){
                user_fname=user.first_name;
                user_lname=user.last_name;
                user_name=`${user_fname} ${user_lname}`;
                color=user.color;
            }
        });
        res.render("index.ejs",{
            users_data:user_data,
            countries:country_arr,
            curr_user_name:user_name,
            curr_total:country_total,
            user_id:id,
            color:color,
            add_true:true,
            all_user:true,
            root_page:true,
            new_error:error_data
        });
    }catch(error){
        console.log(error)
    }
});

//for adding new country while creating new user
app.post("/new-country/:id", async(req,res)=>{
    const id = req.params.id;
    const country_name= req.body.country_name.toLowerCase();
    try{
        const adding_req = await axios.post(apiUrl+`/add-country/${id}`,{
            country_name:country_name
        });
        
        const type=typeof adding_req.data;
        if(type=="string"){
            const data= adding_req.data;
            const getUserResponse = await axios.get(`http://localhost:3000/get-user/${id}?error=${data}`);
            res.send(getUserResponse.data);
        }else{
            const getUserResponse = await axios.get(`http://localhost:3000/get-user/${id}`);
            res.send(getUserResponse.data);
        }
        
    }catch(error){

    }
})

//listening to the port
app.listen(port,(req,res)=>{
    console.log("listening to port:",port);
});

