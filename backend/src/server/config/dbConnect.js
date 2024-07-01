import {connect as _connect, connect} from "mongoose"
import asyncHandler from "express-async-handler"
import dotenv from "dotenv"

dotenv.config();

const dbconnect = asyncHandler(async()=>{
    try{
        const dbconnected = await _connect(`${process.env.MONGODB_URI}`);
        if(dbconnected){
            console.log("DB is connected",dbconnected.connection.host,dbconnected.connection.name);
        }
    }catch(err){
        console.log("Problem in db Connection",err);
        process.exit(1);
    }
});

export default dbconnect;