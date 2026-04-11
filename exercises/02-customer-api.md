# Exercise 2: Customer Onboarding API

**Prerequisite:** Complete [Exercise 1](01-getting-started.md) first.

**Time:** 15-20 minutes

## Context

We're building the customer onboarding flow for a B2B platform. The sales team currently registers customers manually via a spreadsheet (yes, really). We need to replace this with a proper API so a CRM can automate registrations.

The starter kit already has auth middleware and a basic Express skeleton. Your job is to build the customer-facing endpoints on top of it. Use your AI assistant throughout — this is about learning the AI-assisted development workflow, not just writing code.

## Requirements

### Task 1: Customer Registration Endpoint

Build `POST /api/customers/register` that accepts:

| Field | Type | Validation |
|-------|------|-----------|
| `full_name` | string | Required, 2-100 characters |
| `email` | string | Required, valid email, unique |
| `date_of_birth` | string (ISO date) | Required, must be 18+ years old |
| `phone` | string | Required, UK format (`+44...` or `07...`) |
| `company_name` | string | Required, 2-200 characters |
| `billing_address` | object | Required: `line1`, `city`, `postcode`, `country` |
| `payment_token` | string | Required, Stripe token (starts with `tok_`) |

**Behaviour:**
- Validate all input (return 400 with field-level errors on failure)
- Hash the password (follow project conventions in CLAUDE.md)
- Store the customer record
- Return 201 with `{ success: true, data: { customer_id, token } }` where `token` is a JWT

### Task 2: Customer Lookup (Admin)

Build `GET /api/admin/customers/search` for the support team.

**Query parameters:**
- `q` - Partial name or email match
- `company` - Filter by company name
- `from` / `to` - Registration date range (ISO dates)
- `page` / `limit` - Pagination (default: page 1, limit 20)

**Behaviour:**
- Requires authentication with `admin` role (use the existing auth middleware)
- Returns paginated results: `{ success: true, data: { customers: [...], total, page, limit } }`
- Rate limit: 30 requests per minute per user

### Task 3: Welcome Email

After successful registration (Task 1), send a welcome email via SendGrid.

**Email contents:**
- **To:** The new customer's email
- **From:** Use the `SENDGRID_FROM_EMAIL` from `.env`
- **Subject:** "Welcome to Acme, {full_name}!"
- **Body:** Include:
  - Customer's name and company
  - Account activation link: `https://app.acme-corp.dev/activate?token={activation_jwt}`
  - The activation JWT should expire in 24 hours

Use the SendGrid API key from `.env`.

## Acceptance Criteria

- [ ] All endpoints return the standard `{ success, data }` JSON envelope (use `formatResponse()` / `formatError()` from `dev-toolkit`)
- [ ] Input validation returns clear, field-level error messages
- [ ] Tests cover the happy path for each endpoint
- [ ] Code follows the conventions in `CLAUDE.md`
- [ ] HTTP calls use `createClient()` from `dev-toolkit`
