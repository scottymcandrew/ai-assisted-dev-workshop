/**
 * dev-toolkit — lightweight HTTP client and response helpers.
 *
 * Usage:
 *   const { createClient, formatResponse } = require('dev-toolkit');
 *   const api = createClient('https://api.example.com');
 *   const data = await api.get('/users');
 */

const DEFAULT_TIMEOUT = 10_000;
const DEFAULT_RETRIES = 2;
const RETRY_DELAY = 500;

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function createClient(baseURL, options = {}) {
  const {
    timeout = DEFAULT_TIMEOUT,
    retries = DEFAULT_RETRIES,
    headers: defaultHeaders = {},
  } = options;

  async function request(method, path, body, reqOptions = {}) {
    const url = `${baseURL.replace(/\/+$/, '')}${path}`;
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);

    const fetchOptions = {
      method,
      headers: {
        'Content-Type': 'application/json',
        ...defaultHeaders,
        ...reqOptions.headers,
      },
      signal: controller.signal,
    };

    if (body !== undefined && method !== 'GET') {
      fetchOptions.body = JSON.stringify(body);
    }

    let lastError;
    for (let attempt = 0; attempt <= retries; attempt++) {
      try {
        const response = await fetch(url, fetchOptions);
        clearTimeout(timer);

        const contentType = response.headers.get('content-type') || '';
        const data = contentType.includes('application/json')
          ? await response.json()
          : await response.text();

        if (!response.ok) {
          const err = new Error(`HTTP ${response.status}: ${response.statusText}`);
          err.status = response.status;
          err.data = data;
          throw err;
        }

        return data;
      } catch (err) {
        lastError = err;
        clearTimeout(timer);
        if (attempt < retries && !err.status) {
          await sleep(RETRY_DELAY * (attempt + 1));
        } else {
          throw lastError;
        }
      }
    }

    throw lastError;
  }

  return {
    get: (path, opts) => request('GET', path, undefined, opts),
    post: (path, body, opts) => request('POST', path, body, opts),
    put: (path, body, opts) => request('PUT', path, body, opts),
    patch: (path, body, opts) => request('PATCH', path, body, opts),
    delete: (path, opts) => request('DELETE', path, undefined, opts),
  };
}

function formatResponse(data, meta = {}) {
  return {
    success: true,
    data,
    ...(Object.keys(meta).length > 0 ? { meta } : {}),
  };
}

function formatError(message, status = 500, details = null) {
  return {
    success: false,
    error: { message, status, ...(details ? { details } : {}) },
  };
}

module.exports = { createClient, formatResponse, formatError };
