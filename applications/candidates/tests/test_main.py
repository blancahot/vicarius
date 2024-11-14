import unittest
from applications.candidates.main import app

class TestApp(unittest.TestCase):
    def setUp(self):
        self.client = app.test_client()

    def test_get_candidates(self):
        response = self.client.get('/candidates')
        self.assertEqual(response.status_code, 200)

    def test_create_candidate(self):
        response = self.client.post('/candidates', json={
            'name': 'Test User',
            'email': 'test@example.com'
        })
        self.assertEqual(response.status_code, 201)

if __name__ == '__main__':
    unittest.main()