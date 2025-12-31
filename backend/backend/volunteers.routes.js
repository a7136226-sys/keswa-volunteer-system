import express from 'express';
import { addVolunteer, listVolunteers } from '../controllers/volunteers.controller.js';

const router = express.Router();

/**
 * POST /volunteers
 * إضافة متطوع جديد
 */
router.post('/', addVolunteer);

/**
 * GET /volunteers
 * جلب كل المتطوعين
 */
router.get('/', listVolunteers);

export default router;
