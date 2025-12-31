export function validateVolunteer(data) {
  const errors = [];

  if (!data.name || data.name.trim().length < 3) {
    errors.push('NAME_IS_REQUIRED');
  }

  if (!data.phone || !/^01[0-9]{9}$/.test(data.phone)) {
    errors.push('INVALID_PHONE_NUMBER');
  }

  if (data.status && !['active', 'freezed', 'stopped'].includes(data.status)) {
    errors.push('INVALID_STATUS');
  }

  return {
    isValid: errors.length === 0,
    errors
  };
}
