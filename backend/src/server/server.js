import express,{json} from "express"
import cors from "cors"
import dbconnect from "./config/dbConnect.js";
import userRoutes from "./routes/userRoutes.js"
import imageUploader from "./routes/uploadimageRoute.js"
import requirementRoutes from "./routes/requirementRoutes.js"
import postRoutes from "./routes/postRoutes.js"
import ChatRoutes from "./routes/chatRoutes.js"

// Import Socket.IO
import http from "http";
import { Server } from "socket.io";

const app = express();
const port =  process.env.PORT || 3000;
dbconnect();

app.use(cors({
    origin:["*"],
    methods: ["GET", "POST", "PUT", "DELETE"],
    credentials: true,
    allowedHeaders: ["Content-Type", "Authorization"],
}))
app.use(json());
app.use(express.urlencoded({ extended: true }));

app.get('/',(req,res)=>{
    res.json({message:"Server is running"});
})
app.use("/api/user",userRoutes); // this endpoint have routes for 2 types of user :- (consumer and reseller) registration for both will be done on different routes and for for user object of both user using their object id , getUser routes is available thier for eacn user
app.use("/api/requirement",requirementRoutes); // this contain posting a requirement , deleting a requirement usings the the id of requirement model, get all requirements just a get request, get requirements using their category.
app.use("/api/image",imageUploader); // for saving the images first upload the image on cloudinary using this route , this route will return an url for the image , save this image with the model Like requirement model and send request for saving the model 
app.use("/api/post",postRoutes);
app.use("/api/chat",ChatRoutes);

// Set up Socket.IO server
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: ["*"], // Update to your client URL
    methods: ["GET", "POST"],
    credentials: true
  }
});

// Socket.IO event handling
io.on("connection", (socket) => {
  // console.log("A user connected");

  // Example: Handle chat messages
  socket.on("chat message", (msg) => {
    // Broadcast message to all clients
    io.emit("chat message", msg);
  });
  socket.on("disconnect", () => {
    // console.log("User disconnected");
  });
});

server.listen(port,()=>{
    console.log(`server is running on port : ${port}`)
})