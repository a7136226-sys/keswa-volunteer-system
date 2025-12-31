import { createVolunteer, getAllVolunteers } from '../services/volunteers.service.js';
import { validateVolunteer } from '../validators/volunteers.schema.js';

/**
 * إضافة متطوع
 */
export async function addVolunteer(req, res) {
  try {
    const validation = validateVolunteer(req.body);

    if (!validation.isValid) {
      return res.status(400).json({
        error: 'VALIDATION_ERROR',
        details: validation.errors
      });
    }

    const volunteer = await createVolunteer(req.body);

    res.status(201).json({
      message: 'Volunteer created successfully',
      data: volunteer
    });
  } catch (err) {
    res.status(500).json({
      error: 'SERVER_ERROR',
      message: err.message
    });
  }
}

/**
 * جلب كل المتطوعين
 */
export async function listVolunteers(req, res) {
  try {
    const volunteers = await getAllVolunteers();

    res.status(200).json(volunteers);
  } catch (err) {
    res.status(500).json({
      error: 'SERVER_ERROR',
      message: err.message
    });
  }
        }
