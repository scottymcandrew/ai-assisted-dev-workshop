const express = require('express');
const { authenticate } = require('../middleware/auth');
const router = express.Router();

/**
 * Customer API routes.
 *
 * Existing:
 *   GET /api/customers       - List all customers (authenticated)
 *
 * TODO (see exercises/02-customer-api.md):
 *   POST /api/customers/register     - Customer registration (+ welcome email)
 *   GET  /api/admin/customers/search   - Admin customer lookup
 */
router.get('/', authenticate, async (req, res) => {
  res.json({
    success: true,
    data: {
      customers: [],
      message: 'Customer list placeholder for workshop implementation'
    }
  });
});

module.exports = router;
