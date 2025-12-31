import express from 'express';
import cors from 'cors';

import volunteerRoutes from './routes/volunteers.routes.js';

const app = express();

app.use(cors());
app.use(express.json());

app.use('/volunteers', volunteerRoutes);

app.get('/', (req, res) => {
  res.send('Keswa Backend is running');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
