import { Router } from "express";
import { getConnection } from "../db.js";

const router = Router();

router.get("/", async (req, res) => {
  const db = await getConnection();
  const [rows] = await db.query("SELECT NOW() AS server_time");
  res.json({ message: "API funcionando!", db_time: rows[0].server_time });
});

export default router;
