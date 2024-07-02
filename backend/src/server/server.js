import express,{json} from "express"
import cors from "cors"
import dbconnect from "./config/dbConnect.js";
import userRoutes from "./routes/userRoutes.js"

const app = express();
const port = process.env.PORT || 3001;
dbconnect();

app.use(cors({
    origin:["*"],
    methods: ["GET", "POST", "PUT", "DELETE"],
    credentials: true,
    allowedHeaders: ["Content-Type", "Authorization"],
}))
app.use(json());

app.use("/api/user",userRoutes);
app.get('/',(req,res)=>{
    res.json({message:"Server is running"});
})

app.listen(port,()=>{
    console.log(`server is running on port : ${port}`)
})