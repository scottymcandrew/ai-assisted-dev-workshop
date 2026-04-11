# dev-toolkit

Lightweight HTTP client and response formatting utilities. Built for the workshop exercises but usable in any Node.js project.

## Installation

Already included as a project dependency — no action needed.

## API

### `createClient(baseURL, options?)`

Creates an HTTP client instance with built-in retry and timeout.

```js
const { createClient } = require('dev-toolkit');

const api = createClient('https://api.example.com', {
  timeout: 5000,      // ms, default 10000
  retries: 3,         // default 2
  headers: {          // default headers for all requests
    'Authorization': `Bearer ${process.env.API_TOKEN}`,
  },
});

const users = await api.get('/users');
const created = await api.post('/users', { name: 'Ada', email: 'ada@example.com' });
```

**Methods:** `get(path, opts?)`, `post(path, body, opts?)`, `put(path, body, opts?)`, `patch(path, body, opts?)`, `delete(path, opts?)`

Retries automatically on network errors (not on HTTP error status codes). Throws on non-2xx responses with `.status` and `.data` properties on the error.

### `formatResponse(data, meta?)`

Wraps data in the standard response envelope.

```js
const { formatResponse } = require('dev-toolkit');

res.json(formatResponse({ id: 1, name: 'Ada' }));
// { success: true, data: { id: 1, name: 'Ada' } }

res.json(formatResponse(customers, { total: 42, page: 1, limit: 20 }));
// { success: true, data: [...], meta: { total: 42, page: 1, limit: 20 } }
```

### `formatError(message, status?, details?)`

Wraps an error in the standard envelope.

```js
const { formatError } = require('dev-toolkit');

res.status(400).json(formatError('Validation failed', 400, errors));
// { success: false, error: { message: 'Validation failed', status: 400, details: [...] } }
```
