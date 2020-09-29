import express, { Application } from "express";
import morgan from "morgan";
import cors from "cors";

//Routes
import indexRoutes from "./routes/index.routes";

export class App {
  app: Application;

  constructor(private port?: number | string) {
    this.app = express();
    this.settings();
    this.middleware();
    this.routes();
  }

  private settings() {
    this.app.set("port", this.port || process.env.PORT || 3000);
  }

  private middleware() {
    this.app.use(morgan("dev"));
    this.app.use(cors());
    this.app.use(express.urlencoded({ extended: false }));
    this.app.use(express.json());
  }

  private routes() {
    this.app.use(indexRoutes);
  }

  async listen(): Promise<void> {
    await this.app.listen(this.app.get("port"));
    console.log("Server on port", this.app.get("port"));
  }
}
