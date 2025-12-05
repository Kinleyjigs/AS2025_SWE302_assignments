import http from 'k6/http';
import { check } from 'k6';
import { BASE_URL } from './config.js';

export const options = {
  stages: [
    { duration: '10s', target: 10 },    // Normal load
    { duration: '30s', target: 10 },    // Stable
    { duration: '10s', target: 500 },   // Sudden spike!
    { duration: '3m', target: 500 },    // Stay at spike
    { duration: '10s', target: 10 },    // Back to normal
    { duration: '3m', target: 10 },     // Recovery period
    { duration: '10s', target: 0 },     // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<3000'], // Very relaxed threshold for spike
    http_req_failed: ['rate<0.2'],     // Allow up to 20% errors during spike
  },
};

export function setup() {
  // Setup: Create test user and get token
  const loginRes = http.post(`${BASE_URL}/users/login`, JSON.stringify({
    user: {
      email: 'test@example.com',
      password: 'password'
    }
  }), {
    headers: { 'Content-Type': 'application/json' }
  });

  return { token: loginRes.json('user.token') };
}

export default function (data) {
  const authHeaders = {
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Token ${data.token}`
    }
  };

  const response = http.get(`${BASE_URL}/articles`, authHeaders);
  check(response, {
    'status is 200': (r) => r.status === 200,
  });
}

export function teardown(data) {
  // Cleanup if needed
}
