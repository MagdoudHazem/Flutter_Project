const mysql=require('mysql');
const express=require('express');
var app=express();
const bodyparser=require('body-parser');
app.use(bodyparser.json());
const multer = require('multer');
const async = require('async');
var fs = require('fs');
var querystring = require('querystring');
const moveFile = require('move-file');
const STRIPE_SDK =require('stripe') ;
const stripe = new STRIPE_SDK('sk_test_51HiP5qEeiXZxYalekyUwZpX4OwgcU40yz028bFBHvkWak0utA1wvIz5MVQOynDr7iCJ2KrtCowhBMKkjT1GauxPa00ksxYAeW8');
app.use(bodyparser.urlencoded({
    limit: "50mb",
    extended: false
  }));
  app.use(bodyparser.json({limit: "50mb"}));
 
var mysqlConnection=mysql.createConnection({
    host:'localhost',
    user :'root',
    password:'',
    database:'flutterecom'



});

mysqlConnection.connect((err)=>
{
    if(!err){
        console.log('DB coonection succeed');
    }
    else console.log('DBconnection failed');

} 
);
app.listen(3000,()=>console.log('Express server is running at port 3000'))

app.get('/user',(req,res)=>{
    mysqlConnection.query('SELECT * FROM user',(err,rows,fields)=>{
        if(!err){
        res.send(rows);
        for (let p of rows)
        {
            console.log(p.id);

        }

    }
        else {
        console.log(err); }

    })
})

app.get('/user/:id',(req,res)=>
{
    mysqlConnection.query('SELECT * FROM user WHERE id = ?',[req.params.id],(err,rows,fields)=>
    {
        if(!err)
        res.send(rows)
        else
        console.log(err);


    })
})
app.get('/user/byemail/:email',(req,res)=>
{
    mysqlConnection.query('SELECT * FROM user WHERE email = ?',[req.params.email],(err,rows,fields)=>
    {
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})


app.delete('/user/:id',(req,res)=>{
    mysqlConnection.query('DELETE FROM user WHERE id = ?',[req.params.id],(err,rows,fields)=>
    {
        if(!err)
        res.send('Deleted successfuly');
        else
        console.log(err);
    })
})
app.post('/user/add',async (req,res)=>
{
    let u=req.body
    var readfile =Buffer.from(req.body.image,"base64");
  fs.writeFileSync(req.body.filename,readfile,"utf8");

    await moveFile('./'+req.body.filename, './uploads/'+req.body.filename);
   // console.log(req);
    var sql ="INSERT INTO user (nom,email,mobile,mdp,country,image) VALUES (?,?,?,?,?,?)" ;
    mysqlConnection.query(sql,[u.nom,u.email,u.mobile,u.mdp,u.country,"uploads/"+u.filename],(err)=>{
        if(!err){
        res.setHeader('Content-Type', 'application/json');
        res.send(JSON.stringify({ "success": 1 , "message" : " user added successfully" },undefined,2));   }     
        else  
        console.log(err); 
    })

})
app.post('/user/update',  (req, res)  =>{
    console.log(req.body);
    sql='UPDATE user SET  nom = ? , email = ? ,mobile = ? , mdp = ? , country = ? , image = ?   WHERE id = ?';
    
 mysqlConnection.query(sql, [req.body.nom,req.body.email,req.body.mobile,req.body.mdp,req.body.country,req.body.image,req.body.id], (error, results) =>{
    console.log(req.body) 
    if (error) throw error;
	  res.end(JSON.stringify(results));
	});
});

/***** upload image*/
app.get('/myproduct/:iduser',(req,res)=>
{
    mysqlConnection.query('SELECT * FROM produit WHERE iduser = ?',[req.params.iduser],(err,rows,fields)=>
    {
        if(!err)
        res.send(rows)
        else
        console.log(err);


    })
})
app.post('/produit/add' ,async (req,res)=>
{
 
  var readfile =Buffer.from(req.body.image,"base64");
  fs.writeFileSync(req.body.filename,readfile,"utf8");
  
    await moveFile('./'+req.body.filename, './uploads/'+req.body.filename);
    console.log('The file has been moved');

    let u=req.body
    var sql ="INSERT INTO produit (nom,category,description,prix,stock,iduser,image) VALUES (?,?,?,?,?,?,?)" ;

    mysqlConnection.query(sql,[u.nom,u.category,u.description,u.prix,u.stock,u.iduser,"uploads/"+u.filename],(err)=>{
        if(!err){
        res.setHeader('Content-Type', 'application/json');
        res.send(JSON.stringify({ "success": 1 , "message" : " user added successfully" },undefined,2));   }     
        else  
        console.log(err); 
        
    })

})
 
app.post ('/stripe',async (req,res)=>
{
    stripe.charges.create({
        email:"magdoudhazem@gmailcom",
        source: 'pk_test_51HiP5qEeiXZxYalefQZEm9HtGIk0ogZaZsS2uF8FBCvqVP7lEy63cE0iQxuuMgPXyYHkGUb8BV4HSaeUkXOLKuYT00vihv46VL',
        amount: req.body.amount ,// in cents,
        currency: 'usd',
        description: 'Any description about the payment',
       /* metadata:{
            key: value // any meta-data you want to store
        }*/
    }, (err, charge) => {
        if(err) {
           console.log(err);
        } else {
           console.log(charge);
        }
    })

})

app.use('/uploads', express.static('./uploads'));
/*************** */
