import { supabase } from '../supabase.js';

/**
 * إنشاء متطوع جديد
 */
export async function createVolunteer(volunteerData) {
  const { data, error } = await supabase
    .from('volunteers')
    .insert([volunteerData])
    .select()
    .single();

  if (error) {
    throw new Error(error.message);
  }

  return data;
}

/**
 * جلب كل المتطوعين
 */
export async function getAllVolunteers() {
  const { data, error } = await supabase
    .from('volunteers')
    .select('*')
    .order('created_at', { ascending: false });

  if (error) {
    throw new Error(error.message);
  }

  return data;
    }
