import express, { Application } from "express";
import morgan from "morgan";
import cors from "cors";

//Routes
import indexRoutes from "./routes/index.routes";
import modelRoutes from "./routes/model.routes";
import postRoutes from "./routes/posts.routes";

export class App {
  app: Application;

  constructor(private port?: number | string) {
    this.app = express();
    this.settings();
    this.middleware();
    this.routes();
  }

  private settings(): void {
    this.app.set("port", this.port || process.env.PORT || 3000);
  }

  private middleware(): void {
    this.app.use(morgan("dev"));
    this.app.use(cors());
    this.app.use(express.urlencoded({ extended: false }));
    this.app.use(express.json());
  }

  private routes(): void {
    this.app.use(indexRoutes);
    this.app.use(modelRoutes);
    this.app.use("/posts", postRoutes);
  }

  start(): void {
    this.app.listen(this.app.get("port"), () => {
      console.log("Server on port", this.app.get("port"));
    });
  }
}
