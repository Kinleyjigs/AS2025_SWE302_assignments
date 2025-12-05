import http from 'k6/http';
import { check, sleep } from 'k6';
import { BASE_URL } from './config.js';

export const options = {
  stages: [
    { duration: '2m', target: 50 },     // Ramp up
    { duration: '30m', target: 50 },    // Stay at load for 30 minutes (reduced from 3 hours)
    { duration: '2m', target: 0 },      // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500', 'p(99)<1000'],
    http_req_failed: ['rate<0.01'],
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

  // Realistic user behavior
  http.get(`${BASE_URL}/articles`, authHeaders);
  sleep(3);

  http.get(`${BASE_URL}/tags`, authHeaders);
  sleep(2);
}

export function teardown(data) {
  // Cleanup if needed
}
